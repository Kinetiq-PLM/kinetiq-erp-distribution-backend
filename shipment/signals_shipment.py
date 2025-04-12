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
        
        # If status is 'Failed', check if FailedShipment already exists
        if current_status == 'Failed':
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
        
        # If status is 'Shipped', check if DeliveryReceipt already exists
        if current_status == 'Shipped':
            # Only update dates if they're not already set
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT shipment_date, estimated_arrival_date
                    FROM distribution.shipment_details
                    WHERE shipment_id = %s
                """, [instance.shipment_id])
                date_result = cursor.fetchone()
                
                if not date_result or not date_result[0]:  # If shipment_date is not set
                    # Now set shipment_date and estimated_arrival_date
                    shipment_date = timezone.now()
                    estimated_arrival_date = timezone.now() + datetime.timedelta(days=2)
                    
                    cursor.execute("""
                        UPDATE distribution.shipment_details
                        SET shipment_date = %s, estimated_arrival_date = %s
                        WHERE shipment_id = %s
                    """, [shipment_date, estimated_arrival_date, instance.shipment_id])
                    print(f"Updated missing dates for shipment {instance.shipment_id}")
                
                # Continue with updating sales.shipping_details for sales orders
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
                    
                    # First, let's trace the entire chain from shipment to customer for debugging
                    with connection.cursor() as debug_cursor:
                        # Step 1: Get the delivery order info
                        debug_query = """
                            SELECT 
                                delivery.del_order_id,
                                delivery.sales_order_id,
                                delivery.service_order_id,
                                delivery.content_id,
                                delivery.stock_transfer_id
                            FROM distribution.shipment_details sd
                            JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                            JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                            JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                            JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                            WHERE sd.shipment_id = %s
                        """
                        debug_cursor.execute(debug_query, [instance.shipment_id])
                        delivery_order_info = debug_cursor.fetchone()
                        
                        if not delivery_order_info:
                            print(f"DEBUG: ERROR - No delivery order found for shipment {instance.shipment_id}")
                        else:
                            del_order_id, sales_order_id, service_order_id, content_id, stock_transfer_id = delivery_order_info
                            print(f"DEBUG: Found delivery order: {del_order_id}")
                            print(f"DEBUG: sales_order_id: {sales_order_id}")
                            print(f"DEBUG: service_order_id: {service_order_id}")
                            print(f"DEBUG: content_id: {content_id}")
                            print(f"DEBUG: stock_transfer_id: {stock_transfer_id}")
                            
                            # Step 2: If it's a sales order, trace to the customer
                            if sales_order_id:
                                # Get the statement_id
                                statement_query = """
                                    SELECT statement_id
                                    FROM sales.orders
                                    WHERE order_id = %s
                                """
                                debug_cursor.execute(statement_query, [sales_order_id])
                                statement_result = debug_cursor.fetchone()
                                
                                if not statement_result:
                                    print(f"DEBUG: ERROR - No statement_id found for sales_order {sales_order_id}")
                                    
                                    # Check if the order exists
                                    debug_cursor.execute("""
                                        SELECT * FROM sales.orders WHERE order_id = %s
                                    """, [sales_order_id])
                                    order_data = debug_cursor.fetchone()
                                    print(f"DEBUG: Order data: {order_data}")
                                else:
                                    statement_id = statement_result[0]
                                    print(f"DEBUG: Found statement_id: {statement_id}")
                                    
                                    # Get the customer_id
                                    customer_query = """
                                        SELECT s.customer_id
                                        FROM sales.statement s
                                        WHERE s.statement_id = %s
                                    """
                                    debug_cursor.execute(customer_query, [statement_id])
                                    customer_result = debug_cursor.fetchone()
                                    
                                    if not customer_result:
                                        print(f"DEBUG: ERROR - No customer found for statement {statement_id}")
                                        
                                        # Check if the statement exists
                                        debug_cursor.execute("""
                                            SELECT * FROM sales.statement WHERE statement_id = %s
                                        """, [statement_id])
                                        statement_data = debug_cursor.fetchone()
                                        print(f"DEBUG: Statement data: {statement_data}")
                                        
                                        # Check statement table columns
                                        debug_cursor.execute("""
                                            SELECT column_name
                                            FROM information_schema.columns
                                            WHERE table_schema = 'sales'
                                            AND table_name = 'statement'
                                        """)
                                        columns = debug_cursor.fetchall()
                                        print(f"DEBUG: Statement table columns: {[col[0] for col in columns]}")
                                    else:
                                        customer_id = customer_result[0]
                                        print(f"DEBUG: Found customer_id: {customer_id}")
                                        
                                        # Verify the customer exists
                                        if customer_id:
                                            debug_cursor.execute("""
                                                SELECT * FROM sales.customers WHERE customer_id = %s
                                            """, [customer_id])
                                            customer_data = debug_cursor.fetchone()
                                            print(f"DEBUG: Customer data: {customer_data}")
                            
                            # Step 2b: If it's a service order, trace to the customer
                            elif service_order_id:
                                print(f"DEBUG: This is a service order delivery: {service_order_id}")
                                
                                # Try to get customer directly from services.delivery_order
                                service_customer_query = """
                                    SELECT customer_id
                                    FROM services.delivery_order
                                    WHERE delivery_order_id = %s
                                """
                                debug_cursor.execute(service_customer_query, [service_order_id])
                                service_customer_result = debug_cursor.fetchone()
                                
                                if not service_customer_result:
                                    print(f"DEBUG: ERROR - No customer_id found directly in services.delivery_order for service_order {service_order_id}")
                                    
                                    # Check if the services.delivery_order record exists
                                    debug_cursor.execute("""
                                        SELECT * FROM services.delivery_order WHERE delivery_order_id = %s
                                    """, [service_order_id])
                                    service_delivery_data = debug_cursor.fetchone()
                                    print(f"DEBUG: Service delivery order data: {service_delivery_data}")
                                    
                                    # Check services.delivery_order table columns
                                    debug_cursor.execute("""
                                        SELECT column_name
                                        FROM information_schema.columns
                                        WHERE table_schema = 'services'
                                        AND table_name = 'delivery_order'
                                    """)
                                    columns = debug_cursor.fetchall()
                                    print(f"DEBUG: services.delivery_order table columns: {[col[0] for col in columns]}")
                                    
                                    # Try alternative path through service_order
                                    debug_cursor.execute("""
                                        SELECT so.customer_id, so.service_order_id
                                        FROM services.delivery_order sdo
                                        JOIN services.service_order_item soi ON sdo.service_order_item_id = soi.service_order_item_id
                                        JOIN services.service_order so ON soi.service_order_id = so.service_order_id
                                        WHERE sdo.delivery_order_id = %s
                                    """, [service_order_id])
                                    alt_result = debug_cursor.fetchone()
                                    
                                    if not alt_result:
                                        print(f"DEBUG: ERROR - Alternative path also failed for service_order {service_order_id}")
                                        
                                        # Check if the service_order exists
                                        debug_cursor.execute("""
                                            SELECT COUNT(*) FROM services.service_order
                                        """)
                                        service_order_count = debug_cursor.fetchone()[0]
                                        print(f"DEBUG: Total service_order records: {service_order_count}")
                                    else:
                                        alternative_customer_id, so_id = alt_result
                                        print(f"DEBUG: Found customer_id via alternative path: {alternative_customer_id} (service_order_id: {so_id})")
                                        
                                        # Verify the customer exists
                                        if alternative_customer_id:
                                            debug_cursor.execute("""
                                                SELECT * FROM sales.customers WHERE customer_id = %s
                                            """, [alternative_customer_id])
                                            customer_data = debug_cursor.fetchone()
                                            print(f"DEBUG: Customer data: {customer_data}")
                                else:
                                    service_customer_id = service_customer_result[0]
                                    print(f"DEBUG: Found customer_id directly: {service_customer_id}")
                                    
                                    # Verify the customer exists
                                    if service_customer_id:
                                        debug_cursor.execute("""
                                            SELECT * FROM sales.customers WHERE customer_id = %s
                                        """, [service_customer_id])
                                        customer_data = debug_cursor.fetchone()
                                        print(f"DEBUG: Customer data: {customer_data}")
                    
                    with transaction.atomic():
                        with connection.cursor() as cursor:
                            # Check delivery types and set receiving_module accordingly
                            receiving_module = None
                            content_id = None
                            stock_transfer_id = None
                            service_order_id = None  # Added for service order
                            customer_id = None  # Added for customer lookup
                            
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
                                    print(f"DEBUG: This is a sales order delivery: {sales_order_id}")
                                    
                                    # Let's try a direct query approach
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
                                            
                                            # Try a step by step approach for debugging
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
                                                else:
                                                    print(f"DEBUG: No customer_id found in statement {statement_id}")
                                            else:
                                                print(f"DEBUG: No statement_id found for order {sales_order_id}")
                                                
                                    except Exception as e:
                                        print(f"DEBUG: Error looking up customer for sales order: {str(e)}")
                                        traceback.print_exc()
                                
                                # If this is a service order, look up the customer_id
                                elif service_order_id:
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
                                            
                                            # Try alternative path through service_order_item -> service_order
                                            print(f"DEBUG: Trying alternative path through service_order_item -> service_order")
                                            
                                            cursor.execute("""
                                                SELECT so.customer_id
                                                FROM services.delivery_order sdo
                                                JOIN services.service_order_item soi ON sdo.service_order_item_id = soi.service_order_item_id
                                                JOIN services.service_order so ON soi.service_order_id = so.service_order_id
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
                                
                                # Case 1: This is a content_id delivery (from operations module)
                                if content_id:
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
                                
                                # Case 2: This is a stock_transfer delivery (from inventory module)
                                elif stock_transfer_id:
                                    print(f"This is a stock_transfer delivery: {stock_transfer_id}")
                                    # Set receiving_module to Inventory for warehouse movements
                                    receiving_module = "Inventory"
                                    print(f"Setting receiving_module to: {receiving_module}")
                            
                            # Get the operational cost for this shipment to set as delivery fee
                            cursor.execute("""
                                SELECT oc.total_operational_cost
                                FROM distribution.shipment_details sd
                                LEFT JOIN distribution.shipping_cost sc ON sd.shipping_cost_id = sc.shipping_cost_id
                                LEFT JOIN distribution.operational_cost oc ON sc.shipping_cost_id = oc.shipping_cost_id
                                WHERE sd.shipment_id = %s
                            """, [instance.shipment_id])
                            
                            op_cost_result = cursor.fetchone()
                            total_operational_cost = op_cost_result[0] if op_cost_result and op_cost_result[0] else None
                            
                            print(f"DEBUG: Retrieved operational cost: {total_operational_cost} for delivery fee")
                            
                            # Now include receiving_module, customer_id, and total_amount when creating the delivery receipt
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
                                    customer_id,  # Now using customer_id instead of None
                                    '',  # Empty signature as requested (cannot be NULL)
                                    'Pending',  # Default receipt_status
                                    instance.shipment_id,
                                    receiving_module,
                                    total_operational_cost  # Set delivery fee from operational cost
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
                                    customer_id,  # Now using customer_id instead of None
                                    '',  # Empty signature as requested (cannot be NULL)
                                    'Pending',  # Default receipt_status
                                    instance.shipment_id,
                                    total_operational_cost  # Set delivery fee from operational cost
                                ])
                            
                            result = cursor.fetchone()
                            delivery_receipt_id = result[0] if result else None
                            print(f"Created DeliveryReceipt {delivery_receipt_id} for shipment {instance.shipment_id}")
                            if customer_id:
                                print(f"  - With customer_id: {customer_id}")
                            if receiving_module:
                                print(f"  - With receiving_module: {receiving_module}")
                            if total_operational_cost:
                                print(f"  - With delivery fee (total_amount): {total_operational_cost}")
                            
                            # After creation, verify the customer_id was properly set
                            cursor.execute("""
                                SELECT received_by, total_amount FROM distribution.delivery_receipt WHERE delivery_receipt_id = %s
                            """, [delivery_receipt_id])
                            verify_result = cursor.fetchone()
                            print(f"DEBUG: Verification - received_by in new delivery receipt: {verify_result[0] if verify_result else None}")
                            print(f"DEBUG: Verification - total_amount in new delivery receipt: {verify_result[1] if verify_result and len(verify_result) > 1 else None}")
            
            # Update associated PackingList status to 'Shipped'
            try:
                # Use a separate transaction for this operation
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
                            
                            # Update packing status in a separate statement
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
    except Exception as e:
        print(f"Error handling shipment status change: {str(e)}")
        traceback.print_exc()

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
                    'Shipped': 'Shipping', 
                    'Delivered': 'Delivered'
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