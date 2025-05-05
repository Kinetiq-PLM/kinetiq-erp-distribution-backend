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