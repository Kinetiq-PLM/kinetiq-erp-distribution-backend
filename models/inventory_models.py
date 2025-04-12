# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class DeprecationReport(models.Model):
    deprecation_report_id = models.CharField(primary_key=True, max_length=255)
    inventory_item = models.ForeignKey('InventoryItem', models.DO_NOTHING, blank=True, null=True)
    reported_date = models.DateTimeField()
    deprecation_status = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'deprecation_report'


class ExpiryReport(models.Model):
    expiry_report_id = models.CharField(primary_key=True, max_length=255)
    inventory_item = models.ForeignKey('InventoryItem', models.DO_NOTHING, blank=True, null=True)
    reported_date = models.DateTimeField()
    expiry_report_status = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'expiry_report'


class InventoryAdjustments(models.Model):
    adjustment_id = models.CharField(primary_key=True, max_length=255)
    item_id = models.CharField(max_length=255, blank=True, null=True)
    adjustment_type = models.TextField()  # This field type is a guess.
    quantity = models.IntegerField()
    adjustment_date = models.DateTimeField()
    employee_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'inventory_adjustments'


class InventoryCyclicCounts(models.Model):
    inventory_count_id = models.CharField(primary_key=True, max_length=255)
    inventory_item = models.ForeignKey('InventoryItem', models.DO_NOTHING, blank=True, null=True)
    item_onhand = models.IntegerField()
    item_actually_counted = models.IntegerField()
    difference_in_qty = models.IntegerField()
    employee_id = models.CharField(max_length=255, blank=True, null=True)
    status = models.TextField()  # This field type is a guess.
    remarks = models.TextField(blank=True, null=True)
    time_period = models.TextField()  # This field type is a guess.
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'inventory_cyclic_counts'


class InventoryItem(models.Model):
    inventory_item_id = models.CharField(primary_key=True, max_length=255)
    serial_id = models.CharField(max_length=255, blank=True, null=True)
    productdocu_id = models.CharField(max_length=255, blank=True, null=True)
    material_id = models.CharField(max_length=255, blank=True, null=True)
    asset_id = models.CharField(max_length=255, blank=True, null=True)
    item_type = models.TextField()  # This field type is a guess.
    current_quantity = models.IntegerField()
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    expiry = models.DateTimeField(blank=True, null=True)
    shelf_life = models.TextField(blank=True, null=True)  # This field type is a guess.
    last_update = models.DateTimeField()
    date_created = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'inventory_item'


class InventoryItemThreshold(models.Model):
    inventory_item_threshold_id = models.CharField(primary_key=True, max_length=255)
    item_id = models.CharField(max_length=255, blank=True, null=True)
    minimum_threshold = models.IntegerField()
    maximum_threshold = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'inventory_item_threshold'


class WarehouseMovement(models.Model):
    movement_id = models.CharField(primary_key=True, max_length=255)
    docu_creation_date = models.DateTimeField()
    movement_date = models.DateTimeField()
    movement_status = models.TextField()  # This field type is a guess.
    destination = models.CharField(max_length=255, blank=True, null=True)
    source = models.CharField(max_length=255, blank=True, null=True)
    reference_id_purchase_order = models.CharField(max_length=255, blank=True, null=True)
    reference_id_order = models.CharField(max_length=255, blank=True, null=True)
    comments = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'warehouse_movement'


class WarehouseMovementItems(models.Model):
    movement = models.OneToOneField(WarehouseMovement, models.DO_NOTHING, primary_key=True)  # The composite primary key (movement_id, inventory_item_id) found, that is not supported. The first column is selected.
    inventory_item = models.ForeignKey(InventoryItem, models.DO_NOTHING)
    quantity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'warehouse_movement_items'
        unique_together = (('movement', 'inventory_item'),)
