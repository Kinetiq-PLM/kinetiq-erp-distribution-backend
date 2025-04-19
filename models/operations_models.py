# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class DocumentHeader(models.Model):
    document_id = models.CharField(primary_key=True, max_length=255)
    document_type = models.TextField()  # This field type is a guess.
    vendor_code = models.CharField(max_length=255, blank=True, null=True)
    document_no = models.IntegerField()
    transaction_id = models.CharField(max_length=255)
    content_id = models.CharField(max_length=255, blank=True, null=True)
    invoice_id = models.CharField(max_length=255, blank=True, null=True)
    ar_credit_memo = models.CharField(max_length=255, blank=True, null=True)
    status = models.TextField()  # This field type is a guess.
    posting_date = models.DateField()
    delivery_date = models.DateField(blank=True, null=True)
    document_date = models.DateField()
    buyer = models.CharField(max_length=255)
    employee_id = models.CharField(max_length=255, blank=True, null=True)
    initial_amount = models.DecimalField(max_digits=18, decimal_places=2)
    discount_rate = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    discount_amount = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    freight = models.DecimalField(max_digits=18, decimal_places=2)
    tax_rate = models.DecimalField(max_digits=5, decimal_places=2)
    tax_amount = models.DecimalField(max_digits=18, decimal_places=2)
    transaction_cost = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'document_header'


class DocumentItems(models.Model):
    content_id = models.CharField(primary_key=True, max_length=255)
    asset_id = models.CharField(max_length=255, blank=True, null=True)
    document_id = models.CharField(max_length=255, blank=True, null=True)
    material_id = models.CharField(max_length=255, blank=True, null=True)
    serial_id = models.CharField(max_length=255, blank=True, null=True)
    productdocu_id = models.CharField(max_length=255, blank=True, null=True)
    external_id = models.CharField(max_length=255, blank=True, null=True)
    delivery_request_id = models.CharField(max_length=255, blank=True, null=True)
    request_date = models.DateField(blank=True, null=True)
    quantity = models.IntegerField()
    total = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    batch_no = models.CharField(unique=True, max_length=100, blank=True, null=True)
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    cost = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    delivery_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    receiving_module = models.TextField(blank=True, null=True)  # This field type is a guess.
    status = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'document_items'


class ExternalModule(models.Model):
    external_id = models.CharField(primary_key=True, max_length=255)
    content_id = models.CharField(max_length=255, blank=True, null=True)
    purchase_id = models.CharField(max_length=255, blank=True, null=True)
    request_id = models.CharField(max_length=255, blank=True, null=True)
    approval_id = models.CharField(max_length=255, blank=True, null=True)
    goods_issue_id = models.CharField(max_length=255, blank=True, null=True)
    approval_request_id = models.CharField(max_length=255, blank=True, null=True)
    billing_receipt_id = models.CharField(max_length=255, blank=True, null=True)
    delivery_receipt_id = models.CharField(max_length=255, blank=True, null=True)
    project_resources_id = models.CharField(max_length=255, blank=True, null=True)
    project_tracking_id = models.CharField(max_length=255, blank=True, null=True)
    project_request_id = models.CharField(max_length=255, blank=True, null=True)
    production_order_detail_id = models.CharField(max_length=255, blank=True, null=True)
    rework_id = models.CharField(max_length=255, blank=True, null=True)
    deprecation_report_id = models.CharField(max_length=255, blank=True, null=True)
    rework_quantity = models.IntegerField(blank=True, null=True)
    reason_rework = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'external_module'


class ProductDocumentItems(models.Model):
    productdocu_id = models.CharField(primary_key=True, max_length=255)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    manuf_date = models.DateField()
    expiry_date = models.DateField()
    content_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product_document_items'


class SerialTracking(models.Model):
    serial_id = models.CharField(primary_key=True, max_length=255)
    document_id = models.CharField(max_length=255, blank=True, null=True)
    serial_no = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'serial_tracking'
