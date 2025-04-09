from django.db.models.signals import post_save
from django.dispatch import receiver
from django.db import transaction, connection
from shipment.models import FailedShipment, DeliveryReceipt
from rework.models import Rejection, ReworkOrder
import traceback
from datetime import date, timedelta  # Added timedelta import

@receiver(post_save, sender=FailedShipment)
def handle_failed_shipment_update(sender, instance, **kwargs):
    """
    When a FailedShipment's failure_reason is updated from empty to non-empty:
    1. Update resolution_status to 'Resolved'
    2. Create a ReworkOrder record linked to that FailedShipment.
    """
    try:
        # Debug output
        print(f"Processing failed shipment: {instance.failed_shipment_id}")
        print(f"Failure reason: '{instance.failure_reason}'")
        
        # Check if failure_reason is not empty
        if instance.failure_reason and instance.failure_reason.strip():
            print(f"Failure reason is not empty, checking for existing ReworkOrder")
            
            # Update resolution_status to 'Resolved'
            with connection.cursor() as cursor:
                cursor.execute("""
                    UPDATE distribution.failed_shipment
                    SET resolution_status = 'Resolved'
                    WHERE failed_shipment_id = %s AND resolution_status != 'Resolved'
                """, [instance.failed_shipment_id])
                if cursor.rowcount > 0:
                    print(f"Updated failed shipment {instance.failed_shipment_id} status to 'Resolved'")
            
            # First check if there's already a ReworkOrder for this FailedShipment
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT rework_id
                    FROM distribution.rework_order
                    WHERE failed_shipment_id = %s
                """, [instance.failed_shipment_id])
                result = cursor.fetchone()
                
                if result:
                    print(f"Found existing ReworkOrder: {result[0]}")
                else:
                    print("No existing ReworkOrder found, creating new one")
                
                # If no ReworkOrder exists yet, create one
                if not result:
                    try:
                        with transaction.atomic():
                            # Calculate expected completion date as today + 2 days
                            expected_completion_date = date.today() + timedelta(days=2)
                            
                            cursor.execute("""
                                INSERT INTO distribution.rework_order
                                (assigned_to, rework_status, rework_date, expected_completion, failed_shipment_id, rejection_id, rework_types)
                                VALUES (%s, %s, %s, %s, %s, %s, %s)
                                RETURNING rework_id
                            """, [
                                None,  # assigned_to will be filled later
                                'Pending',  # Default rework_status
                                date.today(),  # rework_date is today
                                expected_completion_date,  # Set to today + 2 days
                                instance.failed_shipment_id,
                                None,  # rejection_id is NULL as this is from a failed shipment
                                'Failed Shipment'  # rework_types
                            ])
                            result = cursor.fetchone()
                            rework_id = result[0] if result else None
                            print(f"Created ReworkOrder {rework_id} for FailedShipment {instance.failed_shipment_id}")
                            print(f"Expected completion date set to: {expected_completion_date}")
                            
                            # Check if this is from a sales order and update the sales order with rework_id
                            if rework_id:
                                try:
                                    # Trace back to find if this is a sales order delivery
                                    # Note: Changed 'do' alias to 'delivery' to avoid SQL reserved keyword issue
                                    cursor.execute("""
                                        SELECT delivery.sales_order_id
                                        FROM distribution.failed_shipment fs
                                        JOIN distribution.shipment_details sd ON fs.shipment_id = sd.shipment_id
                                        JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                                        JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                                        JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                                        JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                                        WHERE fs.failed_shipment_id = %s AND delivery.sales_order_id IS NOT NULL
                                    """, [instance.failed_shipment_id])
                                    
                                    order_result = cursor.fetchone()
                                    if order_result and order_result[0]:
                                        sales_order_id = order_result[0]
                                        # Update the sales order with the rework_id
                                        cursor.execute("""
                                            UPDATE sales.orders
                                            SET rework_id = %s, goods_issue_id = NULL
                                            WHERE order_id = %s
                                        """, [rework_id, sales_order_id])
                                        print(f"Updated sales.orders {sales_order_id} with rework_id {rework_id}")
                                except Exception as inner_e:
                                    print(f"Error updating sales order with rework_id: {str(inner_e)}")
                                    traceback.print_exc()
                    except Exception as e:
                        print(f"Error creating ReworkOrder: {str(e)}")
                        traceback.print_exc()
    except Exception as e:
        print(f"Error handling failed shipment update: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=DeliveryReceipt)
def handle_rejected_delivery(sender, instance, **kwargs):
    """
    When a DeliveryReceipt's receipt_status is 'Rejected':
    1. Create a Rejection record linked to that DeliveryReceipt if one doesn't exist
    """
    try:
        # Check if receipt_status is 'Rejected'
        if instance.receipt_status == 'Rejected':
            print(f"Processing rejected delivery receipt: {instance.delivery_receipt_id}")
            
            # First check if there's already a Rejection for this DeliveryReceipt
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT rejection_id
                    FROM distribution.rejection
                    WHERE delivery_receipt_id = %s
                """, [instance.delivery_receipt_id])
                result = cursor.fetchone()
                
                if result:
                    print(f"Found existing rejection: {result[0]}")
                else:
                    print("No existing rejection found, creating new one")
                
                # If no Rejection exists yet, create one
                if not result:
                    with transaction.atomic():
                        with connection.cursor() as cursor:
                            cursor.execute("""
                                INSERT INTO distribution.rejection
                                (rejection_status, rejection_reason, rejection_date, delivery_receipt_id)
                                VALUES (%s, %s, %s, %s)
                                RETURNING rejection_id
                            """, [
                                'Pending',  # Default rejection_status
                                '',  # Empty rejection_reason to start with
                                date.today(),  # rejection_date is today
                                instance.delivery_receipt_id
                            ])
                            result = cursor.fetchone()
                            rejection_id = result[0] if result else None
                            print(f"Created Rejection {rejection_id} for DeliveryReceipt {instance.delivery_receipt_id}")
    except Exception as e:
        print(f"Error handling rejected delivery: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=DeliveryReceipt)
def handle_rejection_reason_update(sender, instance, **kwargs):
    """
    Monitors Rejection records for changes to rejection_reason field.
    When a rejection_reason is filled, set status to Resolved and create a ReworkOrder.
    """
    try:
        # Only process if this is a rejected receipt
        if instance.receipt_status == 'Rejected':
            with connection.cursor() as cursor:
                # Get the rejection record
                cursor.execute("""
                    SELECT rejection_id, rejection_reason, rejection_status
                    FROM distribution.rejection
                    WHERE delivery_receipt_id = %s
                """, [instance.delivery_receipt_id])
                
                rejection_result = cursor.fetchone()
                if rejection_result:
                    rejection_id = rejection_result[0]
                    rejection_reason = rejection_result[1]
                    rejection_status = rejection_result[2]
                    
                    print(f"Found rejection {rejection_id} with reason: '{rejection_reason}' and status: '{rejection_status}'")
    except Exception as e:
        print(f"Error handling rejection reason update: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=Rejection)
def handle_rejection_model_update(sender, instance, **kwargs):
    """
    When a Rejection's rejection_reason is updated from empty to non-empty:
    1. Update rejection_status to 'Resolved'
    2. Create a ReworkOrder linked to that Rejection
    3. Update the related sales order with the rework_id if applicable
    """
    try:
        # Debug output
        print(f"Processing rejection: {instance.rejection_id}")
        print(f"Rejection reason: '{instance.rejection_reason}'")
        print(f"Rejection status: '{instance.rejection_status}'")
        
        # Check if rejection_reason is not empty and status is not already Resolved
        if instance.rejection_reason and instance.rejection_reason.strip() and instance.rejection_status != 'Resolved':
            print(f"Updating rejection status to 'Resolved'")
            
            with connection.cursor() as cursor:
                # Update rejection status to Resolved
                cursor.execute("""
                    UPDATE distribution.rejection
                    SET rejection_status = 'Resolved'
                    WHERE rejection_id = %s
                """, [instance.rejection_id])
                
                # Check if ReworkOrder already exists for this rejection
                cursor.execute("""
                    SELECT rework_id
                    FROM distribution.rework_order
                    WHERE rejection_id = %s
                """, [instance.rejection_id])
                
                rework_result = cursor.fetchone()
                
                if rework_result:
                    print(f"Found existing ReworkOrder: {rework_result[0]}")
                else:
                    print(f"Creating new ReworkOrder for rejection {instance.rejection_id}")
                    
                    # If no ReworkOrder exists, create one
                    with transaction.atomic():
                        # Calculate expected completion date as today + 2 days
                        expected_completion_date = date.today() + timedelta(days=2)
                        
                        cursor.execute("""
                            INSERT INTO distribution.rework_order
                            (assigned_to, rework_status, rework_date, expected_completion, rejection_id, failed_shipment_id, rework_types)
                            VALUES (%s, %s, %s, %s, %s, %s, %s)
                            RETURNING rework_id
                        """, [
                            None,  # assigned_to will be filled later
                            'Pending',  # Default rework_status
                            date.today(),  # rework_date is today
                            expected_completion_date,  # Set to today + 2 days
                            instance.rejection_id,
                            None,  # failed_shipment_id is NULL as this is from a rejection
                            'Rejection'  # rework_types
                        ])
                        
                        result = cursor.fetchone()
                        rework_id = result[0] if result else None
                        print(f"Created ReworkOrder {rework_id} for Rejection {instance.rejection_id}")
                        print(f"Expected completion date set to: {expected_completion_date}")
                        
                        # If ReworkOrder was created, update sales order if applicable
                        if rework_id:
                            # Get the delivery_receipt_id associated with this rejection
                            delivery_receipt_id = instance.delivery_receipt_id
                            
                            # Trace back to find if this is a sales order delivery
                            cursor.execute("""
                                SELECT delivery.sales_order_id
                                FROM distribution.delivery_receipt dr
                                JOIN distribution.shipment_details sd ON dr.shipment_id = sd.shipment_id
                                JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                                JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                                JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                                JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                                WHERE dr.delivery_receipt_id = %s AND delivery.sales_order_id IS NOT NULL
                            """, [delivery_receipt_id])
                            
                            order_result = cursor.fetchone()
                            if order_result and order_result[0]:
                                sales_order_id = order_result[0]
                                
                                print(f"Updating sales.orders {sales_order_id} with rework_id {rework_id}")
                                
                                # Update the sales order with the rework_id
                                cursor.execute("""
                                    UPDATE sales.orders
                                    SET rework_id = %s, goods_issue_id = NULL
                                    WHERE order_id = %s
                                """, [rework_id, sales_order_id])
                                
                                print(f"Updated sales.orders {sales_order_id} with rework_id {rework_id}")
    except Exception as e:
        print(f"Error handling rejection update: {str(e)}")
        traceback.print_exc()