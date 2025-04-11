from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from shipment.models import DeliveryReceipt, ShipmentDetails
import traceback
from datetime import date
from decimal import Decimal

@receiver(post_save, sender=DeliveryReceipt)
def handle_rejected_delivery_receipt(sender, instance, **kwargs):
    """
    When a DeliveryReceipt's status is set to 'Rejected':
    For sales orders, update shipping_details.delivery_status to 'Returned'
    The shipment_status remains unchanged since the shipment itself was successful
    """
    try:
        # Only proceed if receipt_status is 'Rejected'
        if instance.receipt_status == 'Rejected':
            print(f"Processing rejected delivery receipt {instance.delivery_receipt_id}")
            
            # Check if this delivery is for a sales order
            if instance.shipment_id:
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
                    
                    result = cursor.fetchone()
                    if result and result[0]:
                        sales_order_id = result[0]
                        
                        # Update the sales.shipping_details delivery_status to 'Returned'
                        cursor.execute("""
                            UPDATE sales.shipping_details
                            SET delivery_status = 'Returned'::delivery_status_enum
                            WHERE order_id = %s
                        """, [sales_order_id])
                        print(f"Updated sales.shipping_details delivery_status to 'Returned' for order {sales_order_id}")
    except Exception as e:
        print(f"Error handling rejected delivery receipt: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=DeliveryReceipt)
def handle_delivery_receipt_update(sender, instance, **kwargs):
    """
    When a DeliveryReceipt's signature is updated from empty to non-empty:
    1. Create a BillingReceipt record
    2. For sales orders, link to the corresponding sales_invoice_id
    3. Create a GoodsIssue record linked to the BillingReceipt
    4. Update the original sales order with the new goods_issue_id
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
                                                        # Find corresponding sales invoice with total_amount
                                                        cursor.execute("""
                                                            SELECT invoice_id, total_amount
                                                            FROM sales.sales_invoices
                                                            WHERE order_id = %s
                                                        """, [sales_order_id])
                                                        invoice_result = cursor.fetchone()
                                                        
                                                        if invoice_result and invoice_result[0]:
                                                            sales_invoice_id = invoice_result[0]
                                                            invoice_total_amount = invoice_result[1]
                                                            print(f"Found sales_invoice_id {sales_invoice_id} with total_amount {invoice_total_amount} for sales_order {sales_order_id}")
                                                    
                                                    # Handle service order type
                                                    elif service_order_id:
                                                        # Find corresponding service billing with amount
                                                        cursor.execute("""
                                                            SELECT sb.service_billing_id, sb.service_billing_amount
                                                            FROM services.delivery_order delivery
                                                            JOIN services.service_order_item soi ON delivery.service_order_item_id = soi.service_order_item_id
                                                            JOIN services.service_billing sb ON soi.service_order_item_id = sb.service_order_item_id
                                                            WHERE delivery.delivery_order_id = %s
                                                        """, [service_order_id])
                                                        billing_result = cursor.fetchone()
                                                        
                                                        if billing_result and billing_result[0]:
                                                            service_billing_id = billing_result[0]
                                                            service_billing_amount = billing_result[1]
                                                            print(f"Found service_billing_id {service_billing_id} with service_billing_amount {service_billing_amount} for service_order {service_order_id}")
                            
                            # Create the billing receipt with appropriate billing amounts based on type
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
                            else:
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
                            
                            if sales_invoice_id:
                                print(f"  - Linked to sales_invoice_id: {sales_invoice_id} with amount: {invoice_total_amount}")
                            elif service_billing_id:
                                print(f"  - Linked to service_billing_id: {service_billing_id} with amount: {service_billing_amount}")
                            else:
                                print(f"  - Internal delivery with no billing amount")
                            
                            # Create a GoodsIssue record linked to the billing receipt
                            if billing_receipt_id:
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
                                    
                                    # Update the sales order with the goods_issue_id if this is a sales order
                                    if sales_order_id:
                                        cursor.execute("""
                                            UPDATE sales.orders
                                            SET goods_issue_id = %s, rework_id = NULL
                                            WHERE order_id = %s
                                        """, [goods_issue_id, sales_order_id])
                                        print(f"Updated sales.orders {sales_order_id} with goods_issue_id {goods_issue_id}")
                                    
                                    # Update actual_arrival_date on the associated shipment record
                                    cursor.execute("""
                                        UPDATE distribution.shipment_details
                                        SET actual_arrival_date = %s,
                                            shipment_status = 'Delivered'
                                        WHERE shipment_id = %s
                                    """, [date.today(), instance.shipment_id])
                                    print(f"Updated shipment {instance.shipment_id} with actual_arrival_date: {date.today()} and status: Delivered")
                                    
                                    # If this is a sales order delivery, also update the sales.shipping_details delivery_status
                                    if sales_order_id:
                                        cursor.execute("""
                                            UPDATE sales.shipping_details
                                            SET delivery_status = 'Delivered'::delivery_status_enum
                                            WHERE order_id = %s
                                        """, [sales_order_id])
                                        print(f"Updated sales.shipping_details delivery_status to 'Delivered' for order {sales_order_id}")
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