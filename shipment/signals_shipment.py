from django.utils import timezone
import datetime
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from shipment.models import ShipmentDetails, FailedShipment, DeliveryReceipt
import traceback
from datetime import date, timedelta
from decimal import Decimal

@receiver(post_save, sender=ShipmentDetails)
def handle_shipment_status_change(sender, instance, **kwargs):
    """
    When a ShipmentDetails status is 'Failed', create a FailedShipment record if one doesn't exist.
    When a ShipmentDetails status is 'Shipped', create a DeliveryReceipt record if one doesn't exist.
    """
    try:
        # Get the current status
        current_status = instance.shipment_status
        print(f"DEBUG: Processing shipment {instance.shipment_id} with status: {current_status}")
        
        # Dispatch to appropriate handler based on status
        if current_status == 'Failed':
            _handle_failed_shipment(instance)
        elif current_status == 'Shipped':
            _handle_shipped_shipment(instance)
    except Exception as e:
        print(f"Error handling shipment status change: {str(e)}")
        traceback.print_exc()

def _handle_failed_shipment(instance):
    """
    Handle a shipment with 'Failed' status by creating a FailedShipment record
    and a corresponding ReworkOrder if they don't exist.
    """
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT failed_shipment_id
            FROM distribution.failed_shipment
            WHERE shipment_id = %s
        """, [instance.shipment_id])
        result = cursor.fetchone()
        
        # If no FailedShipment exists, create one
        if not result:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    cursor.execute("""
                        INSERT INTO distribution.failed_shipment
                        (failure_date, failure_reason, resolution_status, shipment_id)
                        VALUES (%s, %s, %s, %s)
                        RETURNING failed_shipment_id
                    """, [
                        date.today(),
                        '',  # Empty failure_reason as requested (cannot be NULL)
                        'Pending',  # Default resolution_status
                        instance.shipment_id
                    ])
                    result = cursor.fetchone()
                    failed_shipment_id = result[0] if result else None
                    print(f"Created FailedShipment {failed_shipment_id} for shipment {instance.shipment_id}")
                    
                    # Create a corresponding ReworkOrder for the failed shipment
                    if failed_shipment_id:
                        # Set expected completion date to 3 days from now
                        expected_completion = timezone.now() + timedelta(days=3)
                        
                        cursor.execute("""
                            INSERT INTO distribution.rework_order
                            (assigned_to, rework_status, rework_date, expected_completion, rejection_id, failed_shipment_id, rework_types)
                            VALUES (%s, %s, %s, %s, %s, %s, %s)
                            RETURNING rework_id
                        """, [
                            None,  # No assigned_to yet
                            'Pending',  # Initial status
                            date.today(),  # rework_date
                            expected_completion,  # expected_completion
                            None,  # No rejection_id
                            failed_shipment_id,  # Link to the failed shipment
                            'Failed Shipment'  # Set rework_types
                        ])
                        rework_result = cursor.fetchone()
                        rework_id = rework_result[0] if rework_result else None
                        print(f"Created ReworkOrder {rework_id} for FailedShipment {failed_shipment_id}")
                        
                        # Now update the sales.delivery_note table
                        if rework_id:
                            # Find the sales order ID associated with this shipment
                            cursor.execute("""
                                SELECT delivery.sales_order_id
                                FROM distribution.shipment_details sd
                                JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                                JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                                JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                                JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                                WHERE sd.shipment_id = %s AND delivery.sales_order_id IS NOT NULL
                            """, [instance.shipment_id])
                            
                            order_result = cursor.fetchone()
                            if order_result and order_result[0]:
                                sales_order_id = order_result[0]
                                print(f"Found sales_order_id: {sales_order_id} for failed shipment: {instance.shipment_id}")
                                
                                # First explicitly update the shipment_status to ensure it's set to 'Failed'
                                cursor.execute("""
                                    UPDATE sales.delivery_note
                                    SET shipment_status = 'Failed'
                                    WHERE order_id = %s
                                """, [sales_order_id])
                                
                                # Then update with the rework_id in a separate query to avoid any conflicts
                                cursor.execute("""
                                    UPDATE sales.delivery_note
                                    SET rework_id = %s
                                    WHERE order_id = %s
                                """, [rework_id, sales_order_id])
                                
                                if cursor.rowcount > 0:
                                    print(f"Updated sales.delivery_note for order {sales_order_id} with rework_id {rework_id} and status 'Failed'")
                                else:
                                    print(f"No rows updated in sales.delivery_note for order {sales_order_id}")
                                    
def _handle_shipped_shipment(instance):
    """
    Handle a shipment with 'Shipped' status by updating shipment dates 
    and creating a DeliveryReceipt if it doesn't exist.
    """
    # Update shipment dates if needed
    shipment_date, estimated_arrival_date = _update_shipment_dates(instance)
    
    # Update sales order delivery notes if this is a sales order shipment
    _update_sales_delivery_notes(instance, shipment_date, estimated_arrival_date)
    
    # Create delivery receipt if it doesn't exist
    _create_delivery_receipt_if_needed(instance)
    
    # Update associated packing list status
    _update_packing_list_status(instance)

def _update_shipment_dates(instance):
    """
    Update shipment dates if they're not already set.
    Returns the shipment_date and estimated_arrival_date.
    """
    shipment_date = None
    estimated_arrival_date = None
    
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT shipment_date, estimated_arrival_date
            FROM distribution.shipment_details
            WHERE shipment_id = %s
        """, [instance.shipment_id])
        date_result = cursor.fetchone()
        
        if not date_result or not date_result[0]:  # If shipment_date is not set
            # Set shipment_date to now and estimated_arrival_date to 2 days from now
            shipment_date = timezone.now()
            estimated_arrival_date = timezone.now() + datetime.timedelta(days=2)
            
            cursor.execute("""
                UPDATE distribution.shipment_details
                SET shipment_date = %s, estimated_arrival_date = %s
                WHERE shipment_id = %s
            """, [shipment_date, estimated_arrival_date, instance.shipment_id])
            print(f"Updated missing dates for shipment {instance.shipment_id}")
        else:
            # Convert existing dates to timezone-aware datetime objects if needed
            shipment_date = _ensure_timezone_aware(date_result[0])
            estimated_arrival_date = _ensure_timezone_aware(date_result[1])
    
    return shipment_date, estimated_arrival_date

def _ensure_timezone_aware(dt_value):
    """
    Convert date or naive datetime to timezone-aware datetime.
    """
    if isinstance(dt_value, date) and not isinstance(dt_value, datetime.datetime):
        # Convert date to datetime at midnight
        dt_value = datetime.datetime.combine(dt_value, datetime.time.min)
        dt_value = timezone.make_aware(dt_value)
    elif isinstance(dt_value, datetime.datetime) and not timezone.is_aware(dt_value):
        dt_value = timezone.make_aware(dt_value)
    return dt_value

def _update_sales_delivery_notes(instance, shipment_date, estimated_arrival_date):
    """
    Update sales.delivery_note with shipping dates for sales orders.
    """
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT delivery.sales_order_id
            FROM distribution.shipment_details sd
            JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
            JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
            JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
            JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
            WHERE sd.shipment_id = %s AND delivery.sales_order_id IS NOT NULL
        """, [instance.shipment_id])

        order_result = cursor.fetchone()
        if order_result and order_result[0]:
            sales_order_id = order_result[0]
            # Check if a delivery_note record exists
            cursor.execute("""
                SELECT delivery_note_id
                FROM sales.delivery_note
                WHERE order_id = %s
            """, [sales_order_id])
            
            delivery_note_result = cursor.fetchone()
            if delivery_note_result and delivery_note_result[0]:
                # Update shipping_date and estimated_delivery on the existing record
                cursor.execute("""
                    UPDATE sales.delivery_note
                    SET shipping_date = %s, estimated_delivery = %s
                    WHERE order_id = %s
                """, [shipment_date, estimated_arrival_date, sales_order_id])
                print(f"Updated shipping dates in sales.delivery_note for order {sales_order_id}")

def _create_delivery_receipt_if_needed(instance):
    """
    Create a DeliveryReceipt if one doesn't exist for this shipment.
    """
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT delivery_receipt_id
            FROM distribution.delivery_receipt
            WHERE shipment_id = %s
        """, [instance.shipment_id])
        result = cursor.fetchone()
        
        # If no DeliveryReceipt exists, create one
        if not result:
            print(f"DEBUG: No delivery receipt exists for shipment {instance.shipment_id}, creating one...")
            _create_delivery_receipt(instance)

def _create_delivery_receipt(instance):
    """
    Create a DeliveryReceipt for a shipment.
    """
    with transaction.atomic():
        with connection.cursor() as cursor:
            # Check delivery types and set receiving_module accordingly
            receiving_module = None
            content_id = None
            stock_transfer_id = None
            service_order_id = None
            customer_id = None
            
            # Check if this is a content_id delivery or stock_transfer or service order
            cursor.execute("""
                SELECT delivery.content_id, delivery.stock_transfer_id, delivery.sales_order_id, delivery.service_order_id
                FROM distribution.shipment_details sd
                JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                WHERE sd.shipment_id = %s
            """, [instance.shipment_id])
            
            delivery_result = cursor.fetchone()
            
            if delivery_result:
                content_id = delivery_result[0]
                stock_transfer_id = delivery_result[1]
                sales_order_id = delivery_result[2]
                service_order_id = delivery_result[3]
                
                # If this is a sales order, look up the customer_id
                if sales_order_id:
                    customer_id = _get_customer_from_sales_order(cursor, sales_order_id)
                
                # If this is a service order, look up the customer_id
                elif service_order_id:
                    customer_id = _get_customer_from_service_order(cursor, service_order_id)
                
                # Case 1: This is a content_id delivery (from operations module)
                if content_id:
                    receiving_module = _get_receiving_module_for_content(cursor, content_id)
                
                # Case 2: This is a stock_transfer delivery (from inventory module)
                elif stock_transfer_id:
                    receiving_module = "Inventory"
            
            # Get the operational cost for this shipment to set as delivery fee
            total_operational_cost = _get_operational_cost(cursor, instance.shipment_id)
            
            # Create the delivery receipt
            _insert_delivery_receipt(cursor, instance.shipment_id, customer_id, receiving_module, total_operational_cost)

def _get_customer_from_sales_order(cursor, sales_order_id):
    """
    Get the customer_id associated with a sales order.
    """
    print(f"DEBUG: This is a sales order delivery: {sales_order_id}")
    
    try:
        cursor.execute("""
            SELECT s.customer_id
            FROM sales.orders o
            JOIN sales.statement s ON o.statement_id = s.statement_id
            WHERE o.order_id = %s
        """, [sales_order_id])
        
        customer_result = cursor.fetchone()
        if customer_result and customer_result[0]:
            customer_id = customer_result[0]
            print(f"DEBUG: Found customer_id: {customer_id} for sales_order: {sales_order_id}")
        else:
            print(f"DEBUG: No customer found for sales_order {sales_order_id}")
            customer_id = _debug_sales_order_customer(cursor, sales_order_id)
    except Exception as e:
        print(f"DEBUG: Error looking up customer for sales order: {str(e)}")
        traceback.print_exc()
    
    return customer_id

def _debug_sales_order_customer(cursor, sales_order_id):
    """
    Step-by-step debugging to find customer for a sales order.
    """
    print(f"DEBUG: Trying step-by-step approach")
    
    # Get the statement_id first
    cursor.execute("""
        SELECT statement_id FROM sales.orders WHERE order_id = %s
    """, [sales_order_id])
    statement_result = cursor.fetchone()
    
    if statement_result and statement_result[0]:
        statement_id = statement_result[0]
        print(f"DEBUG: Found statement_id: {statement_id}")
        
        # Now get the customer_id from the statement
        cursor.execute("""
            SELECT customer_id FROM sales.statement WHERE statement_id = %s
        """, [statement_id])
        customer_result = cursor.fetchone()
        
        if customer_result and customer_result[0]:
            customer_id = customer_result[0]
            print(f"DEBUG: Found customer_id: {customer_id} from statement: {statement_id}")
            return customer_id
        else:
            print(f"DEBUG: No customer_id found in statement {statement_id}")
    else:
        print(f"DEBUG: No statement_id found for order {sales_order_id}")
    
    return None

def _get_customer_from_service_order(cursor, service_order_id):
    """
    Get the customer_id associated with a service order.
    """
    print(f"DEBUG: This is a service order delivery: {service_order_id}")
    
    try:
        # Try to get customer directly from services.delivery_order first
        cursor.execute("""
            SELECT customer_id 
            FROM services.delivery_order
            WHERE delivery_order_id = %s
        """, [service_order_id])

        service_customer_result = cursor.fetchone()
        if service_customer_result and service_customer_result[0]:
            customer_id = service_customer_result[0]
            print(f"DEBUG: Found customer_id directly: {customer_id} for service_order: {service_order_id}")
        else:
            print(f"DEBUG: No customer found directly in services.delivery_order for service_order {service_order_id}")
            
            # Try alternative path through service_order
            cursor.execute("""
                SELECT so.customer_id
                FROM services.delivery_order sdo
                JOIN services.service_order so ON sdo.service_order_id = so.service_order_id
                WHERE sdo.delivery_order_id = %s
            """, [service_order_id])
            
            alt_customer_result = cursor.fetchone()
            if alt_customer_result and alt_customer_result[0]:
                customer_id = alt_customer_result[0]
                print(f"DEBUG: Found customer_id via alternative path: {customer_id}")
            else:
                print(f"DEBUG: Alternative path also failed for service_order {service_order_id}")
    except Exception as e:
        print(f"DEBUG: Error looking up customer for service order: {str(e)}")
        traceback.print_exc()
    
    return customer_id

def _get_receiving_module_for_content(cursor, content_id):
    """
    Get the receiving_module from operations.document_items for a content_id.
    """
    print(f"This is a content_id delivery: {content_id}")
    
    # Get the receiving_module from document_items
    cursor.execute("""
        SELECT receiving_module
        FROM operations.document_items
        WHERE content_id = %s
    """, [content_id])
    module_result = cursor.fetchone()
    
    if module_result and module_result[0]:
        receiving_module = module_result[0]
        print(f"Found receiving_module: {receiving_module}")
        return receiving_module
    
    return None

def _get_operational_cost(cursor, shipment_id):
    """
    Get the operational cost for this shipment to set as delivery fee.
    """
    cursor.execute("""
        SELECT oc.total_operational_cost
        FROM distribution.shipment_details sd
        LEFT JOIN distribution.shipping_cost sc ON sd.shipping_cost_id = sc.shipping_cost_id
        LEFT JOIN distribution.operational_cost oc ON sc.shipping_cost_id = oc.shipping_cost_id
        WHERE sd.shipment_id = %s
    """, [shipment_id])
    
    op_cost_result = cursor.fetchone()
    total_operational_cost = op_cost_result[0] if op_cost_result and op_cost_result[0] else None
    
    print(f"DEBUG: Retrieved operational cost: {total_operational_cost} for delivery fee")
    return total_operational_cost

def _insert_delivery_receipt(cursor, shipment_id, customer_id, receiving_module, total_operational_cost):
    """
    Insert a new delivery receipt record.
    """
    print(f"DEBUG: About to create delivery receipt with customer_id: {customer_id}")
    
    if receiving_module:
        print(f"DEBUG: Using receiving_module: {receiving_module}")
        cursor.execute("""
            INSERT INTO distribution.delivery_receipt
            (delivery_date, received_by, signature, receipt_status, shipment_id, receiving_module, total_amount)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING delivery_receipt_id
        """, [
            date.today(),
            customer_id,
            '',  # Empty signature
            'Pending',  # Default status
            shipment_id,
            receiving_module,
            total_operational_cost
        ])
    else:
        print(f"DEBUG: No receiving_module specified")
        cursor.execute("""
            INSERT INTO distribution.delivery_receipt
            (delivery_date, received_by, signature, receipt_status, shipment_id, total_amount)
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING delivery_receipt_id
        """, [
            date.today(),
            customer_id,
            '',  # Empty signature
            'Pending',  # Default status
            shipment_id,
            total_operational_cost
        ])
    
    result = cursor.fetchone()
    delivery_receipt_id = result[0] if result else None
    print(f"Created DeliveryReceipt {delivery_receipt_id} for shipment {shipment_id}")
    
    # Verify the data was properly set
    cursor.execute("""
        SELECT received_by, total_amount FROM distribution.delivery_receipt WHERE delivery_receipt_id = %s
    """, [delivery_receipt_id])
    verify_result = cursor.fetchone()
    print(f"DEBUG: Verification - received_by in new delivery receipt: {verify_result[0] if verify_result else None}")
    print(f"DEBUG: Verification - total_amount in new delivery receipt: {verify_result[1] if verify_result and len(verify_result) > 1 else None}")

def _update_packing_list_status(instance):
    """
    Update the status of the PackingList associated with this shipment to 'Shipped'.
    """
    try:
        with transaction.atomic():
            with connection.cursor() as cursor:
                # Get the packing_list_id first
                cursor.execute("""
                    SELECT packing_list_id 
                    FROM distribution.shipment_details 
                    WHERE shipment_id = %s
                """, [instance.shipment_id])
                packing_result = cursor.fetchone()
                
                if packing_result and packing_result[0]:
                    packing_list_id = packing_result[0]
                    print(f"Found packing_list_id {packing_list_id} for shipment {instance.shipment_id}")
                    
                    # Update packing status
                    cursor.execute("""
                        UPDATE distribution.packing_list 
                        SET packing_status = 'Shipped' 
                        WHERE packing_list_id = %s
                    """, [packing_list_id])
                    
                    if cursor.rowcount > 0:
                        print(f"Updated packing_list {packing_list_id} status to 'Shipped'")
                    else:
                        print(f"No update needed for packing_list {packing_list_id}")
    except Exception as e:
        print(f"Error updating packing status: {str(e)}")
        traceback.print_exc()
        # This error shouldn't prevent the rest of the processing

@receiver(post_save, sender=ShipmentDetails)
def update_sales_shipping_details(sender, instance, **kwargs):
    """
    When a ShipmentDetails record is created or updated for a sales order,
    update the corresponding record in sales.delivery_note
    """
    try:
        with connection.cursor() as cursor:
            # First, determine if this shipment is for a sales order and get the most current data
            cursor.execute("""
                SELECT 
                    delivery.sales_order_id, 
                    oc.operational_cost_id, 
                    c.service_type,
                    sd.shipment_date,
                    sd.estimated_arrival_date,
                    sd.tracking_number,
                    sd.shipment_status
                FROM distribution.shipment_details sd
                JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                LEFT JOIN distribution.operational_cost oc ON oc.shipping_cost_id = sd.shipping_cost_id
                LEFT JOIN distribution.carrier c ON sd.carrier_id = c.carrier_id
                WHERE sd.shipment_id = %s AND delivery.sales_order_id IS NOT NULL
            """, [instance.shipment_id])
            
            result = cursor.fetchone()
            
            if result and result[0]:
                sales_order_id = result[0]
                operational_cost_id = result[1]
                service_type = result[2] if len(result) > 2 and result[2] is not None else None
                
                # Get the most current date values directly from the database
                shipment_date = result[3]
                estimated_arrival_date = result[4]
                tracking_number = result[5]
                shipment_status = result[6]
                
                print(f"Found sales_order_id: {sales_order_id} for shipment {instance.shipment_id}")
                print(f"Current shipment_date: {shipment_date}, estimated_arrival_date: {estimated_arrival_date}")
                
                # Map shipment status to delivery status - only map normal statuses
                # Failed shipments and Rejected deliveries are handled separately
                shipment_status_map = {
                    'Pending': 'Pending',
                    'Shipped': 'Shipped', 
                    'Delivered': 'Delivered',
                    'Failed': 'Failed'  # Add this line to include Failed status
                }
                
                mapped_shipment_status = shipment_status_map.get(shipment_status, 'Pending')
                
                # Map service_type to shipping_method (assuming compatibility)
                # Default to 'Standard' if no match or if service_type is None
                shipping_method = 'Standard'
                if service_type == 'Express':
                    shipping_method = 'Express'
                elif service_type == 'Same-day':
                    shipping_method = 'Same-Day'
                
                # Check if there's already a delivery_note record for this order
                cursor.execute("""
                    SELECT delivery_note_id
                    FROM sales.delivery_note
                    WHERE order_id = %s
                """, [sales_order_id])
                
                delivery_note_result = cursor.fetchone()
                
                if delivery_note_result:
                    # Update existing record
                    delivery_note_id = delivery_note_result[0]
                    
                    cursor.execute("""
                        UPDATE sales.delivery_note
                        SET shipment_id = %s,
                            tracking_num = %s,
                            shipping_date = %s,
                            estimated_delivery = %s,
                            shipment_status = %s,
                            shipping_method = %s
                        WHERE delivery_note_id = %s
                    """, [
                        instance.shipment_id,
                        tracking_number,
                        shipment_date,
                        estimated_arrival_date,
                        mapped_shipment_status,
                        shipping_method,
                        delivery_note_id
                    ])
                    
                    print(f"Updated sales.delivery_note {delivery_note_id} for order {sales_order_id}")
                else:
                    # First get statement_id from the order
                    cursor.execute("""
                        SELECT statement_id
                        FROM sales.orders
                        WHERE order_id = %s
                    """, [sales_order_id])
                    
                    statement_result = cursor.fetchone()
                    statement_id = statement_result[0] if statement_result else None
                    
                    if statement_id:
                        # Create a new record since one doesn't exist
                        cursor.execute("""
                            INSERT INTO sales.delivery_note
                            (order_id, statement_id, shipment_id, tracking_num, 
                             shipping_method, shipping_date, estimated_delivery, 
                             shipment_status, created_at)
                            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                            RETURNING delivery_note_id
                        """, [
                            sales_order_id,
                            statement_id,
                            instance.shipment_id,
                            tracking_number,
                            shipping_method,
                            shipment_date,
                            estimated_arrival_date,
                            mapped_shipment_status,
                            timezone.now()
                        ])
                        
                        new_delivery_note_id = cursor.fetchone()[0]
                        print(f"Created new sales.delivery_note {new_delivery_note_id} for order {sales_order_id}")
    except Exception as e:
        print(f"Error updating sales delivery note: {str(e)}")
        traceback.print_exc()