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

@receiver(post_save, sender=PickingList)
def set_warehouse_for_picking_list(sender, instance, created, **kwargs):
    if created and instance.approval_request and instance.approval_request.del_order:
        try:
            delivery_order = instance.approval_request.del_order
            
            print(f"Delivery Order Details:")
            print(f"Content ID: {delivery_order.content_id}")
            print(f"Stock Transfer ID: {delivery_order.stock_transfer_id}")
            
            if delivery_order.content_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT warehouse_id 
                        FROM operations.document_items 
                        WHERE content_id = %s
                    """, [delivery_order.content_id])
                    result = cursor.fetchone()
                    
                    print(f"Warehouse ID from document_items: {result}")
                    
                    if result and result[0]:
                        PickingList.objects.filter(
                            picking_list_id=instance.picking_list_id
                        ).update(warehouse_id=result[0])
                        print(f"Updated warehouse_id to: {result[0]}")
            
            # Similar block for stock_transfer case
            elif delivery_order.stock_transfer_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT source 
                        FROM inventory.warehouse_movement 
                        WHERE movement_id = %s
                    """, [delivery_order.stock_transfer_id])
                    result = cursor.fetchone()
                    
                    print(f"Warehouse ID from warehouse_movement: {result}")
                    
                    if result and result[0]:
                        PickingList.objects.filter(
                            picking_list_id=instance.picking_list_id
                        ).update(warehouse_id=result[0])
                        print(f"Updated warehouse_id to: {result[0]}")
        
        except Exception as e:
            print(f"Detailed Error: {str(e)}")
            traceback.print_exc()

@receiver(post_save, sender=PickingList)
def create_packing_data(sender, instance, **kwargs):
    """
    When a PickingList is marked as 'Completed', 
    automatically create associated PackingCost and PackingList
    and update total_items_packed for internal deliveries only
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
                        'Pending', 
                        None, 
                        instance.picking_list_id, 
                        packing_cost_id
                    ])
                    packing_list_id = cursor.fetchone()[0]
                
                    # Calculate and update total_items_packed if we have a delivery order
                    if instance.approval_request and instance.approval_request.del_order:
                        delivery_order = instance.approval_request.del_order
                        total_items = 0
                        
                        # Handle stock transfers (internal)
                        if delivery_order.stock_transfer_id:
                            print(f"Processing stock transfer: {delivery_order.stock_transfer_id}")
                            cursor.execute("""
                                SELECT quantity
                                FROM inventory.warehouse_movement
                                WHERE movement_id = %s
                            """, [delivery_order.stock_transfer_id])
                            result = cursor.fetchone()
                            print(f"Stock transfer query result: {result}")
                            if result and result[0]:
                                total_items = result[0]
                                print(f"Stock transfer items: {total_items}")
                            else:
                                print("No stock transfer quantity found")
                        
                        # Handle content items (internal)
                        elif delivery_order.content_id:
                            print(f"Processing content ID: {delivery_order.content_id}")
                            cursor.execute("""
                                SELECT quantity
                                FROM operations.document_items
                                WHERE content_id = %s
                            """, [delivery_order.content_id])
                            result = cursor.fetchone()
                            print(f"Content ID query result: {result}")
                            if result and result[0]:
                                total_items = result[0]
                                print(f"Content items: {total_items}")
                            else:
                                print("No content quantity found")
                                
                        # Handle sales orders (external)
                        elif delivery_order.sales_order_id:
                            print(f"Processing sales order: {delivery_order.sales_order_id}")
                            # First get the statement_id from the sales order
                            cursor.execute("""
                                SELECT statement_id
                                FROM sales.orders
                                WHERE order_id = %s
                            """, [delivery_order.sales_order_id])
                            statement_result = cursor.fetchone()
                            
                            if statement_result and statement_result[0]:
                                statement_id = statement_result[0]
                                print(f"Found statement ID: {statement_id}")
                                
                                # Now get all items from the statement
                                cursor.execute("""
                                    SELECT SUM(quantity), SUM(total_price)
                                    FROM sales.statement_item
                                    WHERE statement_id = %s
                                """, [statement_id])
                                items_result = cursor.fetchone()
                                
                                if items_result and items_result[0]:
                                    total_items = items_result[0]
                                    total_price = items_result[1] if items_result[1] else 0.00
                                    print(f"Sales order items: {total_items}, Total price: {total_price}")
                                else:
                                    print(f"No items found for statement {statement_id}")
                            else:
                                print(f"No statement found for sales order {delivery_order.sales_order_id}")
                        
                        # Handle service orders (external)
                        elif delivery_order.service_order_id:
                            print(f"Processing service order: {delivery_order.service_order_id}")
                            # First get the service_order_item_id from the delivery_order
                            cursor.execute("""
                                SELECT service_order_item_id
                                FROM services.delivery_order
                                WHERE delivery_order_id = %s
                            """, [delivery_order.service_order_id])
                            service_order_item_result = cursor.fetchone()
                            
                            if service_order_item_result and service_order_item_result[0]:
                                service_order_item_id = service_order_item_result[0]
                                print(f"Found service_order_item_id: {service_order_item_id}")
                                
                                # Now get the item_quantity from the service_order_item
                                cursor.execute("""
                                    SELECT item_quantity
                                    FROM services.service_order_item
                                    WHERE service_order_item_id = %s
                                """, [service_order_item_id])
                                item_quantity_result = cursor.fetchone()
                                
                                if item_quantity_result and item_quantity_result[0]:
                                    total_items = item_quantity_result[0]
                                    print(f"Service order item quantity: {total_items}")
                                else:
                                    print(f"No item quantity found for service_order_item {service_order_item_id}")
                            else:
                                print(f"No service_order_item found for service_order {delivery_order.service_order_id}")
                        
                        # Update packing list with total items only if we found a quantity
                        if total_items > 0:
                            cursor.execute("""
                                UPDATE packing_list
                                SET total_items_packed = %s
                                WHERE packing_list_id = %s
                            """, [total_items, packing_list_id])
                            print(f"Updated total_items_packed to {total_items}")
                        else:
                            print(f"No items to pack found for delivery order {delivery_order.del_order_id}")
                
                print(f"Created PackingCost and PackingList for PickingList {instance.picking_list_id}")
        
        except Exception as e:
            print(f"Detailed Error creating packing data: {str(e)}")
            traceback.print_exc()