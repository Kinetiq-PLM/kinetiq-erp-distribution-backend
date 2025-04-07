from django.db import models


class PackingCost(models.Model):
    packing_cost_id = models.CharField(primary_key=True, max_length=255)
    material_cost = models.DecimalField(max_digits=10, decimal_places=2)
    labor_cost = models.DecimalField(max_digits=10, decimal_places=2)
    total_packing_cost = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'packing_cost'


class PackingList(models.Model):
    packing_list_id = models.CharField(primary_key=True, max_length=255)
    packed_by = models.CharField(max_length=255, blank=True, null=True)
    packing_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    packing_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    total_items_packed = models.IntegerField(blank=True, null=True)
    packing_cost = models.ForeignKey(PackingCost, models.DO_NOTHING, blank=True, null=True)
    picking_list = models.ForeignKey('picking.PickingList', models.DO_NOTHING, blank=True, null=True)
    packing_date = models.DateField(blank=True, null=True)  # New column
    class Meta:
        managed = False
        db_table = 'packing_list'
