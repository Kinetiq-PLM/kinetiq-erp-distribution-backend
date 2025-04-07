from django.db import models


class Rejection(models.Model):
    rejection_id = models.CharField(primary_key=True, max_length=255)
    rejection_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    rejection_reason = models.TextField()
    rejection_date = models.DateField(blank=True, null=True)
    delivery_receipt = models.ForeignKey('shipment.DeliveryReceipt', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rejection'


class ReworkOrder(models.Model):
    rework_id = models.CharField(primary_key=True, max_length=255)
    assigned_to = models.CharField(max_length=255, blank=True, null=True)
    rework_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    rework_date = models.DateField(blank=True, null=True)
    expected_completion = models.DateTimeField(blank=True, null=True)
    rejection = models.ForeignKey(Rejection, models.DO_NOTHING, blank=True, null=True)
    failed_shipment = models.ForeignKey('shipment.FailedShipment', models.DO_NOTHING, blank=True, null=True)
    rework_types = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'rework_order'
