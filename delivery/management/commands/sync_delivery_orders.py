from django.core.management.base import BaseCommand
from django.db import connection, transaction
from django.utils import timezone

class Command(BaseCommand):
    help = 'Synchronizes delivery orders with source records'

    def handle(self, *args, **options):
        self.stdout.write('Starting delivery order synchronization...')
        
        # Check for new orders of each type
        self.sync_sales_orders()
        self.sync_service_orders()
        self.sync_stock_transfers()
        self.sync_document_items()
        
        self.stdout.write(self.style.SUCCESS('Delivery order synchronization completed'))
    
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
                self.create_delivery_order(transfer_id, 'stock_transfer', False)
    
    def sync_document_items(self):
        with connection.cursor() as cursor:
            # Find document items that don't have delivery orders
            cursor.execute("""
                SELECT content_id
                FROM operations.document_items di
                WHERE NOT EXISTS (
                    SELECT 1
                    FROM distribution.delivery_order d
                    WHERE d.content_id = di.content_id
                )
            """)
            items = cursor.fetchall()
            
            self.stdout.write(f'Found {len(items)} new document items')
            
            for item in items:
                item_id = item[0]
                self.create_delivery_order(item_id, 'content', False)
    
    def create_delivery_order(self, source_id, source_type, is_external):
        try:
            with connection.cursor() as cursor:
                del_type = 'External Delivery' if is_external else 'Internal Delivery'
                
                # Create a delivery order with default values for is_project_based and is_partial_delivery
                cursor.execute("""
                    INSERT INTO distribution.delivery_order
                    (order_status, del_type, is_project_based, is_partial_delivery) 
                    VALUES (%s, %s, %s, %s)
                    RETURNING del_order_id
                """, ['Created', del_type, 'Non-Project Based', 'No'])
                
                # Get the generated delivery order ID
                del_order_id = cursor.fetchone()[0]
                
                # Now update the specific source field
                if source_type == 'sales_order':
                    cursor.execute("""
                        UPDATE distribution.delivery_order 
                        SET sales_order_id = %s 
                        WHERE del_order_id = %s
                    """, [source_id, del_order_id])
                elif source_type == 'service_order':
                    cursor.execute("""
                        UPDATE distribution.delivery_order 
                        SET service_order_id = %s 
                        WHERE del_order_id = %s
                    """, [source_id, del_order_id])
                elif source_type == 'stock_transfer':
                    cursor.execute("""
                        UPDATE distribution.delivery_order 
                        SET stock_transfer_id = %s 
                        WHERE del_order_id = %s
                    """, [source_id, del_order_id])
                elif source_type == 'content':
                    cursor.execute("""
                        UPDATE distribution.delivery_order 
                        SET content_id = %s 
                        WHERE del_order_id = %s
                    """, [source_id, del_order_id])
                
                # Create the approval request separately
                cursor.execute("""
                    INSERT INTO distribution.logistics_approval_request
                    (request_date, approval_status, del_order_id)
                    VALUES (%s, %s, %s)
                    RETURNING approval_request_id
                """, [timezone.now().date(), 'Pending', del_order_id])
                
                # Get the generated approval request ID
                approval_request_id = cursor.fetchone()[0]
                
                # Finally update the delivery order with the approval request ID
                cursor.execute("""
                    UPDATE distribution.delivery_order
                    SET approval_request_id = %s
                    WHERE del_order_id = %s
                """, [approval_request_id, del_order_id])
                
                self.stdout.write(f'Created delivery order for {source_type} {source_id}')
                return del_order_id
                
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Error creating delivery order for {source_type} {source_id}: {str(e)}'))
            return None