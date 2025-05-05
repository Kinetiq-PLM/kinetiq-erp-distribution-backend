from django.core.management.base import BaseCommand
from django.db import connection
from picking.models import PickingItem
import logging

logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = 'Fix delivery note associations for picking items'

    def handle(self, *args, **options):
        self.stdout.write('Starting to fix delivery note associations...')
        
        try:
            with connection.cursor() as cursor:
                # First get all picking items without delivery_note_id but with sales order
                cursor.execute("""
                    SELECT 
                        pi.picking_item_id, 
                        do.sales_order_id
                    FROM distribution.picking_item pi
                    JOIN distribution.picking_list pl ON pi.picking_list_id = pl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order do ON lar.del_order_id = do.del_order_id
                    WHERE pi.delivery_note_id IS NULL 
                    AND do.sales_order_id IS NOT NULL
                """)
                
                items_to_fix = cursor.fetchall()
                self.stdout.write(f'Found {len(items_to_fix)} items to fix')
                
                fixed_count = 0
                for item_id, sales_order_id in items_to_fix:
                    # Find delivery note for this sales order
                    cursor.execute("""
                        SELECT delivery_note_id 
                        FROM sales.delivery_note
                        WHERE order_id = %s
                        ORDER BY created_at DESC
                        LIMIT 1
                    """, [sales_order_id])
                    
                    delivery_note = cursor.fetchone()
                    if delivery_note:
                        delivery_note_id = delivery_note[0]
                        
                        # Update the picking item
                        try:
                            cursor.execute("""
                                UPDATE distribution.picking_item 
                                SET delivery_note_id = %s
                                WHERE picking_item_id = %s
                            """, [delivery_note_id, item_id])
                            
                            fixed_count += 1
                            
                            if fixed_count % 100 == 0:
                                self.stdout.write(f'Fixed {fixed_count} items so far...')
                                
                        except Exception as e:
                            logger.error(f"Error updating picking item {item_id}: {str(e)}")
                    
                self.stdout.write(self.style.SUCCESS(f'Fixed {fixed_count} picking items'))
                
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Error: {str(e)}'))