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
    
    # First, create the basic picking items based on the provided details
    items_created = []
    with transaction.atomic():
        # Delete any existing items for this picking list
        PickingItem.objects.filter(picking_list_id=pk).delete()
        
        # Create new items
        for item_detail in items_details:
            item = PickingItem(
                picking_list=picking_list,
                inventory_item_id=item_detail.get('inventory_item_id'),
                item_name=item_detail.get('item_name', 'Unknown Item'),
                item_no=item_detail.get('item_no', ''),
                quantity=item_detail.get('quantity', 0),
                warehouse_id=item_detail.get('warehouse_id', ''),
                warehouse_name=item_detail.get('warehouse_name', 'Unknown Warehouse'),
                delivery_note_id=item_detail.get('delivery_note_id')
            )
            item.save()
            items_created.append(item)
    
    # Check if we need to populate missing item or warehouse information
    missing_info = any(
        not item.item_name or item.item_name == 'Unknown Item' or 
        not item.warehouse_name or item.warehouse_name == 'Unknown Warehouse' or
        item.item_name is None or item.warehouse_name is None
        for item in items_created
    )
    
    if missing_info:
        with connection.cursor() as cursor:
            # Step 1: Get the delivery note IDs from the picking items
            delivery_note_ids = [
                item.delivery_note_id for item in items_created 
                if item.delivery_note_id is not None
            ]
            
            if delivery_note_ids:
                # Step 2: For each delivery note, fetch the statement ID
                for delivery_note_id in set(delivery_note_ids):
                    cursor.execute("""
                        SELECT statement_id FROM sales.delivery_note 
                        WHERE delivery_note_id = %s
                    """, [delivery_note_id])
                    
                    statement_result = cursor.fetchone()
                    if statement_result and statement_result[0]:
                        statement_id = statement_result[0]
                        
                        # Step 3: Get item and warehouse information from the statement_item's inventory_item_id
                        cursor.execute("""
                            SELECT 
                                si.inventory_item_id,
                                imd.item_name,
                                ii.item_no,
                                ii.warehouse_id,
                                w.warehouse_location
                            FROM sales.statement_item si
                            JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                            JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                            JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                            WHERE si.statement_id = %s
                        """, [statement_id])
                        
                        item_info_map = {}
                        for row in cursor.fetchall():
                            inventory_item_id, item_name, item_no, warehouse_id, warehouse_location = row
                            item_info_map[inventory_item_id] = {
                                'item_name': item_name,
                                'item_no': item_no,
                                'warehouse_id': warehouse_id,
                                'warehouse_name': warehouse_location
                            }
                        
                        # Step 4: Update picking items with the missing information
                        for item in items_created:
                            if item.delivery_note_id == delivery_note_id and item.inventory_item_id in item_info_map:
                                info = item_info_map[item.inventory_item_id]
                                
                                if not item.item_name or item.item_name == 'Unknown Item' or item.item_name is None:
                                    item.item_name = info['item_name']
                                
                                if not item.item_no or item.item_no is None:
                                    item.item_no = info['item_no']
                                
                                if not item.warehouse_id or item.warehouse_id is None:
                                    item.warehouse_id = info['warehouse_id']
                                
                                if not item.warehouse_name or item.warehouse_name == 'Unknown Warehouse' or item.warehouse_name is None:
                                    item.warehouse_name = info['warehouse_name']
                                
                                item.save()
    
    # Add special handling for content deliveries with missing information
    if missing_info and picking_list.delivery_type == 'content':
        try:
            with connection.cursor() as cursor:
                # Get content ID from picking list's delivery_id
                content_id = picking_list.delivery_id
                
                # Fetch correct item names and warehouse information
                cursor.execute("""
                    SELECT 
                        di.item_id as inventory_item_id,
                        imd.item_name,
                        di.warehouse_id,
                        w.warehouse_location
                    FROM operations.document_items di
                    LEFT JOIN admin.item_master_data imd ON di.item_id = imd.item_id
                    LEFT JOIN admin.warehouse w ON di.warehouse_id = w.warehouse_id
                    WHERE di.content_id = %s
                """, [content_id])
                
                # Create a map of item_id to its information
                item_info_map = {}
                for row in cursor.fetchall():
                    inventory_item_id, item_name, warehouse_id, warehouse_name = row
                    item_info_map[inventory_item_id] = {
                        'item_name': item_name,
                        'warehouse_id': warehouse_id, 
                        'warehouse_name': warehouse_name
                    }
                
                # Update each picking item with the correct information
                for item in items_created:
                    if item.inventory_item_id in item_info_map:
                        info = item_info_map[item.inventory_item_id]
                        item.item_name = info['item_name']
                        item.warehouse_id = info['warehouse_id']
                        item.warehouse_name = info['warehouse_name']
                        item.save()
        except Exception as e:
            print(f"Error updating content delivery item info: {str(e)}")
    
    # Convert to serializer format for response
    items_data = PickingItemSerializer(items_created, many=True).data
    print("DEBUG - Final items being returned:")
    for item in items_created:
        print(f"Item {item.picking_item_id}: name={item.item_name}, warehouse={item.warehouse_name}, delivery_note={item.delivery_note_id}")
    
    return Response(items_data)

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
        
        # Check if we need to populate any missing data
        has_missing_data = any(
            item.item_name is None or 
            item.warehouse_name is None
            for item in picking_items
        )
        
        if has_missing_data:
            # Use raw SQL to get the complete data
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        pi.picking_item_id,
                        pi.inventory_item_id,
                        COALESCE(pi.item_name, imd.item_name, 'Unknown Item') as item_name,
                        COALESCE(pi.item_no, ii.item_no, '') as item_no,
                        pi.quantity,
                        pi.quantity_picked,
                        COALESCE(pi.warehouse_id, ii.warehouse_id, '') as warehouse_id,
                        COALESCE(pi.warehouse_name, w.warehouse_location, 'Unknown Warehouse') as warehouse_name,
                        pi.is_picked,
                        pi.picked_at,
                        pi.picked_by,
                        pi.notes,
                        pi.delivery_note_id,
                        pi.picking_list_id
                    FROM distribution.picking_item pi
                    LEFT JOIN inventory.inventory_item ii ON pi.inventory_item_id = ii.inventory_item_id
                    LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                    LEFT JOIN admin.warehouse w ON COALESCE(pi.warehouse_id, ii.warehouse_id) = w.warehouse_id
                    WHERE pi.picking_list_id = %s
                    ORDER BY pi.picking_item_id
                """, [pk])
                
                columns = [col[0] for col in cursor.description]
                picking_items_data = [
                    {columns[i]: value for i, value in enumerate(row)} 
                    for row in cursor.fetchall()
                ]
                
                # Return the enriched data directly
                return Response(picking_items_data)
        
        # Fall back to the serializer if no missing data
        serializer = PickingItemSerializer(picking_items, many=True)
        return Response(serializer.data)
        
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

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
                    note['item_count'] = item_counts[0] if item_counts else 0
                    note['total_quantity'] = item_counts[1] if item_counts else 0
                else:
                    note['item_count'] = 0
                    note['total_quantity'] = 0
            
            # Find the current delivery - the first note with status NULL or 'Pending'
            current_delivery = next((i+1 for i, n in enumerate(notes) 
                                    if n.get('shipment_status') not in ('Shipped', 'Delivered')),
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
                            JOIN distribution.delivery_order del_ord ON lar.del_order_id = del_ord.del_order_id
                            WHERE del_ord.sales_order_id = %s
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

@api_view(['POST'])
@permission_classes([IsAuthenticatedOrDevelopment])
def create_next_batch_picking_list(request, shipment_id):
    """
    Manually trigger the creation of a picking list for the next batch 
    of a partial delivery after a shipment is marked as shipped.
    """
    try:
        from shipment.signals_shipment import _process_partial_delivery
        new_picking_list_id = _process_partial_delivery(shipment_id)
        
        if new_picking_list_id:
            return Response({
                "success": True, 
                "message": f"Next batch picking list {new_picking_list_id} created successfully"
            })
        else:
            return Response({
                "success": False,
                "message": "No next batch could be created. All delivery notes may be processed or another issue occurred."
            })
            
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

