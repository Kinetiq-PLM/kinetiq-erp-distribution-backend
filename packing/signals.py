from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from django.core.exceptions import ValidationError
from packing.models import PackingList, PackingCost
from shipment.models import ShippingCost
import traceback
from datetime import date, timedelta  # Added timedelta import
from decimal import Decimal
from shipment.models import ShipmentDetails

@receiver(pre_save, sender=PackingCost)
def calculate_total_packing_cost(sender, instance, **kwargs):
    """
    Automatically calculate total_packing_cost before saving
    """
    instance.total_packing_cost = instance.material_cost + instance.labor_cost

@receiver(pre_save, sender=PackingList)
def validate_packing_status_transition_and_set_date(sender, instance, **kwargs):
    """
    Validates packing status transitions and sets packing_date when status changes to 'Packed'
    """
    try:
        # Only run this for existing objects (not on creation)
        if instance.pk:
            # Get the current state from the database before changes
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT packing_status
                    FROM distribution.packing_list
                    WHERE packing_list_id = %s
                """, [instance.packing_list_id])
                result = cursor.fetchone()
                
                if result:
                    current_status = result[0]
                    new_status = instance.packing_status
                    
                    # If status is changing
                    if new_status != current_status:
                        # Validate transitions
                        if current_status == 'Pending' and new_status == 'Packed':
                            # Set packing_date when changing to 'Packed'
                            instance.packing_date = date.today()
                            print(f"Setting packing_date to {instance.packing_date} for {instance.packing_list_id}")
                        elif current_status == 'Packed' and new_status == 'Shipped':
                            # This is valid - will be set by shipment module
                            pass
                        elif current_status == 'Pending' and new_status == 'Shipped':
                            # Can't skip from Pending to Shipped
                            raise ValidationError("Cannot change status directly from 'Pending' to 'Shipped'. Must first be 'Packed'.")
    except ValidationError:
        raise
    except Exception as e:
        print(f"Error in validate_packing_status_transition: {str(e)}")
        traceback.print_exc()

# Add this new signal to update operational cost when packing cost changes
@receiver(post_save, sender=PackingCost)
def update_operational_cost_from_packing(sender, instance, **kwargs):
    """
    When packing cost is updated, recalculate the associated operational cost
    """
    try:
        with transaction.atomic():
            with connection.cursor() as cursor:
                # Find operational cost record(s) linked to this packing cost
                cursor.execute("""
                    SELECT operational_cost_id, shipping_cost_id, additional_cost
                    FROM distribution.operational_cost
                    WHERE packing_cost_id = %s
                """, [instance.packing_cost_id])
                results = cursor.fetchall()
                
                for result in results:
                    operational_cost_id = result[0]
                    shipping_cost_id = result[1]
                    additional_cost = result[2] or Decimal('0.00')
                    
                    # Get shipping cost if it exists
                    shipping_cost = Decimal('0.00')
                    if shipping_cost_id:
                        cursor.execute("""
                            SELECT total_shipping_cost
                            FROM distribution.shipping_cost
                            WHERE shipping_cost_id = %s
                        """, [shipping_cost_id])
                        shipping_result = cursor.fetchone()
                        shipping_cost = shipping_result[0] if shipping_result and shipping_result[0] else Decimal('0.00')
                    
                    # Calculate new total operational cost
                    total_operational_cost = instance.total_packing_cost + shipping_cost + additional_cost
                    
                    # Update the operational_cost record
                    cursor.execute("""
                        UPDATE distribution.operational_cost
                        SET total_operational_cost = %s
                        WHERE operational_cost_id = %s
                    """, [total_operational_cost, operational_cost_id])
                    
                    print(f"Updated operational_cost_id {operational_cost_id} from packing cost change: total_operational_cost = {total_operational_cost}")
    except Exception as e:
        print(f"Error updating operational_cost from packing cost: {str(e)}")
        traceback.print_exc()

# Add this new signal to calculate shipping cost
@receiver(pre_save, sender=ShippingCost)
def calculate_total_shipping_cost(sender, instance, **kwargs):
    """
    Automatically calculate total_shipping_cost before saving
    """
    # Only recalculate if weight and distance are set
    if instance.weight_kg is not None and instance.distance_km is not None:
        instance.total_shipping_cost = (instance.weight_kg * instance.cost_per_kg) + (instance.distance_km * instance.cost_per_km)

# Add this new signal to update operational cost when shipping cost changes
@receiver(post_save, sender=ShippingCost)
def update_operational_cost(sender, instance, **kwargs):
    """
    When shipping cost is updated, recalculate the associated operational cost
    """
    try:
        with transaction.atomic():
            with connection.cursor() as cursor:
                # First check if an operational_cost record exists for this shipping_cost
                cursor.execute("""
                    SELECT operational_cost_id, packing_cost_id, additional_cost
                    FROM distribution.operational_cost
                    WHERE shipping_cost_id = %s
                """, [instance.shipping_cost_id])
                result = cursor.fetchone()
                
                if result:
                    operational_cost_id = result[0]
                    packing_cost_id = result[1]
                    additional_cost = result[2] or Decimal('0.00')
                    
                    # Get the total_packing_cost
                    cursor.execute("""
                        SELECT total_packing_cost
                        FROM distribution.packing_cost
                        WHERE packing_cost_id = %s
                    """, [packing_cost_id])
                    packing_result = cursor.fetchone()
                    total_packing_cost = packing_result[0] if packing_result else Decimal('0.00')
                    
                    # Calculate new total operational cost
                    total_operational_cost = total_packing_cost + instance.total_shipping_cost + additional_cost
                    
                    # Update the operational_cost record
                    cursor.execute("""
                        UPDATE distribution.operational_cost
                        SET total_operational_cost = %s
                        WHERE operational_cost_id = %s
                    """, [total_operational_cost, operational_cost_id])
                    
                    print(f"Updated operational_cost_id {operational_cost_id}: total_operational_cost = {total_operational_cost}")
                else:
                    print(f"No operational_cost found for shipping_cost_id {instance.shipping_cost_id}")
    
    except Exception as e:
        print(f"Error updating operational_cost: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=PackingList)
def create_shipment_data(sender, instance, **kwargs):
    """
    When a PackingList is marked as 'Packed', 
    automatically create associated ShippingCost, OperationalCost, and ShipmentDetails.
    For partial deliveries, only process items for the current delivery note batch.
    """
    if instance.packing_status == 'Packed':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Get the picking_list_id to find associated delivery notes (for partial deliveries)
                    picking_list_id = instance.picking_list_id
                    delivery_note_ids = []
                    
                    if picking_list_id:
                        # Check if this is a partial delivery by looking for delivery notes
                        cursor.execute("""
                            SELECT DISTINCT delivery_note_id
                            FROM distribution.picking_item
                            WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                        """, [picking_list_id])
                        
                        delivery_note_ids = [row[0] for row in cursor.fetchall()]
                    
                    # First, get the packing_cost_id and total_packing_cost
                    packing_cost_id = instance.packing_cost_id
                    
                    cursor.execute("""
                        SELECT total_packing_cost
                        FROM distribution.packing_cost
                        WHERE packing_cost_id = %s
                    """, [packing_cost_id])
                    result = cursor.fetchone()
                    total_packing_cost = result[0] if result else Decimal('0.00')
                    
                    # Set default values in PHP (Philippine Peso)
                    default_cost_per_kg = Decimal('150.00')
                    default_cost_per_km = Decimal('20.00')
                    
                    # Start with zero weight and distance - will be set via admin
                    initial_weight_kg = Decimal('0.00')
                    initial_distance_km = Decimal('0.00')
                    
                    # Initial shipping cost will be zero
                    initial_shipping_cost = Decimal('0.00')
                    
                    # Generate a unique shipping_cost_id
                    cursor.execute("""
                        INSERT INTO distribution.shipping_cost 
                        (packing_list_id, cost_per_kg, cost_per_km, weight_kg, distance_km, total_shipping_cost)
                        VALUES (%s, %s, %s, %s, %s, %s)
                        RETURNING shipping_cost_id
                    """, [
                        instance.packing_list_id, 
                        default_cost_per_kg,
                        default_cost_per_km,
                        initial_weight_kg,
                        initial_distance_km,
                        initial_shipping_cost
                    ])
                    result = cursor.fetchone()
                    shipping_cost_id = result[0] if result else None
                    
                    if shipping_cost_id is None:
                        raise Exception("Failed to create shipping_cost record")
                        
                    # Default additional cost
                    additional_cost = Decimal('0.00')
                    
                    # Create the operational_cost record
                    total_operational_cost = total_packing_cost + initial_shipping_cost + additional_cost
                    cursor.execute("""
                        INSERT INTO distribution.operational_cost
                        (additional_cost, total_operational_cost, shipping_cost_id, packing_cost_id)
                        VALUES (%s, %s, %s, %s)
                        RETURNING operational_cost_id
                    """, [
                        additional_cost,
                        total_operational_cost,
                        shipping_cost_id,
                        packing_cost_id
                    ])
                    result = cursor.fetchone()
                    operational_cost_id = result[0] if result else None
                    
                    if operational_cost_id is None:
                        raise Exception("Failed to create operational_cost record")

                    # Create ShipmentDetails using the generated shipping_cost_id
                    tracking_number = 'TRK' + instance.packing_list_id[-8:] if len(instance.packing_list_id) >= 8 else 'TRK-' + str(date.today().strftime('%y%m%d'))
                    
                    # Add estimated_arrival_date calculation at creation time
                    shipment_date = date.today()
                    estimated_arrival_date = shipment_date + timedelta(days=2)
                    
                    cursor.execute("""
                        INSERT INTO distribution.shipment_details 
                        (shipment_date, shipment_status, tracking_number, estimated_arrival_date, packing_list_id, shipping_cost_id)
                        VALUES (%s, %s, %s, %s, %s, %s)
                        RETURNING shipment_id
                    """, [
                        shipment_date,
                        'Pending',
                        tracking_number,
                        estimated_arrival_date,
                        instance.packing_list_id,
                        shipping_cost_id
                    ])
                    result = cursor.fetchone()
                    shipment_id = result[0] if result else None
                    
                    if shipment_id is None:
                        raise Exception("Failed to create shipment_details record")
                    
                    # Get the delivery order to determine the order type
                    delivery_type = None
                    delivery_id = None
                    
                    if picking_list_id:
                        cursor.execute("""
                            SELECT lar.approval_request_id, del_order.del_order_id, 
                                   del_order.sales_order_id, del_order.service_order_id, 
                                   del_order.content_id, del_order.stock_transfer_id
                            FROM distribution.picking_list pkl
                            JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                            JOIN distribution.delivery_order del_order ON lar.del_order_id = del_order.del_order_id
                            WHERE pkl.picking_list_id = %s
                        """, [picking_list_id])
                        result = cursor.fetchone()
                        
                        if result:
                            if result[2]:  # sales_order_id
                                delivery_type = "sales"
                                delivery_id = result[2]
                            elif result[3]:  # service_order_id
                                delivery_type = "service"
                                delivery_id = result[3]
                            elif result[4]:  # content_id
                                delivery_type = "content"
                                delivery_id = result[4]
                            elif result[5]:  # stock_transfer_id
                                delivery_type = "stock"
                                delivery_id = result[5]
                    
                    # Handle partial deliveries - specific updates for sales orders
                    if delivery_note_ids and delivery_type == "sales":
                        # 1. Validate packed quantities against statement items
                        for note_id in delivery_note_ids:
                            # Get statement_id for this delivery note
                            cursor.execute("""
                                SELECT statement_id
                                FROM sales.delivery_note
                                WHERE delivery_note_id = %s
                            """, [note_id])
                            statement_result = cursor.fetchone()
                            
                            if statement_result and statement_result[0]:
                                statement_id = statement_result[0]
                                
                                # Get packed items data if available
                                packed_items_data = None
                                if hasattr(instance, 'packed_items_data'):
                                    packed_items_data = instance.packed_items_data
                                
                                # Validate packed quantities against statement_item quantities
                                cursor.execute("""
                                    SELECT si.inventory_item_id, si.quantity
                                    FROM sales.statement_item si
                                    WHERE si.statement_id = %s
                                """, [statement_id])
                                
                                for item_row in cursor.fetchall():
                                    inventory_item_id = item_row[0]
                                    max_quantity = item_row[1]
                                    
                                    # Check packed quantity if we have packed_items_data
                                    if packed_items_data:
                                        # Find this item in packed_items_data
                                        # Note: in a real implementation, you'd need to extract the
                                        # actual packed quantity from your packed_items_data structure
                                        for warehouse_id, warehouse_items in packed_items_data.items():
                                            for dn_id, delivery_note_items in warehouse_items.items():
                                                if dn_id == note_id and inventory_item_id in delivery_note_items:
                                                    packed_qty = delivery_note_items[inventory_item_id].get('packedQuantity', 0)
                                                    if packed_qty > max_quantity:
                                                        raise ValidationError(f"Cannot pack more than available quantity for item {inventory_item_id}")
                        
                        # 2. Update delivery note status to 'Pending' for shipping
                        for note_id in delivery_note_ids:
                            cursor.execute("""
                                UPDATE sales.delivery_note
                                SET shipment_status = 'Pending'
                                WHERE delivery_note_id = %s AND 
                                      (shipment_status IS NULL OR shipment_status != 'Shipped')
                            """, [note_id])
                        
                        # 3. Link shipment ID to delivery notes
                        if shipment_id:
                            for note_id in delivery_note_ids:
                                cursor.execute("""
                                    UPDATE sales.delivery_note
                                    SET shipment_id = %s
                                    WHERE delivery_note_id = %s AND shipment_id IS NULL
                                """, [shipment_id, note_id])
                                
                        # 4. Check if this completes all delivery notes for the order
                        cursor.execute("""
                            SELECT COUNT(*), COUNT(CASE WHEN shipment_id IS NOT NULL THEN 1 END)
                            FROM sales.delivery_note
                            WHERE order_id = %s
                        """, [delivery_id])
                        
                        counts_result = cursor.fetchone()
                        if counts_result and counts_result[0] == counts_result[1]:
                            # All delivery notes are now assigned to shipments
                            # Update order status if needed
                            cursor.execute("""
                                UPDATE sales.orders
                                SET order_status = 'Processing Shipment'
                                WHERE order_id = %s AND order_status = 'Picking'
                            """, [delivery_id])
        
        except Exception as e:
            print(f"CRITICAL ERROR in create_shipment_data: {str(e)}")
            traceback.print_exc()
            
@receiver(post_save, sender=ShipmentDetails)
def handle_shipment_status_changes(sender, instance, **kwargs):
    """
    When a shipment status changes to 'Shipped', update delivery notes
    and prepare the next batch for partial deliveries if applicable.
    """
    if instance.shipment_status == 'Shipped':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # Get the delivery notes associated with this shipment
                    cursor.execute("""
                        SELECT delivery_note_id
                        FROM sales.delivery_note
                        WHERE shipment_id = %s
                    """, [instance.shipment_id])
                    
                    delivery_note_ids = [row[0] for row in cursor.fetchall()]
                    
                    if not delivery_note_ids:
                        return  # No delivery notes to update
                    
                    # Update all delivery notes to 'Shipped'
                    for note_id in delivery_note_ids:
                        cursor.execute("""
                            UPDATE sales.delivery_note
                            SET shipment_status = 'Shipped'
                            WHERE delivery_note_id = %s
                        """, [note_id])
                    
                    # Get the order ID from any of the delivery notes
                    cursor.execute("""
                        SELECT order_id
                        FROM sales.delivery_note
                        WHERE delivery_note_id = %s
                    """, [delivery_note_ids[0]])
                    
                    order_result = cursor.fetchone()
                    if not order_result:
                        return
                    
                    order_id = order_result[0]
                    
                    # Check if there are unshipped delivery notes for this order
                    cursor.execute("""
                        SELECT COUNT(*)
                        FROM sales.delivery_note
                        WHERE order_id = %s AND 
                            (shipment_status IS NULL OR shipment_status != 'Shipped')
                    """, [order_id])
                    
                    count_result = cursor.fetchone()
                    remaining_notes = count_result[0] if count_result else 0
                    
                    if remaining_notes > 0:
                        # There are more delivery notes to process
                        # Find the next unshipped delivery note with the lowest sequence
                        cursor.execute("""
                            SELECT delivery_note_id
                            FROM sales.delivery_note
                            WHERE order_id = %s AND 
                                (shipment_status IS NULL OR shipment_status != 'Shipped')
                            ORDER BY created_at
                            LIMIT 1
                        """, [order_id])
                        
                        next_note_result = cursor.fetchone()
                        if next_note_result:
                            next_note_id = next_note_result[0]
                            
                            # Create a new logistics approval request for the next batch
                            cursor.execute("""
                                SELECT del_order_id
                                FROM sales.delivery_note dn
                                JOIN distribution.logistics_approval_request lar ON dn.order_id = %s
                                JOIN distribution.delivery_order dord ON lar.del_order_id = dord.del_order_id
                                LIMIT 1
                            """, [order_id])
                            
                            del_order_result = cursor.fetchone()
                            if del_order_result:
                                del_order_id = del_order_result[0]
                                
                                # Create approval request for next batch if needed
                                cursor.execute("""
                                    INSERT INTO distribution.logistics_approval_request
                                    (approval_status, approval_date, del_order_id)
                                    VALUES ('Approved', %s, %s)
                                    RETURNING approval_request_id
                                """, [date.today(), del_order_id])
                                
                                approval_result = cursor.fetchone()
                                if approval_result:
                                    approval_request_id = approval_result[0]
                                    
                                    # Create picking list for next batch
                                    cursor.execute("""
                                        INSERT INTO distribution.picking_list
                                        (picked_status, approval_request_id)
                                        VALUES ('Pending', %s)
                                        RETURNING picking_list_id
                                    """, [approval_request_id])
                                    
                                    picking_result = cursor.fetchone()
                                    if picking_result:
                                        picking_list_id = picking_result[0]
                                        
                                        # Link the next delivery note to picking items
                                        # Get statement_id for this delivery note
                                        cursor.execute("""
                                            SELECT statement_id
                                            FROM sales.delivery_note
                                            WHERE delivery_note_id = %s
                                        """, [next_note_id])
                                        
                                        statement_result = cursor.fetchone()
                                        if statement_result:
                                            statement_id = statement_result[0]
                                            
                                            # Get items from statement
                                            cursor.execute("""
                                                SELECT inventory_item_id, quantity
                                                FROM sales.statement_item
                                                WHERE statement_id = %s
                                            """, [statement_id])
                                            
                                            # Create picking items for each statement item
                                            for item_row in cursor.fetchall():
                                                cursor.execute("""
                                                    INSERT INTO distribution.picking_item
                                                    (inventory_item_id, quantity, picking_list_id, delivery_note_id)
                                                    VALUES (%s, %s, %s, %s)
                                                """, [item_row[0], item_row[1], picking_list_id, next_note_id])
                    else:
                        # No more delivery notes, update order status to complete
                        cursor.execute("""
                            UPDATE sales.orders
                            SET order_status = 'Completed'
                            WHERE order_id = %s
                        """, [order_id])
                        
        except Exception as e:
            print(f"Error in handle_shipment_status_changes: {str(e)}")
            traceback.print_exc()