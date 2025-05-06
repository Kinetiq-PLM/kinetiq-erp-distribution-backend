from django.db import models


class PickingList(models.Model):
    picking_list_id = models.CharField(primary_key=True, max_length=255)
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    picked_by = models.CharField(max_length=255, blank=True, null=True)
    picked_status = models.TextField(blank=True, null=True)
    picked_date = models.DateField(blank=True, null=True)
    approval_request = models.ForeignKey('delivery.LogisticsApprovalRequest', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'picking_list'


class PickingItem(models.Model):
    picking_item_id = models.AutoField(primary_key=True)
    picking_list = models.ForeignKey(PickingList, on_delete=models.CASCADE, related_name='picking_items')
    inventory_item_id = models.CharField(max_length=255)
    item_name = models.CharField(max_length=255, blank=True, null=True)
    item_no = models.CharField(max_length=255, blank=True, null=True)
    quantity = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    quantity_picked = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    warehouse_name = models.CharField(max_length=255, blank=True, null=True)
    is_picked = models.BooleanField(default=False)
    picked_at = models.DateTimeField(blank=True, null=True)
    picked_by = models.CharField(max_length=255, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    delivery_note_id = models.CharField(max_length=255, blank=True, null=True)  # Add this field
    
    class Meta:
        db_table = 'picking_item'

    @staticmethod
    def check_all_items_picked(picking_list_id):
        """
        Check if all items in a picking list have been picked.
        For partial deliveries, verify items by delivery note ID.
        """
        try:
            from picking.models import PickingItem
            
            items = PickingItem.objects.filter(picking_list_id=picking_list_id)
            
            if not items.exists():
                return False
                
            # Group items by delivery note
            delivery_notes = {}
            for item in items:
                delivery_note_id = item.delivery_note_id or 'no_note'
                if delivery_note_id not in delivery_notes:
                    delivery_notes[delivery_note_id] = []
                delivery_notes[delivery_note_id].append(item)
            
            # Check each delivery note's items
            for note_id, note_items in delivery_notes.items():
                if not all(item.is_picked for item in note_items):
                    return False
                    
            return True
        except Exception as e:
            print(f"Error checking if all items are picked: {str(e)}")
            return False