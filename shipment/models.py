from django.db import models


class Carrier(models.Model):
    carrier_id = models.CharField(primary_key=True, max_length=255)
    carrier_name = models.CharField(max_length=255)
    service_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    carrier_count = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'carrier'


class ShippingCost(models.Model):
    shipping_cost_id = models.CharField(primary_key=True, max_length=255)
    packing_list = models.ForeignKey('packing.PackingList', models.DO_NOTHING, blank=True, null=True)
    cost_per_kg = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    cost_per_km = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    weight_kg = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    distance_km = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_shipping_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shipping_cost'


class OperationalCost(models.Model):
    operational_cost_id = models.CharField(primary_key=True, max_length=255)
    additional_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_operational_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    shipping_cost = models.ForeignKey(ShippingCost, models.DO_NOTHING, blank=True, null=True)
    packing_cost = models.ForeignKey('packing.PackingCost', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'operational_cost'


class FailedShipment(models.Model):
    failed_shipment_id = models.CharField(primary_key=True, max_length=255)
    failure_date = models.DateField(blank=True, null=True)
    failure_reason = models.TextField()
    resolution_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    shipment = models.ForeignKey('ShipmentDetails', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'failed_shipment'


class ShipmentDetails(models.Model):
    shipment_id = models.CharField(primary_key=True, max_length=255)
    carrier = models.ForeignKey(Carrier, models.DO_NOTHING, blank=True, null=True)
    shipment_date = models.DateField(blank=True, null=True)
    shipment_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    tracking_number = models.CharField(max_length=100)
    estimated_arrival_date = models.DateTimeField(blank=True, null=True)
    actual_arrival_date = models.DateTimeField(blank=True, null=True)
    
    packing_list = models.ForeignKey('packing.PackingList', models.DO_NOTHING, blank=True, null=True)
    shipping_cost = models.ForeignKey(ShippingCost, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shipment_details'


class DeliveryReceipt(models.Model):
    delivery_receipt_id = models.CharField(primary_key=True, max_length=255)
    delivery_date = models.DateField(blank=True, null=True)
    received_by = models.CharField(max_length=255, blank=True, null=True)
    signature = models.TextField(blank=True, null=True)  # Update this line
    receipt_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    shipment = models.ForeignKey(ShipmentDetails, models.DO_NOTHING, blank=True, null=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'delivery_receipt'


class BillingReceipt(models.Model):
    billing_receipt_id = models.CharField(primary_key=True, max_length=255)
    delivery_receipt = models.ForeignKey(DeliveryReceipt, models.DO_NOTHING, blank=True, null=True)
    sales_invoice_id = models.CharField(max_length=255, blank=True, null=True)
    service_billing_id = models.CharField(max_length=255, blank=True, null=True)
    total_receipt = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'billing_receipt'


class GoodsIssue(models.Model):
    goods_issue_id = models.CharField(primary_key=True, max_length=255)
    issue_date = models.DateField(blank=True, null=True)
    issued_by = models.CharField(max_length=255, blank=True, null=True)
    billing_receipt = models.ForeignKey(BillingReceipt, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'goods_issue'
