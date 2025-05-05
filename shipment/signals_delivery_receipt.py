from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from shipment.models import DeliveryReceipt, ShipmentDetails
import traceback
from datetime import date
from decimal import Decimal
from django.utils import timezone
import datetime

@receiver(post_save, sender=DeliveryReceipt)
def handle_rejected_delivery_receipt(sender, instance, **kwargs):
    """
    When a DeliveryReceipt's status is set to 'Rejected':
    For sales orders, update only the delivery_note linked to this shipment
    The shipment_status remains unchanged since the shipment itself was successful
    """
    try:
        # Only proceed if receipt_status is 'Rejected'
        if instance.receipt_status == 'Rejected':
            print(f"Processing rejected delivery receipt {instance.delivery_receipt_id}")
            
            # Check if this delivery is for a sales order
            if instance.shipment_id:
                with connection.cursor() as cursor:
                    # First, find the delivery_note linked to this shipment
                    cursor.execute("""
                        SELECT delivery_note_id, order_id
                        FROM sales.delivery_note
                        WHERE shipment_id = %s
                    """, [instance.shipment_id])
                    
                    delivery_note_result = cursor.fetchone()
                    if delivery_note_result and delivery_note_result[0]:
                        delivery_note_id = delivery_note_result[0]
                        sales_order_id = delivery_note_result[1]
                    
                        # Update only the delivery_note linked to this shipment
                        cursor.execute("""
                            UPDATE sales.delivery_note
                            SET shipment_status = 'Failed'
                            WHERE delivery_note_id = %s
                        """, [delivery_note_id])
                        
                        print(f"Updated sales.delivery_note {delivery_note_id} shipment_status to 'Failed'")
                        
                        # Reset other delivery_notes with the same order_id to 'Picking' status
                        if sales_order_id:
                            cursor.execute("""
                                UPDATE sales.delivery_note
                                SET shipment_status = 'Picking'
                                WHERE order_id = %s
                                AND delivery_note_id != %s
                                AND shipment_status NOT IN ('Shipped', 'Delivered', 'Failed')
                            """, [sales_order_id, delivery_note_id])
                            
                            if cursor.rowcount > 0:
                                print(f"Reset {cursor.rowcount} other delivery_notes for order {sales_order_id} to 'Picking' status")
    except Exception as e:
        print(f"Error handling rejected delivery receipt: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=DeliveryReceipt)
def handle_delivery_receipt_update(sender, instance, **kwargs):
    """
    When a DeliveryReceipt's signature is updated from empty to non-empty:
    1. Create a BillingReceipt record
    2. For sales orders, link to the corresponding sales_invoice_id
    3. Create a GoodsIssue record linked to the BillingReceipt (only for sales or service orders)
    4. Update the specific delivery_note with the new status
    """
    try:
        print(f"Processing delivery receipt {instance.delivery_receipt_id} with signature: '{instance.signature}' and status: '{instance.receipt_status}'")
        
        # Check if signature is not empty AND receipt_status is not 'Rejected'
        if instance.signature and instance.signature.strip() and instance.receipt_status != 'Rejected':
            # Update receipt_status to "Received" if not already
            if instance.receipt_status != 'Received':
                with connection.cursor() as cursor:
                    cursor.execute("""
                        UPDATE distribution.delivery_receipt
                        SET receipt_status = 'Received'
                        WHERE delivery_receipt_id = %s
                    """, [instance.delivery_receipt_id])
                    print(f"Updated delivery receipt {instance.delivery_receipt_id} status to 'Received'")
            
            # First check if there's already a BillingReceipt for this DeliveryReceipt
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT billing_receipt_id
                    FROM distribution.billing_receipt
                    WHERE delivery_receipt_id = %s
                """, [instance.delivery_receipt_id])
                result = cursor.fetchone()
                
                # If no BillingReceipt exists yet, create one
                if not result:
                    with transaction.atomic():
                        with connection.cursor() as cursor:
                            # Trace back to find if this is a sales order delivery or service order
                            sales_invoice_id = None
                            service_billing_id = None
                            sales_order_id = None
                            service_order_id = None
                            delivery_type = None
                            
                            # Variables for holding the billing amounts
                            invoice_total_amount = None
                            service_billing_amount = None
                            
                            # Step 1: Get the shipment_id from delivery_receipt
                            if instance.shipment_id:
                                # Step 2: Get the packing_list_id from shipment
                                cursor.execute("""
                                    SELECT packing_list_id
                                    FROM distribution.shipment_details
                                    WHERE shipment_id = %s
                                """, [instance.shipment_id])
                                packing_result = cursor.fetchone()
                                
                                if packing_result and packing_result[0]:
                                    # Step 3: Get the picking_list_id from packing_list
                                    cursor.execute("""
                                        SELECT picking_list_id
                                        FROM distribution.packing_list
                                        WHERE packing_list_id = %s
                                    """, [packing_result[0]])
                                    picking_result = cursor.fetchone()
                                    
                                    if picking_result and picking_result[0]:
                                        # Step 4: Get the approval_request_id from picking_list
                                        cursor.execute("""
                                            SELECT approval_request_id
                                            FROM distribution.picking_list
                                            WHERE picking_list_id = %s
                                        """, [picking_result[0]])
                                        approval_result = cursor.fetchone()
                                        
                                        if approval_result and approval_result[0]:
                                            # Step 5: Get the delivery_order from approval_request
                                            cursor.execute("""
                                                SELECT del_order_id
                                                FROM distribution.logistics_approval_request
                                                WHERE approval_request_id = %s
                                            """, [approval_result[0]])
                                            delivery_result = cursor.fetchone()
                                            
                                            if delivery_result and delivery_result[0]:
                                                # Step 6: Get delivery order details to determine type
                                                cursor.execute("""
                                                    SELECT sales_order_id, service_order_id, content_id, stock_transfer_id, del_type
                                                    FROM distribution.delivery_order
                                                    WHERE del_order_id = %s
                                                """, [delivery_result[0]])
                                                order_result = cursor.fetchone()
                                                
                                                if order_result:
                                                    sales_order_id = order_result[0]
                                                    service_order_id = order_result[1]
                                                    content_id = order_result[2]
                                                    stock_transfer_id = order_result[3]
                                                    delivery_type = order_result[4]
                                                    
                                                    print(f"Delivery type: {delivery_type}")
                                                    print(f"Sales order ID: {sales_order_id}")
                                                    print(f"Service order ID: {service_order_id}")
                                                    print(f"Content ID: {content_id}")
                                                    print(f"Stock transfer ID: {stock_transfer_id}")
                                                    
                                                    # Handle sales order type
                                                    if sales_order_id:
                                                        # Find corresponding sales invoice
                                                        cursor.execute("""
                                                            SELECT si.invoice_id, si.total_amount
                                                            FROM sales.sales_invoices si
                                                            JOIN sales.delivery_note dn ON si.delivery_note_id = dn.delivery_note_id
                                                            WHERE dn.order_id = %s
                                                        """, [sales_order_id])
                                                        invoice_result = cursor.fetchone()
                                                        
                                                        if invoice_result and invoice_result[0]:
                                                            sales_invoice_id = invoice_result[0]
                                                            invoice_total_amount = invoice_result[1] if len(invoice_result) > 1 and invoice_result[1] is not None else 0
                                                            print(f"Found sales_invoice_id {sales_invoice_id} with total_amount {invoice_total_amount} for sales_order {sales_order_id}")
                                                    
                                                    # Handle service order type
                                                    elif service_order_id:
                                                        # Find corresponding service billing with amount
                                                        cursor.execute("""
                                                            SELECT sb.service_billing_id, sb.service_billing_amount
                                                            FROM services.delivery_order delivery
                                                            JOIN services.service_order so ON delivery.service_order_id = so.service_order_id
                                                            JOIN services.service_billing sb ON so.service_order_id = sb.service_order_id
                                                            WHERE delivery.delivery_order_id = %s
                                                        """, [service_order_id])
                                                        billing_result = cursor.fetchone()
                                                        
                                                        if billing_result and billing_result[0]:
                                                            service_billing_id = billing_result[0]
                                                            service_billing_amount = billing_result[1]
                                                            print(f"Found service_billing_id {service_billing_id} with service_billing_amount {service_billing_amount} for service_order {service_order_id}")
                            
                            # Create the billing receipt with appropriate billing amounts based on type
                            # and set flag for creating goods issue only for sales, service orders, or stock transfers
                            create_goods_issue = False
                            billing_receipt_id = None
                            
                            if sales_invoice_id:
                                cursor.execute("""
                                    INSERT INTO distribution.billing_receipt
                                    (delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt)
                                    VALUES (%s, %s, %s, %s)
                                    RETURNING billing_receipt_id
                                """, [
                                    instance.delivery_receipt_id,
                                    sales_invoice_id,
                                    None,  # No service_billing_id for sales order
                                    invoice_total_amount  # Use amount from sales invoice
                                ])
                                result = cursor.fetchone()
                                billing_receipt_id = result[0] if result else None
                                print(f"Created BillingReceipt {billing_receipt_id} for DeliveryReceipt {instance.delivery_receipt_id}")
                                print(f"  - Linked to sales_invoice_id: {sales_invoice_id} with amount: {invoice_total_amount}")
                                create_goods_issue = True
                            elif service_billing_id:
                                cursor.execute("""
                                    INSERT INTO distribution.billing_receipt
                                    (delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt)
                                    VALUES (%s, %s, %s, %s)
                                    RETURNING billing_receipt_id
                                """, [
                                    instance.delivery_receipt_id,
                                    None,  # No sales_invoice_id for service order
                                    service_billing_id,
                                    service_billing_amount  # Use amount from service billing
                                ])
                                result = cursor.fetchone()
                                billing_receipt_id = result[0] if result else None
                                print(f"Created BillingReceipt {billing_receipt_id} for DeliveryReceipt {instance.delivery_receipt_id}")
                                print(f"  - Linked to service_billing_id: {service_billing_id} with amount: {service_billing_amount}")
                                create_goods_issue = True
                            elif stock_transfer_id:
                                # New condition to specifically handle stock transfers
                                cursor.execute("""
                                    INSERT INTO distribution.billing_receipt
                                    (delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt)
                                    VALUES (%s, %s, %s, %s)
                                    RETURNING billing_receipt_id
                                """, [
                                    instance.delivery_receipt_id,
                                    None,  # No sales_invoice_id
                                    None,  # No service_billing_id
                                    instance.total_amount  # Use the delivery receipt total amount if available
                                ])
                                result = cursor.fetchone()
                                billing_receipt_id = result[0] if result else None
                                print(f"Created BillingReceipt {billing_receipt_id} for DeliveryReceipt {instance.delivery_receipt_id}")
                                print(f"  - Stock Transfer with billing amount: {instance.total_amount}")
                                create_goods_issue = True  # Also create goods issue for stock transfers
                            elif content_id:
                                # Specific handling for content deliveries
                                cursor.execute("""
                                    INSERT INTO distribution.billing_receipt
                                    (delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt)
                                    VALUES (%s, %s, %s, %s)
                                    RETURNING billing_receipt_id
                                """, [
                                    instance.delivery_receipt_id,
                                    None,  # No sales_invoice_id
                                    None,  # No service_billing_id
                                    instance.total_amount  # Use the delivery receipt total amount if available
                                ])
                                result = cursor.fetchone()
                                billing_receipt_id = result[0] if result else None
                                print(f"Created BillingReceipt {billing_receipt_id} for DeliveryReceipt {instance.delivery_receipt_id}")
                                print(f"  - Content delivery with billing amount: {instance.total_amount}")
                                create_goods_issue = True  # Also create goods issue for content deliveries
                            else:
                                # This is for other internal deliveries like content
                                cursor.execute("""
                                    INSERT INTO distribution.billing_receipt
                                    (delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt)
                                    VALUES (%s, %s, %s, %s)
                                    RETURNING billing_receipt_id
                                """, [
                                    instance.delivery_receipt_id,
                                    None,  # No sales_invoice_id for internal delivery
                                    None,  # No service_billing_id for internal delivery
                                    None   # Explicitly NULL for internal deliveries
                                ])
                                result = cursor.fetchone()
                                billing_receipt_id = result[0] if result else None
                                print(f"Created BillingReceipt {billing_receipt_id} for DeliveryReceipt {instance.delivery_receipt_id}")
                                print(f"  - Internal content delivery with no billing amount")
                                create_goods_issue = False  # Skip creating goods issue for other internal deliveries
                            
                            # Create a GoodsIssue record linked to the billing receipt
                            # only for billing receipts with sales invoice or service billing
                            if billing_receipt_id and create_goods_issue:
                                # Get the carrier who delivered this shipment as the issuer
                                employee_id = None
                                
                                # Try to find the carrier who delivered this shipment
                                if instance.shipment_id:
                                    cursor.execute("""
                                        SELECT c.carrier_name
                                        FROM distribution.shipment_details sd
                                        LEFT JOIN distribution.carrier c ON sd.carrier_id = c.carrier_id
                                        WHERE sd.shipment_id = %s
                                    """, [instance.shipment_id])
                                    carrier_result = cursor.fetchone()
                                    if carrier_result and carrier_result[0]:
                                        employee_id = carrier_result[0]
                                        print(f"Using carrier ({employee_id}) as goods issuer")
                                
                                cursor.execute("""
                                    INSERT INTO distribution.goods_issue
                                    (issue_date, issued_by, billing_receipt_id)
                                    VALUES (%s, %s, %s)
                                    RETURNING goods_issue_id
                                """, [
                                    date.today(),
                                    employee_id,
                                    billing_receipt_id
                                ])
                                goods_issue_result = cursor.fetchone()
                                goods_issue_id = goods_issue_result[0] if goods_issue_result else None
                                
                                if goods_issue_id:
                                    print(f"Created GoodsIssue {goods_issue_id} for BillingReceipt {billing_receipt_id}")
                                    
                                    # # Update the sales order with the goods_issue_id if this is a sales order
                                    # if sales_order_id:
                                    #     cursor.execute("""
                                    #         UPDATE sales.orders
                                    #         SET goods_issue_id = %s, rework_id = NULL
                                    #         WHERE order_id = %s
                                    #     """, [goods_issue_id, sales_order_id])
                                    #     print(f"Updated sales.orders {sales_order_id} with goods_issue_id {goods_issue_id}")
                            
                            # Always update shipment status regardless of goods issue creation
                            if instance.shipment_id:
                                cursor.execute("""
                                    UPDATE distribution.shipment_details
                                    SET actual_arrival_date = %s,
                                        shipment_status = 'Delivered'
                                    WHERE shipment_id = %s
                                """, [timezone.now(), instance.shipment_id])
                                print(f"Updated shipment {instance.shipment_id} with actual_arrival_date: {timezone.now()} and status: Delivered")
                                
                                # First, find the delivery_note linked to this shipment
                                cursor.execute("""
                                    SELECT delivery_note_id, order_id
                                    FROM sales.delivery_note
                                    WHERE shipment_id = %s
                                """, [instance.shipment_id])
                                
                                delivery_note_result = cursor.fetchone()
                                if delivery_note_result and delivery_note_result[0]:
                                    delivery_note_id = delivery_note_result[0]
                                    sales_order_id = delivery_note_result[1]
                                
                                    # Update only the delivery_note linked to this shipment
                                    cursor.execute("""
                                        UPDATE sales.delivery_note
                                        SET shipment_status = 'Delivered', 
                                            actual_delivery_date = %s
                                        WHERE delivery_note_id = %s
                                    """, [timezone.now(), delivery_note_id])
                                    
                                    print(f"Updated sales.delivery_note {delivery_note_id} shipment_status to 'Delivered'")
                                    
                                    # Reset other delivery_notes with the same order_id to 'Picking' status
                                    if sales_order_id:
                                        cursor.execute("""
                                            UPDATE sales.delivery_note
                                            SET shipment_status = 'Picking'
                                            WHERE order_id = %s
                                            AND delivery_note_id != %s
                                            AND shipment_status NOT IN ('Shipped', 'Delivered', 'Failed')
                                        """, [sales_order_id, delivery_note_id])
                                        
                                        if cursor.rowcount > 0:
                                            print(f"Reset {cursor.rowcount} other delivery_notes for order {sales_order_id} to 'Picking' status")
    except Exception as e:
        print(f"Error handling delivery receipt update: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=DeliveryReceipt)
def update_customer_received_by(sender, instance, **kwargs):
    """
    Updates the received_by with the customer_id for sales orders when the receipt is received
    """
    try:
        # Only proceed if receipt_status is 'Received' and signature is provided
        if instance.receipt_status == 'Received' and instance.signature and instance.signature.strip():
            # Only proceed if received_by is not already set
            if not instance.received_by:
                with connection.cursor() as cursor:
                    # Trace back to find the customer for this delivery
                    # Note: Changed 'do' alias to 'delivery' to avoid SQL reserved keyword issue
                    cursor.execute("""
                        SELECT c.customer_id
                        FROM distribution.shipment_details sd
                        JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                        JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                        JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                        JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                        JOIN sales.orders o ON delivery.sales_order_id = o.order_id
                        JOIN sales.statement s ON o.statement_id = s.statement_id
                        JOIN sales.customers c ON s.customer_id = c.customer_id
                        WHERE sd.shipment_id = %s AND delivery.sales_order_id IS NOT NULL
                    """, [instance.shipment_id])
                    
                    customer_result = cursor.fetchone()
                    if customer_result and customer_result[0]:
                        customer_id = customer_result[0]
                        
                        # Update the received_by field
                        cursor.execute("""
                            UPDATE distribution.delivery_receipt
                            SET received_by = %s
                            WHERE delivery_receipt_id = %s
                        """, [customer_id, instance.delivery_receipt_id])
                        
                        print(f"Updated delivery receipt {instance.delivery_receipt_id} received_by to customer {customer_id}")
    except Exception as e:
        print(f"Error updating customer received_by: {str(e)}")
        traceback.print_exc()

@receiver(pre_save, sender=DeliveryReceipt)
def preserve_rejected_status(sender, instance, **kwargs):
    """
    Preserve the 'Rejected' status if it was explicitly set
    """
    try:
        # If this is an existing instance
        if instance.pk:
            # Get the current database state
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT receipt_status
                    FROM distribution.delivery_receipt
                    WHERE delivery_receipt_id = %s
                """, [instance.delivery_receipt_id])
                result = cursor.fetchone()
                
                # If the current status is 'Rejected', make sure it stays 'Rejected'
                if result and result[0] == 'Rejected':
                    print(f"Preserving 'Rejected' status for delivery receipt {instance.delivery_receipt_id}")
                    instance.receipt_status = 'Rejected'
    except Exception as e:
        print(f"Error in preserve_rejected_status: {str(e)}")
        traceback.print_exc()

def update_sales_shipping_details(sender, instance, **kwargs):
    """
    When a ShipmentDetails record is created or updated for a sales order,
    update only the corresponding record in sales.delivery_note that's linked to this shipment
    or link an unprocessed delivery note if none is linked yet
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
                shipment_status_map = {
                    'Pending': 'Pending',
                    'Shipped': 'Shipped', 
                    'Delivered': 'Delivered',
                    'Failed': 'Failed'
                }
                
                mapped_shipment_status = shipment_status_map.get(shipment_status, 'Pending')
                
                # Map service_type to shipping_method (assuming compatibility)
                shipping_method = 'Standard'
                if service_type == 'Express':
                    shipping_method = 'Express'
                elif service_type == 'Same-day':
                    shipping_method = 'Same-Day'
                
                # FIX: First check if there's a delivery_note already linked to this shipment
                cursor.execute("""
                    SELECT delivery_note_id
                    FROM sales.delivery_note
                    WHERE shipment_id = %s
                """, [instance.shipment_id])
                
                delivery_note_result = cursor.fetchone()
                
                if delivery_note_result:
                    # Update the existing delivery_note linked to this shipment
                    delivery_note_id = delivery_note_result[0]
                    
                    cursor.execute("""
                        UPDATE sales.delivery_note
                        SET tracking_num = %s,
                            shipping_date = %s,
                            estimated_delivery = %s,
                            shipment_status = %s,
                            shipping_method = %s
                        WHERE delivery_note_id = %s
                    """, [
                        tracking_number,
                        shipment_date,
                        estimated_arrival_date,
                        mapped_shipment_status,
                        shipping_method,
                        delivery_note_id
                    ])
                    
                    print(f"Updated sales.delivery_note {delivery_note_id} for shipment {instance.shipment_id}")
                else:
                    # FIX: Look for an unprocessed delivery_note for this sales order
                    cursor.execute("""
                        SELECT delivery_note_id
                        FROM sales.delivery_note
                        WHERE order_id = %s AND (shipment_id IS NULL OR shipment_id = '')
                        ORDER BY delivery_note_id
                        LIMIT 1
                    """, [sales_order_id])
                    
                    unprocessed_note = cursor.fetchone()
                    
                    if unprocessed_note:
                        # Link this unprocessed delivery_note to the current shipment
                        delivery_note_id = unprocessed_note[0]
                        
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
                        
                        print(f"Linked unprocessed delivery_note {delivery_note_id} to shipment {instance.shipment_id}")
                    else:
                        # No unprocessed delivery_note found, create a new one
                        # First get statement_id from the order
                        cursor.execute("""
                            SELECT statement_id
                            FROM sales.orders
                            WHERE order_id = %s
                        """, [sales_order_id])
                        
                        statement_result = cursor.fetchone()
                        statement_id = statement_result[0] if statement_result else None
                        
                        if statement_id:
                            # Create a new record
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
                            print(f"Created new sales.delivery_note {new_delivery_note_id} for shipment {instance.shipment_id}")
    except Exception as e:
        print(f"Error updating sales delivery note: {str(e)}")
        traceback.print_exc()

def _update_sales_delivery_notes(instance, shipment_date, estimated_arrival_date):
    """
    Update sales.delivery_note with shipping dates for sales orders.
    ONLY update the delivery notes directly linked to this specific shipment.
    """
    with connection.cursor() as cursor:
        # Find delivery notes directly linked to this shipment by shipment_id
        cursor.execute("""
            SELECT delivery_note_id 
            FROM sales.delivery_note
            WHERE shipment_id = %s
        """, [instance.shipment_id])
        
        delivery_note_results = cursor.fetchall()
        if not delivery_note_results:
            print(f"No delivery notes found directly linked to shipment {instance.shipment_id}")
            
            # Log a message with more details for debugging partial shipments
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
                print(f"This is a sales order shipment (order_id: {sales_order_id}) but no delivery note is linked yet")
            
            return
            
        # Update only the specific delivery notes linked to this shipment
        for result in delivery_note_results:
            delivery_note_id = result[0]
            cursor.execute("""
                UPDATE sales.delivery_note
                SET shipping_date = %s, 
                    estimated_delivery = %s,
                    shipment_status = 'Shipped'
                WHERE delivery_note_id = %s
            """, [shipment_date, estimated_arrival_date, delivery_note_id])
            
            print(f"Updated shipping dates for delivery_note {delivery_note_id} linked to shipment {instance.shipment_id}")