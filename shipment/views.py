# shipment/views.py
from django.http import JsonResponse
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import (
    Carrier, Customers, ShippingCost, OperationalCost, 
    FailedShipment, ShipmentDetails, DeliveryReceipt
)
from .serializers import (
    CarrierSerializer, CustomerSerializer, ShippingCostSerializer,
    OperationalCostSerializer, FailedShipmentSerializer,
    ShipmentDetailsSerializer, DeliveryReceiptSerializer
)
from django.db import transaction, connection
from distribution_backend.permissions import IsAuthenticatedOrDevelopment
from django.utils import timezone
from decimal import Decimal
import traceback

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def shipment_list(request):
    """
    Get all shipments.
    """
    shipments = ShipmentDetails.objects.all().order_by('-shipment_id')
    serializer = ShipmentDetailsSerializer(shipments, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def shipment_detail(request, pk):
    """
    Get details of a specific shipment.
    """
    try:
        shipment = ShipmentDetails.objects.get(pk=pk)
    except ShipmentDetails.DoesNotExist:
        return Response({"error": "Shipment not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = ShipmentDetailsSerializer(shipment)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def shipment_update(request, pk):
    """
    Update a shipment.
    """
    try:
        shipment = ShipmentDetails.objects.get(pk=pk)
    except ShipmentDetails.DoesNotExist:
        return Response({"error": "Shipment not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        with transaction.atomic():
            updates = request.data
            
            # Update carrier if provided
            if 'carrier_id' in updates:
                shipment.carrier_id = updates['carrier_id']
                shipment.save()
            
            # Update shipping cost if provided
            if 'shipping_cost' in updates:
                shipping_cost_data = updates['shipping_cost']
                try:
                    shipping_cost = ShippingCost.objects.get(pk=shipment.shipping_cost_id)
                    
                    # Update fields
                    if 'weight_kg' in shipping_cost_data:
                        shipping_cost.weight_kg = Decimal(str(shipping_cost_data['weight_kg']))
                    
                    if 'distance_km' in shipping_cost_data:
                        shipping_cost.distance_km = Decimal(str(shipping_cost_data['distance_km']))
                    
                    if 'cost_per_kg' in shipping_cost_data:
                        shipping_cost.cost_per_kg = Decimal(str(shipping_cost_data['cost_per_kg']))
                    
                    if 'cost_per_km' in shipping_cost_data:
                        shipping_cost.cost_per_km = Decimal(str(shipping_cost_data['cost_per_km']))
                    
                    if 'total_shipping_cost' in shipping_cost_data:
                        shipping_cost.total_shipping_cost = Decimal(str(shipping_cost_data['total_shipping_cost']))
                    else:
                        # Calculate total if not provided
                        shipping_cost.total_shipping_cost = (
                            shipping_cost.weight_kg * shipping_cost.cost_per_kg +
                            shipping_cost.distance_km * shipping_cost.cost_per_km
                        )
                    
                    shipping_cost.save()
                    
                except ShippingCost.DoesNotExist:
                    return Response(
                        {"error": "Associated shipping cost record not found"},
                        status=status.HTTP_404_NOT_FOUND
                    )
            
            # Update additional_cost in operational_cost if provided
            if 'additional_cost' in updates:
                try:
                    with connection.cursor() as cursor:
                        cursor.execute("""
                            SELECT operational_cost_id
                            FROM distribution.operational_cost
                            WHERE shipping_cost_id = %s
                        """, [shipment.shipping_cost_id])
                        result = cursor.fetchone()
                        
                        if result and result[0]:
                            operational_cost_id = result[0]
                            
                            operational_cost = OperationalCost.objects.get(pk=operational_cost_id)
                            operational_cost.additional_cost = Decimal(str(updates['additional_cost']))
                            
                            # The total_operational_cost will be updated by the signal
                            operational_cost.save()
                except Exception as e:
                    return Response(
                        {"error": f"Error updating operational cost: {str(e)}"},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR
                    )
            
            # Get the updated record
            updated_shipment = ShipmentDetails.objects.get(pk=pk)
            serializer = ShipmentDetailsSerializer(updated_shipment)
            return Response(serializer.data)
            
    except Exception as e:
        print(f"Error updating shipment: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def shipment_ship(request, pk):
    """
    Mark a shipment as shipped.
    """
    try:
        shipment = ShipmentDetails.objects.get(pk=pk)
    except ShipmentDetails.DoesNotExist:
        return Response({"error": "Shipment not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Check if the shipment is in a valid state to be shipped
    if shipment.shipment_status != 'Pending':
        return Response(
            {"error": "Only shipments with 'Pending' status can be marked as shipped"},
            status=status.HTTP_400_BAD_REQUEST
        )
    
    try:
        with transaction.atomic():
            # Update the shipment status to 'Shipped'
            shipment.shipment_status = 'Shipped'
            shipment.shipment_date = timezone.now().date()
            
            # Set estimated arrival 2 days from now
            shipment.estimated_arrival_date = timezone.now().date() + timezone.timedelta(days=2)
            shipment.save()
            
            # The signals.py will take care of:
            # 1. Creating a delivery receipt
            # 2. Updating packing_list status to 'Shipped'
            # 3. Updating sales.shipping_details if this is a sales order
            
            # Get the updated record
            updated_shipment = ShipmentDetails.objects.get(pk=pk)
            serializer = ShipmentDetailsSerializer(updated_shipment)
            return Response(serializer.data)
            
    except Exception as e:
        print(f"Error shipping shipment: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def shipment_fail(request, pk):
    """
    Mark a shipment as failed.
    """
    try:
        shipment = ShipmentDetails.objects.get(pk=pk)
    except ShipmentDetails.DoesNotExist:
        return Response({"error": "Shipment not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Check if the shipment is in a valid state to be failed
    if shipment.shipment_status not in ['Pending', 'Shipped']:
        return Response(
            {"error": "Only shipments with 'Pending' or 'Shipped' status can be marked as failed"},
            status=status.HTTP_400_BAD_REQUEST
        )
    
    try:
        failure_reason = request.data.get('failure_reason')
        if not failure_reason or not failure_reason.strip():
            return Response(
                {"error": "A failure reason is required"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        with transaction.atomic():
            # Update the shipment status to 'Failed'
            shipment.shipment_status = 'Failed'
            shipment.save()
            
            # Create or update a failed shipment record
            with connection.cursor() as cursor:
                # Check if a failed shipment record already exists
                cursor.execute("""
                    SELECT failed_shipment_id
                    FROM distribution.failed_shipment
                    WHERE shipment_id = %s
                """, [pk])
                result = cursor.fetchone()
                
                if result and result[0]:
                    # Update existing record
                    failed_shipment_id = result[0]
                    cursor.execute("""
                        UPDATE distribution.failed_shipment
                        SET failure_reason = %s
                        WHERE failed_shipment_id = %s
                    """, [failure_reason, failed_shipment_id])
                else:
                    # Create new record
                    cursor.execute("""
                        INSERT INTO distribution.failed_shipment
                        (failure_date, failure_reason, resolution_status, shipment_id)
                        VALUES (%s, %s, %s, %s)
                        RETURNING failed_shipment_id
                    """, [
                        timezone.now().date(),
                        failure_reason,
                        'Pending',
                        pk
                    ])
                    
                    # The signals will take care of creating a rework order
            
            # Get the updated record
            updated_shipment = ShipmentDetails.objects.get(pk=pk)
            serializer = ShipmentDetailsSerializer(updated_shipment)
            return Response(serializer.data)
            
    except Exception as e:
        print(f"Error failing shipment: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def delivery_receipt_detail(request, pk):
    """
    Get details of a specific delivery receipt.
    """
    try:
        delivery_receipt = DeliveryReceipt.objects.get(pk=pk)
    except DeliveryReceipt.DoesNotExist:
        return Response({"error": "Delivery receipt not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = DeliveryReceiptSerializer(delivery_receipt)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def delivery_receipt_update(request, pk):
    """
    Update a delivery receipt.
    """
    try:
        delivery_receipt = DeliveryReceipt.objects.get(pk=pk)
    except DeliveryReceipt.DoesNotExist:
        return Response({"error": "Delivery receipt not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        # Check if trying to update a receipt that's already received/rejected
        if delivery_receipt.receipt_status in ['Received', 'Rejected']:
            return Response(
                {"error": f"This delivery has already been {delivery_receipt.receipt_status.lower()}. Cannot update."},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        with transaction.atomic():
            serializer = DeliveryReceiptSerializer(delivery_receipt, data=request.data, partial=True)
            if serializer.is_valid():
                # Save will trigger signals that handle:
                # 1. Updating customer received_by for sales orders
                # 2. Creating billing receipt and goods issue for 'Received' status
                # 3. Updating shipping_details status for 'Rejected' status
                serializer.save()
                
                # Ensure the updates are properly applied
                updated = DeliveryReceipt.objects.get(pk=pk)
                response_serializer = DeliveryReceiptSerializer(updated)
                return Response(response_serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        print(f"Error updating delivery receipt: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def carrier_list(request):
    """
    Get a list of all carriers.
    """
    carriers = Carrier.objects.all().order_by('carrier_name')
    serializer = CarrierSerializer(carriers, many=True)
    return Response(serializer.data)

@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticatedOrDevelopment])
def carrier_list_create(request):
    """
    List all carriers or create a new carrier.
    """
    if request.method == 'GET':
        carriers = Carrier.objects.all().order_by('carrier_name')
        serializer = CarrierSerializer(carriers, many=True)
        return Response(serializer.data)
    
    elif request.method == 'POST':
        # Add a carrier_id if one isn't provided
        data = request.data.copy()
        if 'carrier_id' not in data:
            import uuid
            data['carrier_id'] = f"DIS-CAR-{timezone.now().strftime('%Y')}-{uuid.uuid4().hex[:6]}"
        
        serializer = CarrierSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticatedOrDevelopment])
def carrier_detail(request, pk):
    """
    Retrieve, update or delete a carrier.
    """
    try:
        carrier = Carrier.objects.get(pk=pk)
    except Carrier.DoesNotExist:
        return Response({"error": "Carrier not found"}, status=status.HTTP_404_NOT_FOUND)
    
    if request.method == 'GET':
        serializer = CarrierSerializer(carrier)
        return Response(serializer.data)
    
    elif request.method == 'PUT':
        serializer = CarrierSerializer(carrier, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'DELETE':
        # First, check if any shipments are using this carrier
        shipments_count = ShipmentDetails.objects.filter(carrier=carrier).count()
        if shipments_count > 0:
            return Response(
                {"error": f"Cannot delete carrier. It is used by {shipments_count} shipments."},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        carrier.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def failed_shipment_list(request):
    """
    Get a list of all failed shipments.
    """
    failed_shipments = FailedShipment.objects.all().order_by('-failure_date')
    
    # Filter by resolution status if provided
    resolution_status = request.query_params.get('resolution_status')
    if resolution_status:
        failed_shipments = failed_shipments.filter(resolution_status=resolution_status)
    
    # Include related shipment details
    serializer = FailedShipmentSerializer(failed_shipments, many=True)
    
    # Enhance the response with additional shipment information
    response_data = []
    for item in serializer.data:
        shipment_id = item.get('shipment_id')
        if shipment_id:
            # Get associated shipment details
            try:
                shipment = ShipmentDetails.objects.get(pk=shipment_id)
                shipment_serializer = ShipmentDetailsSerializer(shipment)
                item['shipment_details'] = shipment_serializer.data
            except ShipmentDetails.DoesNotExist:
                item['shipment_details'] = None
        
        response_data.append(item)
    
    return Response(response_data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def carrier_employees(request):
    """
    Get a list of employees eligible to be carriers (specific positions only).
    """
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    e.employee_id, 
                    e.first_name || ' ' || e.last_name AS full_name,
                    p.position_title,
                    e.dept_id
                FROM human_resources.employees e
                JOIN human_resources.positions p ON e.position_id = p.position_id
                WHERE e.status = 'Active'
                AND (
                    p.position_title = 'Logistic Support'
                    OR p.position_title = 'Driver'
                    -- Add other eligible positions as needed
                )
                ORDER BY full_name
            """)
            
            columns = [col[0] for col in cursor.description]
            employees = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            return Response(employees)
    except Exception as e:
        print(f"Error in carrier_employees: {str(e)}")
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def customer_detail(request, pk):
    """
    Get customer name by ID using direct SQL query.
    """
    try:
        with connection.cursor() as cursor:
            # Change this query to match your actual database table and column names
            cursor.execute(
                "SELECT customer_id, name FROM sales.customers WHERE customer_id = %s", 
                [pk]
            )
            row = cursor.fetchone()
            
            if row:
                return JsonResponse({
                    'customer_id': row[0],
                    'name': row[1]
                })
            else:
                return JsonResponse({"error": "Customer not found"}, status=404)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)

# Add to views.py
@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def failed_shipments_list(request):
    """
    Get all failed shipments with details.
    """
    try:
        # Get all failed shipments
        failed_shipments = FailedShipment.objects.all()
        
        # Prepare response data with the required structure
        response_data = []
        for fs in failed_shipments:
            if fs.shipment:
                shipment_data = ShipmentDetailsSerializer(fs.shipment).data
                response_data.append({
                    'failed_shipment_id': fs.failed_shipment_id,
                    'failure_date': fs.failure_date,
                    'failure_reason': fs.failure_reason,
                    'resolution_status': fs.resolution_status,
                    'shipment_details': shipment_data
                })
        
        return Response(response_data)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)