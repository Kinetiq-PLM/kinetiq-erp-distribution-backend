from django.db import models


class PickingList(models.Model):
    picking_list_id = models.CharField(primary_key=True, max_length=255)
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    picked_by = models.CharField(max_length=255, blank=True, null=True)
    picked_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    picked_date = models.DateField(blank=True, null=True)
    approval_request = models.ForeignKey('delivery.LogisticsApprovalRequest', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'picking_list'
