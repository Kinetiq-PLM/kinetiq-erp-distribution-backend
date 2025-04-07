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
            # Set shipment_date and estimated_arrival_date
            shipment_date = date.today()
            estimated_arrival_date = shipment_date + timedelta(days=2)
            
            # Update the shipment record with dates
            with connection.cursor() as cursor:
                cursor.execute("""
                    UPDATE distribution.shipment_details
                    SET shipment_date = %s, estimated_arrival_date = %s
                    WHERE shipment_id = %s
                """, [shipment_date, estimated_arrival_date, instance.shipment_id])
                print(f"Updated shipment {instance.shipment_id} with shipment_date: {shipment_date} and estimated_arrival_date: {estimated_arrival_date}")
                
                # After updating the dates in the shipment record, we should also update the sales.shipping_details if applicable
                # This will ensure the date fields are properly synchronized
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
                    # Check if a shipping_details record exists
                    cursor.execute("""
                        SELECT shipping_id
                        FROM sales.shipping_details
                        WHERE order_id = %s
                    """, [sales_order_id])
                    
                    shipping_result = cursor.fetchone()
                    if shipping_result and shipping_result[0]:
                        # Update shipping_date and estimated_delivery on the existing record
                        cursor.execute("""
                            UPDATE sales.shipping_details
                            SET shipping_date = %s, estimated_delivery = %s
                            WHERE order_id = %s
                        """, [shipment_date, estimated_arrival_date, sales_order_id])
                        print(f"Updated shipping dates in sales.shipping_details for order {sales_order_id}")
            
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
                            del_order_id, sales_order_id, content_id, stock_transfer_id = delivery_order_info
                            print(f"DEBUG: Found delivery order: {del_order_id}")
                            print(f"DEBUG: sales_order_id: {sales_order_id}")
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
                    
                    with transaction.atomic():
                        with connection.cursor() as cursor:
                            # Check delivery types and set receiving_module accordingly
                            receiving_module = None
                            content_id = None
                            stock_transfer_id = None
                            customer_id = None  # Added for customer lookup
                            
                            # Check if this is a content_id delivery or stock_transfer
                            # Also look up sales_order_id for customer lookup
                            cursor.execute("""
                                SELECT delivery.content_id, delivery.stock_transfer_id, delivery.sales_order_id
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
                                        print(f"DEBUG: Error looking up customer: {str(e)}")
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
                            
                            # Now include receiving_module and customer_id when creating the delivery receipt
                            print(f"DEBUG: About to create delivery receipt with customer_id: {customer_id}")
                            
                            if receiving_module:
                                print(f"DEBUG: Using receiving_module: {receiving_module}")
                                cursor.execute("""
                                    INSERT INTO distribution.delivery_receipt
                                    (delivery_date, received_by, signature, receipt_status, shipment_id, receiving_module)
                                    VALUES (%s, %s, %s, %s, %s, %s)
                                    RETURNING delivery_receipt_id
                                """, [
                                    date.today(),
                                    customer_id,  # Now using customer_id instead of None
                                    '',  # Empty signature as requested (cannot be NULL)
                                    'Pending',  # Default receipt_status
                                    instance.shipment_id,
                                    receiving_module
                                ])
                            else:
                                print(f"DEBUG: No receiving_module specified")
                                cursor.execute("""
                                    INSERT INTO distribution.delivery_receipt
                                    (delivery_date, received_by, signature, receipt_status, shipment_id)
                                    VALUES (%s, %s, %s, %s, %s)
                                    RETURNING delivery_receipt_id
                                """, [
                                    date.today(),
                                    customer_id,  # Now using customer_id instead of None
                                    '',  # Empty signature as requested (cannot be NULL)
                                    'Pending',  # Default receipt_status
                                    instance.shipment_id
                                ])
                            
                            result = cursor.fetchone()
                            delivery_receipt_id = result[0] if result else None
                            print(f"Created DeliveryReceipt {delivery_receipt_id} for shipment {instance.shipment_id}")
                            if customer_id:
                                print(f"  - With customer_id: {customer_id}")
                            if receiving_module:
                                print(f"  - With receiving_module: {receiving_module}")
                            
                            # After creation, verify the customer_id was properly set
                            cursor.execute("""
                                SELECT received_by FROM distribution.delivery_receipt WHERE delivery_receipt_id = %s
                            """, [delivery_receipt_id])
                            verify_result = cursor.fetchone()
                            print(f"DEBUG: Verification - received_by in new delivery receipt: {verify_result[0] if verify_result else None}")
            
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
    update the corresponding record in sales.shipping_details
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
                delivery_status_map = {
                    'Pending': 'Pending',
                    'Shipped': 'Shipped', 
                    'Delivered': 'Delivered'
                }
                
                delivery_status = delivery_status_map.get(shipment_status, 'Pending')
                
                # Map service_type to shipping_method (assuming compatibility)
                # Default to 'Standard' if no match or if service_type is None
                shipping_method = 'Standard'
                if service_type == 'Express':
                    shipping_method = 'Express'
                elif service_type == 'Same-day':
                    shipping_method = 'Same-Day'
                
                # Check if there's already a shipping_details record for this order
                cursor.execute("""
                    SELECT shipping_id
                    FROM sales.shipping_details
                    WHERE order_id = %s
                """, [sales_order_id])
                
                shipping_details_result = cursor.fetchone()
                
                if shipping_details_result:
                    # Update existing record
                    shipping_id = shipping_details_result[0]
                    
                    cursor.execute("""
                        UPDATE sales.shipping_details
                        SET shipment_id = %s,
                            operational_cost_id = %s,
                            tracking_num = %s,
                            shipping_date = %s,
                            estimated_delivery = %s,
                            delivery_status = %s::delivery_status_enum,
                            shipping_method = %s::shipping_method_enum
                        WHERE shipping_id = %s
                    """, [
                        instance.shipment_id,
                        operational_cost_id,
                        tracking_number,
                        shipment_date,
                        estimated_arrival_date,
                        delivery_status,
                        shipping_method,
                        shipping_id
                    ])
                    
                    print(f"Updated sales.shipping_details {shipping_id} for order {sales_order_id}")
                else:
                    # Create a new record since one doesn't exist
                    # The trigger will generate the shipping_id
                    cursor.execute("""
                        INSERT INTO sales.shipping_details
                        (order_id, shipment_id, operational_cost_id, tracking_num, 
                         shipping_date, estimated_delivery, delivery_status, shipping_method)
                        VALUES (%s, %s, %s, %s, %s, %s, %s::delivery_status_enum, %s::shipping_method_enum)
                        RETURNING shipping_id
                    """, [
                        sales_order_id,
                        instance.shipment_id,
                        operational_cost_id,
                        tracking_number,
                        shipment_date,
                        estimated_arrival_date,
                        delivery_status,
                        shipping_method
                    ])
                    
                    new_shipping_id = cursor.fetchone()[0]
                    print(f"Created new sales.shipping_details {new_shipping_id} for order {sales_order_id}")
    except Exception as e:
        print(f"Error updating sales shipping details: {str(e)}")
        traceback.print_exc()