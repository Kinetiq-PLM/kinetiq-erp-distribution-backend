from django.core.management.base import BaseCommand
from django.db import connection, transaction
from django.utils import timezone
import logging # Import the logging library

# Get an instance of a logger
logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = 'Synchronizes delivery orders with source records'

    def handle(self, *args, **options):
        self.stdout.write('Starting delivery order synchronization...')
        logger.info("Starting delivery order synchronization...") # Added logger

        # Check for new orders of each type
        self.sync_sales_orders()
        self.sync_service_orders()
        self.sync_stock_transfers()
        self.sync_document_items()

        self.stdout.write(self.style.SUCCESS('Delivery order synchronization completed'))
        logger.info("Delivery order synchronization completed successfully.") # Added logger

    def sync_sales_orders(self):
        with connection.cursor() as cursor:
            # Find sales orders that don't have delivery orders
            cursor.execute("""
                SELECT order_id
                FROM sales.orders o
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM distribution.delivery_order d
                    WHERE d.sales_order_id = o.order_id
                )
            """)
            sales_orders = cursor.fetchall()
            
            self.stdout.write(f'Found {len(sales_orders)} new sales orders')
            
            for order in sales_orders:
                order_id = order[0]
                logger.debug(f"Attempting to create delivery order for sales_order {order_id}")
                self.create_delivery_order(order_id, 'sales_order', True)
    
    def sync_service_orders(self):
        with connection.cursor() as cursor:
            # Find service orders that don't have delivery orders
            cursor.execute("""
                SELECT delivery_order_id
                FROM services.delivery_order o
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM distribution.delivery_order d
                    WHERE d.service_order_id = o.delivery_order_id
                )
            """)
            service_orders = cursor.fetchall()
            
            self.stdout.write(f'Found {len(service_orders)} new service orders')
            
            for order in service_orders:
                order_id = order[0]
                logger.debug(f"Attempting to create delivery order for service_order {order_id}")
                self.create_delivery_order(order_id, 'service_order', True)
    
    def sync_stock_transfers(self):
        with connection.cursor() as cursor:
            # Find warehouse movements that don't have delivery orders
            cursor.execute("""
                SELECT movement_id
                FROM inventory.warehouse_movement wm
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM distribution.delivery_order d
                    WHERE d.stock_transfer_id = wm.movement_id
                )
            """)
            transfers = cursor.fetchall()
            
            self.stdout.write(f'Found {len(transfers)} new warehouse movements')
            
            for transfer in transfers:
                transfer_id = transfer[0]
                logger.debug(f"Attempting to create delivery order for stock_transfer {transfer_id}")
                self.create_delivery_order(transfer_id, 'stock_transfer', False)
    
    def sync_document_items(self):
        logger.info("Starting sync_document_items...") # Added logger
        try: # Wrap the whole method for broad exception catching
            with connection.cursor() as cursor:
                # Find document items that don't have delivery orders
                logger.debug("Querying for document items without delivery orders...") # Added logger
                cursor.execute("""
                    SELECT di.content_id
                    FROM operations.document_items di
                    WHERE NOT EXISTS (
                        SELECT 1
                        FROM distribution.delivery_order d
                        WHERE d.content_id = di.content_id
                    )
                    AND di.content_id IS NOT NULL
                """)
                items = cursor.fetchall()
                logger.info(f'Found {len(items)} potential new document items.') # Updated logger
                self.stdout.write(f'Found {len(items)} new document items')

                for item in items:
                    item_id = item[0]
                    logger.debug(f"Processing document item: {item_id}") # Added logger

                    # For each item, first check AGAIN if a delivery order exists
                    # This prevents race conditions between the initial query and creation
                    try: # Add try/except around the check
                        with connection.cursor() as check_cursor:
                            logger.debug(f"Checking existence for content_id: {item_id}") # Added logger
                            check_cursor.execute("""
                                SELECT 1
                                FROM distribution.delivery_order
                                WHERE content_id = %s
                                LIMIT 1
                            """, [item_id])
                            exists = check_cursor.fetchone()

                        # If a delivery order already exists, skip creating another one
                        if exists:
                            logger.info(f"Skipping content {item_id}: delivery order already exists (checked before creation).") # Updated logger
                            self.stdout.write(f"Skipping content {item_id}: already has a delivery order")
                            continue
                        else:
                             logger.debug(f"No existing delivery order found for {item_id}. Proceeding to create.") # Added logger

                    except Exception as check_exc:
                         logger.error(f"Error checking existence for content {item_id}: {str(check_exc)}", exc_info=True) # Added logger with traceback
                         self.stdout.write(self.style.ERROR(f'Error checking existence for content {item_id}: {str(check_exc)}'))
                         continue # Skip this item if check fails

                    # If we got here, no delivery order exists, so create one
                    # Use transaction.atomic() to ensure the creation process is atomic
                    try:
                        with transaction.atomic():
                            logger.debug(f"Attempting to create delivery order for content {item_id} within transaction...") # Added logger
                            created_id = self.create_delivery_order(item_id, 'content', False)
                            if created_id:
                                logger.info(f"Successfully created delivery order {created_id} for content {item_id}") # Added logger
                            else:
                                # Error is logged within create_delivery_order
                                pass
                    except Exception as create_exc:
                        # This catches errors during the transaction commit or within create_delivery_order if not caught there
                        logger.error(f'Transaction failed for content {item_id}: {str(create_exc)}', exc_info=True) # Added logger with traceback
                        self.stdout.write(self.style.ERROR(f'Error creating delivery order for content {item_id} (transaction failed): {str(create_exc)}'))
                        # The transaction is automatically rolled back here

        except Exception as outer_exc: # Catch exceptions in the broader method
            logger.error(f"An unexpected error occurred in sync_document_items: {str(outer_exc)}", exc_info=True) # Added logger with traceback
            self.stdout.write(self.style.ERROR(f'An unexpected error occurred during document item sync: {str(outer_exc)}'))

        logger.info("Finished sync_document_items.") # Added logger


    def create_delivery_order(self, source_id, source_type, is_external):
        logger.debug(f"Inside create_delivery_order for {source_type} {source_id}")
        try:
            # Count records in operations.document_items before any operations
            count_before = 0
            with connection.cursor() as check_cursor:
                check_cursor.execute("SELECT COUNT(*) FROM operations.document_items")
                count_before = check_cursor.fetchone()[0]
                
            # Disable the trigger temporarily for this transaction
            with connection.cursor() as cursor:
                cursor.execute("ALTER TABLE operations.document_items DISABLE TRIGGER before_insert_document_items;")
                cursor.execute("ALTER TABLE distribution.logistics_approval_request DISABLE TRIGGER ALL;")
                
                # Your existing delivery order creation code
                del_type = 'External Delivery' if is_external else 'Internal Delivery'
                logger.debug(f"Determined del_type: {del_type}") # Added logger

                # Create a delivery order
                logger.debug(f"Inserting base delivery order record for {source_type} {source_id}...") # Added logger
                cursor.execute("""
                    INSERT INTO distribution.delivery_order
                    (order_status, del_type, is_project_based, is_partial_delivery)
                    VALUES (%s, %s, %s, %s)
                    RETURNING del_order_id
                """, ['Created', del_type, 'Non-Project Based', 'No'])

                # Get the generated delivery order ID
                del_order_id_result = cursor.fetchone()
                if not del_order_id_result:
                    logger.error(f"Failed to retrieve del_order_id after insert for {source_type} {source_id}") # Added logger
                    raise Exception("Failed to retrieve del_order_id after insert.")
                del_order_id = del_order_id_result[0]
                logger.debug(f"Generated del_order_id: {del_order_id}") # Added logger

                # Now update the specific source field
                update_sql = ""
                if source_type == 'sales_order':
                    update_sql = "UPDATE distribution.delivery_order SET sales_order_id = %s WHERE del_order_id = %s"
                elif source_type == 'service_order':
                    update_sql = "UPDATE distribution.delivery_order SET service_order_id = %s WHERE del_order_id = %s"
                elif source_type == 'stock_transfer':
                    update_sql = "UPDATE distribution.delivery_order SET stock_transfer_id = %s WHERE del_order_id = %s"
                elif source_type == 'content':
                    update_sql = "UPDATE distribution.delivery_order SET content_id = %s WHERE del_order_id = %s"

                if update_sql:
                    logger.debug(f"Updating {source_type}_id for del_order_id {del_order_id} to {source_id}...") # Added logger
                    cursor.execute(update_sql, [source_id, del_order_id])
                    if cursor.rowcount == 0:
                         logger.warning(f"Update of {source_type}_id for {del_order_id} affected 0 rows.") # Added logger
                else:
                    logger.error(f"Unknown source_type '{source_type}' provided.") # Added logger
                    raise ValueError(f"Unknown source_type: {source_type}")


                # Create the approval request separately
                logger.debug(f"Inserting logistics approval request for del_order_id {del_order_id}...") # Added logger
                
                # Generate a unique ID for approval_request_id following your naming convention
                import uuid
                random_suffix = uuid.uuid4().hex[:6].lower()
                approval_request_id = f"DIS-LAR-{timezone.now().year}-{random_suffix}"
                
                cursor.execute("""
                    INSERT INTO distribution.logistics_approval_request 
                    (approval_request_id, request_date, approval_status, del_order_id)
                    VALUES (%s, %s, %s, %s)
                """, [approval_request_id, timezone.now().date(), 'Pending', del_order_id])

                # No need for RETURNING since we generated the ID ourselves
                logger.debug(f"Generated approval_request_id: {approval_request_id}") # Added logger

                # Finally update the delivery order with the approval request ID
                logger.debug(f"Updating delivery order {del_order_id} with approval_request_id {approval_request_id}...") # Added logger
                cursor.execute("""
                    UPDATE distribution.delivery_order
                    SET approval_request_id = %s
                    WHERE del_order_id = %s
                """, [approval_request_id, del_order_id])
                if cursor.rowcount == 0:
                     logger.warning(f"Update of approval_request_id for {del_order_id} affected 0 rows.") # Added logger

                # If we reach here, all steps within the cursor block succeeded
                self.stdout.write(f'Created delivery order {del_order_id} for {source_type} {source_id}')
                logger.debug(f"Successfully finished create_delivery_order for {source_type} {source_id}, returning {del_order_id}") # Added logger

                # Re-enable the trigger
                cursor.execute("ALTER TABLE operations.document_items ENABLE TRIGGER before_insert_document_items;")
                cursor.execute("ALTER TABLE distribution.logistics_approval_request ENABLE TRIGGER ALL;")

            # Verify no records were added to operations.document_items
            with connection.cursor() as check_cursor:
                check_cursor.execute("SELECT COUNT(*) FROM operations.document_items")
                count_after = check_cursor.fetchone()[0]
                
            if count_after > count_before:
                logger.warning(f"WARNING: operations.document_items record count changed during operation: {count_before} → {count_after}")
                
            return del_order_id

        except Exception as e:
            # Make sure we re-enable the trigger even if an error occurs
            with connection.cursor() as cursor:
                cursor.execute("ALTER TABLE operations.document_items ENABLE TRIGGER before_insert_document_items;")
                cursor.execute("ALTER TABLE distribution.logistics_approval_request ENABLE TRIGGER ALL;")
            # Log the error with traceback
            logger.error(f'Error in create_delivery_order for {source_type} {source_id}: {str(e)}', exc_info=True) # Added logger with traceback
            self.stdout.write(self.style.ERROR(f'Error creating delivery order for {source_type} {source_id}: {str(e)}'))
            # Do not raise the exception here, allow the caller to handle the None return value
            return None