from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from picking.models import PickingList
from delivery.models import DeliveryOrder, LogisticsApprovalRequest
from packing.models import PackingList, PackingCost
import traceback

@receiver(pre_save, sender=PickingList)
def validate_picking_status_transition(sender, instance, **kwargs):
    """
    Signal handler to validate picking status transitions and update picked_date.
    Ensures that:
    1. Status cannot jump from 'Not Started' directly to 'Completed' (must go through 'In Progress')
    2. Updates picked_date when status changes to 'Completed'
    """
    try:
        # Only run this for existing objects (not on creation)
        if instance.pk:
            # Get the current state from the database before changes
            current_status = PickingList.objects.get(pk=instance.picking_list_id).picked_status
            new_status = instance.picked_status

            # If status is changing to 'Completed'
            if new_status == 'Completed' and current_status != new_status:
                # Check if previous status was 'In Progress'
                if current_status != 'In Progress':
                    raise ValidationError("Picking list status cannot change directly from 'Not Started' to 'Completed'. It must first be set to 'In Progress'.")

                # Update picked_date when status changes to 'Completed'
                instance.picked_date = timezone.now().date()
                print(f"Updated picked_date to {instance.picked_date} for picking list {instance.picking_list_id}")

    except PickingList.DoesNotExist:
        # This is a new instance, no validation needed
        pass
    except Exception as e:
        print(f"Error validating picking status transition: {str(e)}")
        raise

# Removed set_warehouse_for_picking_list signal handler as warehouse selection
# is now handled by the module sending the delivery request

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

                            # Update each relevant delivery note to 'Pending' status (ready for packing/shipping)
                            for delivery_note_id in delivery_note_ids:
                                cursor.execute("""
                                    UPDATE sales.delivery_note
                                    SET shipment_status = 'Pending'
                                    WHERE delivery_note_id = %s
                                """, [delivery_note_id])

                                print(f"Updated delivery note {delivery_note_id} status to 'Pending' (ready for packing)")

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
    Update the delivery note status when a shipment status changes.
    Called from the shipping module when a shipment is updated.
    Valid statuses: 'Failed', 'Pending', 'Shipped', 'Delivered'
    
    For partial deliveries, also handles the sequential processing of delivery notes.
    """
    # Ensure the provided status is valid
    valid_statuses = ['Failed', 'Pending', 'Shipped', 'Delivered']
    if status not in valid_statuses:
        print(f"Error: Invalid status '{status}' provided to update_delivery_note_status. Must be one of {valid_statuses}")
        return

    try:
        with connection.cursor() as cursor:
            # Find any delivery notes associated with this shipment
            cursor.execute("""
                SELECT dn.delivery_note_id, dn.order_id
                FROM sales.delivery_note dn
                WHERE dn.shipment_id = %s
            """, [shipment_id])

            results = cursor.fetchall()
            if not results:
                print(f"No delivery notes found for shipment {shipment_id}")
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
                        
                        # Count how many delivery notes have been shipped or delivered
                        cursor.execute("""
                            SELECT COUNT(delivery_note_id)
                            FROM sales.delivery_note
                            WHERE order_id = %s AND shipment_status IN ('Shipped', 'Delivered')
                        """, [order_id])
                        
                        completed_notes = cursor.fetchone()[0]
                        print(f"{completed_notes} of {delivery_note_count} delivery notes have been shipped or delivered")
                        
                        # If there are still notes to process, find the next one in sequence
                        if completed_notes < delivery_note_count:
                            # Find all currently shipped/delivered notes
                            cursor.execute("""
                                SELECT delivery_note_id
                                FROM sales.delivery_note
                                WHERE order_id = %s AND shipment_status IN ('Shipped', 'Delivered')
                            """, [order_id])
                            
                            processed_notes = [row[0] for row in cursor.fetchall()]
                            
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
                                else:
                                    print(f"Next delivery note {next_delivery_note_id} was already in 'Pending' status")
                            else:
                                print(f"No next delivery note found for order {order_id} - all notes may be in 'Pending' or 'Processing' status")
                        else:
                            print(f"All delivery notes for order {order_id} have been shipped or delivered")

    except Exception as e:
        print(f"Error updating delivery note status for shipment {shipment_id}: {str(e)}")
        import traceback
        traceback.print_exc()