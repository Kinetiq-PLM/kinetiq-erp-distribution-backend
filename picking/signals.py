from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from picking.models import PickingList
from delivery.models import DeliveryOrder, LogisticsApprovalRequest
from packing.models import PackingList, PackingCost
import traceback
import uuid  # Added missing import

@receiver(pre_save, sender=PickingList)
def validate_picking_status_transition(sender, instance, **kwargs):
    """
    Signal handler to validate picking status transitions and update picked_date.
    Ensures that:
    1. Status cannot jump from 'Not Started' directly to 'Completed' (must go through 'In Progress')
    2. Updates picked_date when status changes to 'Completed'
    3. For partial deliveries, maintains correct status
    """
    try:
        # Only run this for existing objects (not on creation)
        if instance.pk:
            # Get the current state from the database before changes
            current_status = PickingList.objects.get(pk=instance.picking_list_id).picked_status
            new_status = instance.picked_status

            # Check if this is a partial delivery
            is_partial_delivery = False
            try:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT del_ord.is_partial_delivery
                        FROM distribution.picking_list pl
                        JOIN distribution.logistics_approval_request lar ON pl.approval_request_id = lar.approval_request_id
                        JOIN distribution.delivery_order del_ord ON lar.del_order_id = del_ord.del_order_id
                        WHERE pl.picking_list_id = %s AND del_ord.sales_order_id IS NOT NULL
                    """, [instance.picking_list_id])
                    result = cursor.fetchone()
                    is_partial_delivery = result and result[0] == 'Yes'
            except Exception as e:
                print(f"Error checking for partial delivery: {str(e)}")

            # If status is changing to 'Completed'
            if new_status == 'Completed' and current_status != new_status:
                # Check if previous status was 'In Progress'
                if current_status != 'In Progress':
                    raise ValidationError("Picking list status cannot change directly from 'Not Started' to 'Completed'. It must first be set to 'In Progress'.")

                # For partial deliveries, we use a different approach handled in create_packing_data
                # but still update picked_date for the current batch
                instance.picked_date = timezone.now().date()
                print(f"Updated picked_date to {instance.picked_date} for picking list {instance.picking_list_id}")

    except PickingList.DoesNotExist:
        # This is a new instance, no validation needed
        pass
    except Exception as e:
        print(f"Error validating picking status transition: {str(e)}")
        raise

@receiver(post_save, sender=PickingList)
def create_packing_data(sender, instance, **kwargs):
    """
    When a PickingList is marked as 'Completed',
    automatically create associated PackingCost and PackingList
    and update delivery note status for sales orders.
    """
    if instance.picked_status == 'Completed':
        try:
            with transaction.atomic():
                # Use direct SQL to insert PackingCost and get the ID
                with connection.cursor() as cursor:
                    # Generate a unique packing_cost_id
                    cursor.execute("""
                        INSERT INTO packing_cost
                        (material_cost, labor_cost, total_packing_cost)
                        VALUES (0.00, 0.00, 0.00)
                        RETURNING packing_cost_id
                    """)
                    packing_cost_id = cursor.fetchone()[0]

                    # Create PackingList using the generated packing_cost_id
                    cursor.execute("""
                        INSERT INTO packing_list
                        (packed_by, packing_status, packing_type, picking_list_id, packing_cost_id)
                        VALUES (%s, %s, %s, %s, %s)
                        RETURNING packing_list_id
                    """, [
                        instance.picked_by,
                        'Pending', # Initial packing status
                        None,
                        instance.picking_list_id,
                        packing_cost_id
                    ])
                    packing_list_id = cursor.fetchone()[0]

                    # Get the delivery order to determine what to process
                    approval_request = None
                    delivery_order = None
                    try:
                        approval_request = LogisticsApprovalRequest.objects.select_related('del_order').get(approval_request_id=instance.approval_request_id)
                        delivery_order = approval_request.del_order
                    except LogisticsApprovalRequest.DoesNotExist:
                        print(f"Warning: LogisticsApprovalRequest {instance.approval_request_id} not found for PickingList {instance.picking_list_id}")
                        delivery_order = None

                    if delivery_order:
                        # For sales orders, check for partial deliveries and update delivery note status
                        if delivery_order.sales_order_id:
                            # First get the delivery notes associated with this picking list
                            cursor.execute("""
                                SELECT DISTINCT delivery_note_id
                                FROM distribution.picking_item
                                WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                            """, [instance.picking_list_id])

                            delivery_note_ids = [row[0] for row in cursor.fetchall()]
                            
                            if delivery_note_ids:
                                # Update each relevant delivery note to 'Picking' status to indicate it's in the picking process
                                for delivery_note_id in delivery_note_ids:
                                    cursor.execute("""
                                        UPDATE sales.delivery_note
                                        SET shipment_status = 'Picking'
                                        WHERE delivery_note_id = %s
                                    """, [delivery_note_id])

                                    print(f"Updated delivery note {delivery_note_id} status to 'Picking'")
                                    
                                # After completing picking, update the delivery notes to 'Picked' status
                                for delivery_note_id in delivery_note_ids:
                                    cursor.execute("""
                                        UPDATE sales.delivery_note
                                        SET shipment_status = 'Picked'
                                        WHERE delivery_note_id = %s AND shipment_status = 'Picking'
                                    """, [delivery_note_id])
                                    
                                    print(f"Updated delivery note {delivery_note_id} status to 'Picked' (ready for packing)")

                        # Calculate and update total_items_packed
                        total_items = 0

                        # Handle stock transfers (internal)
                        if delivery_order.stock_transfer_id:
                            cursor.execute("""
                                SELECT SUM(quantity)
                                FROM inventory.warehouse_movement_items
                                WHERE movement_id = %s
                            """, [delivery_order.stock_transfer_id])
                            result = cursor.fetchone()
                            if result and result[0] is not None:
                                total_items = int(result[0])
                                print(f"Stock transfer items: {total_items}")

                        # Handle content items (internal)
                        elif delivery_order.content_id:
                            cursor.execute("""
                                SELECT SUM(quantity)
                                FROM operations.document_items
                                WHERE content_id = %s
                            """, [delivery_order.content_id])
                            result = cursor.fetchone()
                            if result and result[0] is not None:
                                total_items = int(result[0])
                                print(f"Content items: {total_items}")

                        # Handle sales orders (external)
                        elif delivery_order.sales_order_id:
                            # For sales orders with partial delivery, only count items in the current delivery note(s)
                            if delivery_note_ids:
                                # Sum quantities from all items linked to the delivery notes processed in this picking list
                                cursor.execute("""
                                    SELECT SUM(pi.quantity)
                                    FROM distribution.picking_item pi
                                    WHERE pi.picking_list_id = %s
                                    AND pi.delivery_note_id IN %s
                                """, [instance.picking_list_id, tuple(delivery_note_ids)])

                                items_result = cursor.fetchone()
                                if items_result and items_result[0] is not None:
                                    total_items = int(items_result[0])
                                    print(f"Partial delivery items count from picking_item: {total_items}")
                            else:
                                # No specific delivery note - standard full order, sum from picking items
                                cursor.execute("""
                                    SELECT SUM(pi.quantity)
                                    FROM distribution.picking_item pi
                                    WHERE pi.picking_list_id = %s
                                """, [instance.picking_list_id])
                                items_result = cursor.fetchone()

                                if items_result and items_result[0] is not None:
                                    total_items = int(items_result[0])
                                    print(f"Full sales order items count from picking_item: {total_items}")

                        # Handle service orders (external)
                        elif delivery_order.service_order_id:
                            # Sum quantities from picking items associated with this picking list
                            cursor.execute("""
                                SELECT SUM(pi.quantity)
                                FROM distribution.picking_item pi
                                WHERE pi.picking_list_id = %s
                            """, [instance.picking_list_id])

                            items_result = cursor.fetchone()
                            if items_result and items_result[0] is not None:
                                total_items = int(items_result[0])
                                print(f"Service order items count from picking_item: {total_items}")

                        # Update packing list with total items only if we found a quantity > 0
                        if total_items > 0:
                            cursor.execute("""
                                UPDATE packing_list
                                SET total_items_packed = %s
                                WHERE packing_list_id = %s
                            """, [total_items, packing_list_id])
                            print(f"Updated total_items_packed to {total_items}")
                    else:
                         print(f"Skipping item count update for PickingList {instance.picking_list_id} as DeliveryOrder was not found.")

                print(f"Created PackingCost and PackingList for PickingList {instance.picking_list_id}")

        except Exception as e:
            print(f"Detailed Error creating packing data for PickingList {instance.picking_list_id}: {str(e)}")
            traceback.print_exc()
            
def update_delivery_note_status(shipment_id, status):
    """
    When a shipment is marked with a status, update delivery notes and prepare next batch.
    This function is called when a shipment status changes, especially when marked as 'Shipped'.
    It updates the delivery notes and prepares the next batch for partial deliveries.
    """
    try:
        with connection.cursor() as cursor:
            # Find all delivery notes associated with this shipment
            cursor.execute("""
                SELECT dn.delivery_note_id, dn.order_id
                FROM sales.delivery_note dn
                WHERE dn.shipment_id = %s
            """, [shipment_id])
            
            results = cursor.fetchall()
            if not results:
                return
            
            # Group delivery notes by order_id to handle each order separately
            delivery_notes_by_order = {}
            for row in results:
                delivery_note_id, order_id = row
                if order_id not in delivery_notes_by_order:
                    delivery_notes_by_order[order_id] = []
                delivery_notes_by_order[order_id].append(delivery_note_id)
            
            # Process each order's delivery notes
            for order_id, delivery_note_ids in delivery_notes_by_order.items():
                # Update each delivery note status
                for delivery_note_id in delivery_note_ids:
                    cursor.execute("""
                        UPDATE sales.delivery_note
                        SET shipment_status = %s
                        WHERE delivery_note_id = %s
                    """, [status, delivery_note_id])
                    
                    print(f"Updated delivery note {delivery_note_id} status to '{status}'")
                
                # If this is a 'Shipped' status, check if this is part of a partial delivery
                # and prepare the next delivery note for processing
                if status == 'Shipped':
                    # Check if this is a partial delivery by counting all delivery notes for this order
                    cursor.execute("""
                        SELECT COUNT(delivery_note_id)
                        FROM sales.delivery_note
                        WHERE order_id = %s
                    """, [order_id])
                    
                    delivery_note_count = cursor.fetchone()[0]
                    
                    if delivery_note_count > 1:
                        print(f"This is a partial delivery ({delivery_note_count} total delivery notes) for order {order_id}")
                        
                        # Find all currently shipped/delivered notes
                        cursor.execute("""
                            SELECT delivery_note_id
                            FROM sales.delivery_note
                            WHERE order_id = %s AND shipment_status IN ('Shipped', 'Delivered')
                        """, [order_id])
                        
                        processed_notes = [row[0] for row in cursor.fetchall()]
                        
                        # If there are still notes to process, find the next one in sequence
                        if len(processed_notes) < delivery_note_count:
                            # Find the next unprocessed note in sequence by creation date
                            placeholders = ','.join(['%s'] * len(processed_notes))
                            query = f"""
                                SELECT delivery_note_id
                                FROM sales.delivery_note
                                WHERE order_id = %s
                                AND delivery_note_id NOT IN ({placeholders})
                                AND (shipment_status IS NULL OR shipment_status = 'Pending' OR shipment_status = 'Failed')
                                ORDER BY created_at ASC
                                LIMIT 1
                            """
                            
                            query_params = [order_id] + processed_notes
                            cursor.execute(query, query_params)
                            
                            next_note_result = cursor.fetchone()
                            if next_note_result:
                                next_delivery_note_id = next_note_result[0]
                                
                                # Set this note to 'Pending' to make it available for picking
                                cursor.execute("""
                                    UPDATE sales.delivery_note
                                    SET shipment_status = 'Pending'
                                    WHERE delivery_note_id = %s
                                    AND (shipment_status IS NULL OR shipment_status = 'Failed')
                                """, [next_delivery_note_id])
                                
                                if cursor.rowcount > 0:
                                    print(f"Set next delivery note {next_delivery_note_id} to 'Pending' for processing")
                                    
                                    # Here we need to create a new picking list for the next batch
                                    # This is the key addition to enable automatic transition to the next batch
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
                                        
                                        print(f"Created new picking list {new_picking_list_id} for next batch of order {order_id}")
                                        
                                        # After creating the new picking list, also populate it with items from the delivery note
                                        if next_delivery_note_id and new_picking_list_id:
                                            try:
                                                # Get the statement_id from the delivery note
                                                cursor.execute("""
                                                    SELECT statement_id
                                                    FROM sales.delivery_note
                                                    WHERE delivery_note_id = %s
                                                """, [next_delivery_note_id])
                                                
                                                statement_result = cursor.fetchone()
                                                if statement_result and statement_result[0]:
                                                    statement_id = statement_result[0]
                                                    
                                                    # Get items from the statement
                                                    cursor.execute("""
                                                        SELECT 
                                                            si.inventory_item_id,
                                                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                                                            ii.item_no,
                                                            si.quantity,
                                                            ii.warehouse_id,
                                                            w.warehouse_location as warehouse_name
                                                        FROM sales.statement_item si
                                                        LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                                                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                                                        LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                                                        WHERE si.statement_id = %s
                                                    """, [statement_id])
                                                    
                                                    item_results = cursor.fetchall()
                                                    for item in item_results:
                                                        inventory_item_id, item_name, item_no, quantity, warehouse_id, warehouse_name = item
                                                        
                                                        cursor.execute("""
                                                            INSERT INTO distribution.picking_item
                                                            (picking_list_id, inventory_item_id, item_name, item_no, quantity, warehouse_id, warehouse_name, delivery_note_id)
                                                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                                                        """, [
                                                            new_picking_list_id,
                                                            inventory_item_id,
                                                            item_name or 'Unknown Item',
                                                            item_no or '',
                                                            quantity or 0,
                                                            warehouse_id or '',
                                                            warehouse_name or '',
                                                            next_delivery_note_id
                                                        ])
                                                    
                                                    print(f"Created {len(item_results)} picking items for new picking list {new_picking_list_id}")
                                            except Exception as e:
                                                print(f"Error creating picking items for new picking list: {str(e)}")
                                                traceback.print_exc()
                                else:
                                    print(f"Next delivery note {next_delivery_note_id} was already in 'Pending' status")
    except Exception as e:
        print(f"Error updating delivery note status for shipment {shipment_id}: {str(e)}")
        import traceback
        traceback.print_exc()

# Register a post-save signal to connect the update_delivery_note_status function with the packing workflow
@receiver(post_save, sender=PackingList)
def handle_packing_completion(sender, instance, **kwargs):
    """
    When a PackingList is marked as 'Shipped', trigger the update of delivery note status
    and prepare the next batch for partial deliveries.
    """
    # Only proceed if the packing status is 'Shipped'
    if instance.packing_status == 'Shipped' and instance.shipment_id:
        try:
            # Call the update_delivery_note_status function with the shipment_id
            update_delivery_note_status(instance.shipment_id, 'Shipped')
            print(f"Triggered update_delivery_note_status for shipment {instance.shipment_id}")
        except Exception as e:
            print(f"Error handling packing completion: {str(e)}")
            traceback.print_exc()