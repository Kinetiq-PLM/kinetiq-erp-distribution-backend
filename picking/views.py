# picking/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import PickingList, PickingItem
from .serializers import PickingListSerializer, PickingItemSerializer
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from distribution_backend.permissions import IsAuthenticatedOrDevelopment

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_view(request):
    """
    Get all picking lists.
    """
    picking_lists = PickingList.objects.all().order_by('-picking_list_id')
    serializer = PickingListSerializer(picking_lists, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_detail(request, pk):
    """
    Get details of a specific picking list.
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingListSerializer(picking_list)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_update(request, pk):
    """
    Update a picking list.
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        with transaction.atomic():
            # Block any attempts to update warehouse_id - warehouse should be set by the module sending the request
            if 'warehouse_id' in request.data:
                return Response(
                    {"error": "Cannot update warehouse. The warehouse is determined by the module sending the delivery request."},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Handle status transition validation
            current_status = picking_list.picked_status
            new_status = request.data.get('picked_status', current_status)
            
            # Validate status transition
            if (current_status == 'Not Started' and new_status == 'Completed'):
                return Response(
                    {"error": "Picking list status cannot change directly from 'Not Started' to 'Completed'. It must first be set to 'In Progress'."},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Update picked_date if status is changing to 'Completed'
            if new_status == 'Completed' and current_status != 'Completed':
                request.data['picked_date'] = timezone.now().date().isoformat()
            
            serializer = PickingListSerializer(picking_list, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except ValidationError as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def employee_list(request):
    """
    Get a list of employees for the picker assignment dropdown.
    Filtered to only show employees from HR department with specific position.
    """
    try:
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT employee_id, first_name, last_name
                FROM human_resources.employees
                WHERE status = 'Active'
                AND position_id = 'REG-2504-faa8'
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
def warehouse_list(request):
    """
    Get a list of warehouses for display purposes.
    """
    try:
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT warehouse_id, warehouse_location
                FROM admin.warehouse
                ORDER BY warehouse_location
            """)
            columns = [col[0] for col in cursor.description]
            warehouses = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            # Format the response to match expected format
            formatted_warehouses = []
            for warehouse in warehouses:
                formatted_warehouses.append({
                    'id': warehouse['warehouse_id'],
                    'name': warehouse['warehouse_location']
                })
                
            return Response(formatted_warehouses)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@permission_classes([IsAuthenticatedOrDevelopment])
def create_picking_items(request, pk):
    """
    Create picking items for a picking list based on its items_details
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Get items_details
    serializer = PickingListSerializer(picking_list)
    items_details = serializer.data.get('items_details', [])
    
    # Create picking items
    created_count = 0
    for item in items_details:
        # Skip if already exists
        if PickingItem.objects.filter(
            picking_list=picking_list,
            inventory_item_id=item.get('inventory_item_id')
        ).exists():
            continue
            
        PickingItem.objects.create(
            picking_list=picking_list,
            inventory_item_id=item.get('inventory_item_id', ''),
            item_name=item.get('item_name', ''),
            item_no=item.get('item_no', ''),
            quantity=item.get('quantity', 0),
            warehouse_id=item.get('warehouse_id', ''),
            warehouse_name=item.get('warehouse_name', ''),
            delivery_note_id=item.get('delivery_note_id', '')  # Store the delivery note ID
        )
        created_count += 1
    
    return Response({"created": created_count}, status=status.HTTP_201_CREATED)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def update_picking_item(request, pk):
    """
    Update a picking item status
    """
    try:
        picking_item = PickingItem.objects.get(pk=pk)
    except PickingItem.DoesNotExist:
        return Response({"error": "Picking item not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingItemSerializer(picking_item, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        
        # Check if all items are picked and update list status if necessary
        picking_list = picking_item.picking_list
        items = PickingItem.objects.filter(picking_list=picking_list)
        all_picked = all(item.is_picked for item in items)
        
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_items(request, pk):
    """
    Get all picking items for a picking list
    """
    try:
        picking_items = PickingItem.objects.filter(picking_list_id=pk)
    except PickingItem.DoesNotExist:
        return Response({"error": "No picking items found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingItemSerializer(picking_items, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def delivery_notes_info(request, order_id):
    """
    Get information about partial deliveries for a sales order.
    """
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 1
                FROM sales.orders
                WHERE order_id = %s
            """, [order_id])
            
            if not cursor.fetchone():
                return Response({"error": "Sales order not found"}, status=status.HTTP_404_NOT_FOUND)
                
            cursor.execute("""
                SELECT 
                    delivery_note_id,
                    shipment_status,
                    created_at,
                    shipment_id,
                    statement_id,
                    admin_override,
                    admin_override_reason,
                    admin_override_date,
                    ROW_NUMBER() OVER (ORDER BY created_at) as sequence_number
                FROM sales.delivery_note
                WHERE order_id = %s
                ORDER BY created_at
            """, [order_id])
            
            columns = [col[0] for col in cursor.description]
            notes = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            if len(notes) <= 1:
                return Response({
                    "is_partial_delivery": False,
                    "delivery_notes": notes
                })
                
            # Count completed deliveries (Shipped or Delivered)
            completed = sum(1 for note in notes 
                           if note.get('shipment_status') in ('Shipped', 'Delivered'))
            
            # For each delivery note, get the items count
            for note in notes:
                statement_id = note.get('statement_id')
                if statement_id:
                    cursor.execute("""
                        SELECT COUNT(*), SUM(quantity)
                        FROM sales.statement_item
                        WHERE statement_id = %s
                    """, [statement_id])
                    
                    item_counts = cursor.fetchone()
                    if item_counts:
                        note['item_count'] = item_counts[0] or 0
                        note['total_quantity'] = item_counts[1] or 0
                    else:
                        note['item_count'] = 0
                        note['total_quantity'] = 0
            
            # Find the current delivery - the first note with status NULL or 'Pending'
            current_delivery = next((i+1 for i, n in enumerate(notes) 
                                    if n.get('shipment_status') in (None, 'Pending')),
                                   completed + 1)
                
            response_data = {
                "is_partial_delivery": True,
                "total_deliveries": len(notes),
                "completed_deliveries": completed,
                "current_delivery": current_delivery,
                "delivery_notes": notes
            }
            
            return Response(response_data)
            
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
@permission_classes([IsAuthenticatedOrDevelopment])
def force_next_delivery(request, order_id):
    """
    Force the processing of the next partial delivery in sequence.
    This endpoint is used to:
    1. Mark the current delivery note as shipped with admin override
    2. Set the next delivery note to pending
    3. Create a new picking list for the next batch
    """
    try:
        # Get the necessary data from the request
        admin_override_reason = request.data.get('override_reason')
        admin_username = request.user.username if hasattr(request, 'user') and request.user.is_authenticated else 'system'
        
        if not admin_override_reason:
            return Response({"error": "Override reason is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        with transaction.atomic():
            # Find the current active delivery note
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery_note_id
                    FROM sales.delivery_note
                    WHERE order_id = %s 
                    AND (shipment_status = 'Picking' OR shipment_status = 'Picked' OR shipment_status = 'Packing')
                    ORDER BY created_at ASC
                    LIMIT 1
                """, [order_id])
                
                current_note = cursor.fetchone()
                
                # If no active note found, try to find a pending one
                if not current_note:
                    cursor.execute("""
                        SELECT delivery_note_id
                        FROM sales.delivery_note
                        WHERE order_id = %s
                        AND (shipment_status IS NULL OR shipment_status = 'Pending')
                        ORDER BY created_at ASC
                        LIMIT 1
                    """, [order_id])
                    current_note = cursor.fetchone()
                
                # If found, mark it as shipped with admin override
                if current_note:
                    current_delivery_note_id = current_note[0]
                    
                    # Update the status
                    cursor.execute("""
                        UPDATE sales.delivery_note
                        SET shipment_status = 'Shipped',
                            admin_override = %s,
                            admin_override_reason = %s,
                            admin_override_date = NOW()
                        WHERE delivery_note_id = %s
                    """, [admin_username, admin_override_reason, current_delivery_note_id])
                    
                    # Find the next delivery note
                    cursor.execute("""
                        SELECT delivery_note_id, COUNT(*) OVER() as total_notes
                        FROM sales.delivery_note
                        WHERE order_id = %s
                        AND shipment_status NOT IN ('Shipped', 'Delivered')
                        ORDER BY created_at ASC
                        LIMIT 1
                    """, [order_id])
                    
                    next_note = cursor.fetchone()
                    if next_note:
                        next_delivery_note_id = next_note[0]
                        
                        # Set the next one to pending
                        cursor.execute("""
                            UPDATE sales.delivery_note
                            SET shipment_status = 'Pending'
                            WHERE delivery_note_id = %s
                        """, [next_delivery_note_id])
                        
                        # Find approval request ID for this order
                        cursor.execute("""
                            SELECT approval_request_id
                            FROM distribution.logistics_approval_request lar
                            JOIN distribution.delivery_order do ON lar.del_order_id = do.del_order_id
                            WHERE do.sales_order_id = %s
                            LIMIT 1
                        """, [order_id])
                        
                        approval_request_result = cursor.fetchone()
                        if approval_request_result:
                            approval_request_id = approval_request_result[0]
                            
                            # Generate a unique picking list ID
                            import uuid
                            from django.utils import timezone
                            new_picking_list_id = f"DIS-PICK-{timezone.now().strftime('%Y')}-{uuid.uuid4().hex[:8]}"
                            
                            # Create a new picking list for the next batch
                            cursor.execute("""
                                INSERT INTO distribution.picking_list
                                (picking_list_id, warehouse_id, picked_by, picked_status, approval_request_id)
                                VALUES (%s, %s, NULL, 'Not Started', %s)
                            """, [
                                new_picking_list_id,
                                None,  # warehouse_id will be determined by the items
                                approval_request_id
                            ])
                            
                            return Response({
                                "success": True, 
                                "message": f"Delivery note {current_delivery_note_id} marked as shipped. Next delivery note {next_delivery_note_id} set to pending and new picking list {new_picking_list_id} created.",
                                "next_delivery_note_id": next_delivery_note_id,
                                "new_picking_list_id": new_picking_list_id
                            })
                        else:
                            return Response({
                                "success": True, 
                                "message": f"Delivery note {current_delivery_note_id} marked as shipped and next delivery note {next_delivery_note_id} set to pending, but couldn't create new picking list due to missing approval request.",
                                "next_delivery_note_id": next_delivery_note_id
                            })
                    else:
                        # No more delivery notes to process
                        return Response({
                            "success": True, 
                            "message": f"Delivery note {current_delivery_note_id} marked as shipped. This was the final delivery note for order {order_id}."
                        })
                else:
                    return Response({
                        "success": False, 
                        "message": "No active or pending delivery notes found for this order."
                    }, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)