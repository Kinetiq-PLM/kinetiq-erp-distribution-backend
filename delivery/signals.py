from django.db.models.signals import post_save
from django.dispatch import receiver
from delivery.models import LogisticsApprovalRequest, DeliveryOrder
from picking.models import PickingList
from django.db import transaction, connection
from django.utils import timezone
from django.db.models.signals import pre_save
from models.sales_models import DeliveryNote

@receiver(post_save, sender=LogisticsApprovalRequest)
def handle_approval_request_update(sender, instance, **kwargs):
    """
    Signal handler to process approval request changes.
    When approval_status changes to 'Approved', update delivery order and create picking list.
    When approval_status changes to 'Rejected', update delivery order status to 'Rejected'.
    """
    # Proceed based on approval status
    if instance.approval_status in ['Approved', 'Rejected']:
        try:
            with transaction.atomic():
                # Set approval date to current date for both approved and rejected cases
                LogisticsApprovalRequest.objects.filter(
                    approval_request_id=instance.approval_request_id
                ).update(approval_date=timezone.now().date())
                
                # Update the associated delivery order status
                if instance.del_order:
                    # Verify at least one delivery type ID is not null
                    if instance.del_order.sales_order_id or instance.del_order.service_order_id or \
                       instance.del_order.stock_transfer_id or instance.del_order.content_id:
                        
                        if instance.approval_status == 'Approved':
                            # Update order status to Approved
                            DeliveryOrder.objects.filter(del_order_id=instance.del_order.del_order_id).update(
                                order_status='Approved'
                            )
                            
                            # Determine warehouse_id
                            warehouse_id = None
                            if instance.del_order.content_id:
                                with connection.cursor() as cursor:
                                    cursor.execute("""
                                        SELECT warehouse_id 
                                        FROM operations.document_items 
                                        WHERE content_id = %s
                                    """, [instance.del_order.content_id])
                                    result = cursor.fetchone()
                                    warehouse_id = result[0] if result else None
                            
                            elif instance.del_order.stock_transfer_id:
                                with connection.cursor() as cursor:
                                    cursor.execute("""
                                        SELECT source 
                                        FROM inventory.warehouse_movement 
                                        WHERE movement_id = %s
                                    """, [instance.del_order.stock_transfer_id])
                                    result = cursor.fetchone()
                                    warehouse_id = result[0] if result else None
                            
                            # Create new picking list record
                            PickingList.objects.create(
                                picked_status='Not Started',
                                approval_request=instance,
                                warehouse_id=warehouse_id
                            )
                            print(f"Created new picking list for approval request {instance.approval_request_id}")
                        
                        elif instance.approval_status == 'Rejected':
                            # Update order status to Rejected
                            DeliveryOrder.objects.filter(del_order_id=instance.del_order.del_order_id).update(
                                order_status='Rejected'
                            )
                            print(f"Updated delivery order status to Rejected for approval request {instance.approval_request_id}")
        except Exception as e:
            print(f"Error processing approval: {str(e)}")

@receiver(pre_save, sender=DeliveryOrder)
def check_partial_delivery(sender, instance, **kwargs):
    """
    Check if this is a partial delivery by looking for multiple distinct delivery notes
    for the same sales order in the sales.delivery_note table.
    """
    # Only proceed for sales orders
    if not instance.sales_order_id:
        # Ensure default is 'No' if not a sales order or no ID yet
        if instance.is_partial_delivery is None:
             instance.is_partial_delivery = 'No'
        return
        
    try:
        with connection.cursor() as cursor:
            # Count distinct delivery notes for this sales order
            cursor.execute("""
                SELECT COUNT(DISTINCT delivery_note_id)
                FROM sales.delivery_note
                WHERE order_id = %s
            """, [instance.sales_order_id])
            
            count_result = cursor.fetchone()
            count = count_result[0] if count_result else 0
            
            # If there are already multiple distinct delivery notes, it's a partial delivery
            if count > 1:
                instance.is_partial_delivery = 'Yes'
                
                # Also update *other* existing delivery orders for this sales order
                # This handles cases where multiple DeliveryOrder records might exist for the same sales_order_id
                if not kwargs.get('raw', False):  # Skip during fixtures/migrations
                    cursor.execute("""
                        UPDATE distribution.delivery_order
                        SET is_partial_delivery = 'Yes'
                        WHERE sales_order_id = %s AND del_order_id != %s 
                    """, [instance.sales_order_id, instance.del_order_id]) # Exclude the current instance
            else:
                # If count is 0 or 1, explicitly set to 'No'
                instance.is_partial_delivery = 'No'

    except Exception as e:
        print(f"Error in check_partial_delivery signal for {instance.sales_order_id}: {str(e)}")
        # Default to 'No' on error to be safe
        if instance.is_partial_delivery is None:
             instance.is_partial_delivery = 'No'

@receiver(post_save, sender=DeliveryNote)
def update_delivery_order_after_note_creation(sender, instance, created, **kwargs):
    """
    When a new delivery note is created, check if this results in multiple notes
    for the sales order. If so, update the corresponding delivery order(s)
    to mark them as partial deliveries.
    """
    # Ensure order_id exists (it's the link to the sales order)
    if not hasattr(instance, 'order_id') or not instance.order_id:
         print(f"DEBUG: DeliveryNote {instance.delivery_note_id} has no order_id. Skipping partial delivery check.")
         return
        
    # We only care about newly created notes causing the count to exceed 1
    if not created:
        return
    
    try:
        with connection.cursor() as cursor:
            # Count distinct delivery notes for this sales order ID
            cursor.execute("""
                SELECT COUNT(DISTINCT delivery_note_id)
                FROM sales.delivery_note
                WHERE order_id = %s
            """, [instance.order_id])
            
            count_result = cursor.fetchone()
            count = count_result[0] if count_result else 0
            
            # If there are now multiple distinct delivery notes, mark associated orders as partial
            if count > 1:
                updated_rows = cursor.execute("""
                    UPDATE distribution.delivery_order
                    SET is_partial_delivery = 'Yes'
                    WHERE sales_order_id = %s
                """, [instance.order_id])
                if updated_rows > 0:
                    print(f"Updated {updated_rows} delivery order(s) for sales order {instance.order_id} as partial deliveries.")
                else:
                    print(f"DEBUG: Found {count} delivery notes for {instance.order_id}, but no matching delivery orders found to update.")
            else:
                 print(f"DEBUG: Found {count} delivery note(s) for {instance.order_id}. Not marking as partial yet.")

    except Exception as e:
        print(f"Error in update_delivery_order_after_note_creation signal for order {instance.order_id}: {str(e)}")