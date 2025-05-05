# packing/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import PackingList, PackingCost
from .serializers import PackingListSerializer, PackingCostSerializer
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from decimal import Decimal
from distribution_backend.permissions import IsAuthenticatedOrDevelopment

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_view(request):
    """
    Get all packing lists.
    """
    packing_lists = PackingList.objects.all().order_by('-packing_list_id')
    serializer = PackingListSerializer(packing_lists, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_detail(request, pk):
    """
    Get details of a specific packing list.
    """
    try:
        packing_list = PackingList.objects.get(pk=pk)
    except PackingList.DoesNotExist:
        return Response({"error": "Packing list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PackingListSerializer(packing_list)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_update(request, pk):
    """
    Update a packing list.
    """
    try:
        packing_list = PackingList.objects.get(pk=pk)
    except PackingList.DoesNotExist:
        return Response({"error": "Packing list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Extract packed_items_data but keep it separate from serializer validation
    packed_items_data = None
    if 'packed_items_data' in request.data:
        packed_items_data = request.data.pop('packed_items_data')
    
    serializer = PackingListSerializer(packing_list, data=request.data, partial=True)
    if serializer.is_valid():
        # If status changed to Packed, set packing_date
        if request.data.get('packing_status') == 'Packed':
            serializer.validated_data['packing_date'] = timezone.now().date()
            
            # Validate packed quantities against statement items
            if packed_items_data:
                try:
                    serializer.validate_packed_quantities(packing_list, packed_items_data)
                except ValidationError as e:
                    return Response(e.detail, status=status.HTTP_400_BAD_REQUEST)
                
                # Store the packed_items_data
                setattr(packing_list, 'packed_items_data', packed_items_data)
        
        # Ensure total_items_packed is saved correctly by reading it from the request
        if 'total_items_packed' in request.data:
            # Make sure it's properly typed as integer
            serializer.validated_data['total_items_packed'] = int(request.data['total_items_packed'])
        
        serializer.save()
        return Response(serializer.data)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def employee_list(request):
    """
    Get a list of employees for the packer assignment dropdown.
    """
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT employee_id, first_name, last_name
                FROM human_resources.employees
                WHERE status = 'Active'
                ORDER BY last_name, first_name
            """)
            columns = [col[0] for col in cursor.description]
            employees = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            for employee in employees:
                employee['full_name'] = f"{employee['first_name']} {employee['last_name']}"
                
            return Response(employees)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_types(request):
    """
    Get a list of valid packing types.
    """
    try:
        # These are the valid packing types from your enum
        types = [
            {"id": "Box", "name": "Box"},
            {"id": "Bubble Wrap", "name": "Bubble Wrap"},
            {"id": "Crate", "name": "Crate"}
        ]
        return Response(types)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def get_next_partial_delivery(request, order_id):
    """
    Get information about the next partial delivery batch for a given order.
    """
    try:
        with connection.cursor() as cursor:
            # Check if this is a partial delivery
            cursor.execute("""
                SELECT COUNT(*)
                FROM sales.delivery_note
                WHERE order_id = %s
            """, [order_id])
            
            count_result = cursor.fetchone()
            total_notes = count_result[0] if count_result else 0
            
            if total_notes <= 1:
                return Response({"is_partial_delivery": False})
                
            # Get shipped and unshipped delivery notes
            cursor.execute("""
                SELECT 
                    delivery_note_id,
                    shipment_status,
                    created_at,
                    shipment_id,
                    statement_id,
                    ROW_NUMBER() OVER (ORDER BY created_at) as sequence_number
                FROM sales.delivery_note
                WHERE order_id = %s
                ORDER BY created_at
            """, [order_id])
            
            columns = [col[0] for col in cursor.description]
            notes = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            # Find the next unshipped note
            next_note = next((note for note in notes 
                             if note.get('shipment_status') is None or 
                             note.get('shipment_status') != 'Shipped'), None)
                             
            if not next_note:
                return Response({
                    "is_partial_delivery": True,
                    "total_deliveries": total_notes,
                    "completed_deliveries": total_notes,
                    "status": "completed",
                    "message": "All deliveries completed for this order"
                })
                
            # Get the number of completed deliveries
            completed = sum(1 for note in notes 
                           if note.get('shipment_status') == 'Shipped')
                           
            # Get items for the next delivery
            if next_note.get('statement_id'):
                cursor.execute("""
                    SELECT 
                        si.inventory_item_id,
                        COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                        si.quantity,
                        ii.warehouse_id,
                        w.warehouse_location as warehouse_name,
                        ii.item_no
                    FROM sales.statement_item si
                    LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                    LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                    LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                    WHERE si.statement_id = %s
                """, [next_note.get('statement_id')])
                
                item_columns = [col[0] for col in cursor.description]
                items = [dict(zip(item_columns, row)) for row in cursor.fetchall()]
                next_note['items'] = items
                
            return Response({
                "is_partial_delivery": True,
                "total_deliveries": total_notes,
                "completed_deliveries": completed,
                "current_delivery": next_note.get('sequence_number'),
                "current_delivery_note": next_note,
                "delivery_notes": notes,
                "status": "in_progress",
                "message": f"Processing delivery {next_note.get('sequence_number')} of {total_notes}"
            })
            
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)