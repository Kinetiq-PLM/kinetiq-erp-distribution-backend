#models.py for all submodules

from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.BooleanField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.BooleanField()
    is_active = models.BooleanField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class AuthtokenToken(models.Model):
    key = models.CharField(primary_key=True, max_length=40)
    created = models.DateTimeField()
    user = models.OneToOneField(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'authtoken_token'


class BillingReceipt(models.Model):
    billing_receipt_id = models.CharField(primary_key=True, max_length=255)
    delivery_receipt = models.ForeignKey('DeliveryReceipt', models.DO_NOTHING, blank=True, null=True)
    sales_invoice_id = models.CharField(max_length=255, blank=True, null=True)
    service_billing_id = models.CharField(max_length=255, blank=True, null=True)
    total_receipt = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'billing_receipt'


class Carrier(models.Model):
    carrier_id = models.CharField(primary_key=True, max_length=255)
    carrier_name = models.CharField(max_length=255, blank=True, null=True)
    service_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    carrier_count = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'carrier'


class DeliveryOrder(models.Model):
    del_order_id = models.CharField(primary_key=True, max_length=255)
    order_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    content_id = models.CharField(max_length=255, blank=True, null=True)
    is_project_based = models.TextField(blank=True, null=True)  # This field type is a guess.
    is_partial_delivery = models.TextField(blank=True, null=True)  # This field type is a guess.
    service_order_id = models.CharField(max_length=255, blank=True, null=True)
    stock_transfer_id = models.CharField(max_length=255, blank=True, null=True)
    sales_order_id = models.CharField(max_length=255, blank=True, null=True)
    approval_request = models.ForeignKey('LogisticsApprovalRequest', models.DO_NOTHING, blank=True, null=True)
    del_type = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'delivery_order'


class DeliveryReceipt(models.Model):
    delivery_receipt_id = models.CharField(primary_key=True, max_length=255)
    delivery_date = models.DateField(blank=True, null=True)
    received_by = models.CharField(max_length=255, blank=True, null=True)
    signature = models.TextField(blank=True, null=True)
    receipt_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    shipment = models.ForeignKey('ShipmentDetails', models.DO_NOTHING, blank=True, null=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    receiving_module = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'delivery_receipt'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.SmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoApschedulerDjangojob(models.Model):
    id = models.CharField(primary_key=True, max_length=255)
    next_run_time = models.DateTimeField(blank=True, null=True)
    job_state = models.BinaryField()

    class Meta:
        managed = False
        db_table = 'django_apscheduler_djangojob'


class DjangoApschedulerDjangojobexecution(models.Model):
    id = models.BigAutoField(primary_key=True)
    status = models.CharField(max_length=50)
    run_time = models.DateTimeField()
    duration = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    finished = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    exception = models.CharField(max_length=1000, blank=True, null=True)
    traceback = models.TextField(blank=True, null=True)
    job = models.ForeignKey(DjangoApschedulerDjangojob, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_apscheduler_djangojobexecution'
        unique_together = (('job', 'run_time'),)


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class FailedShipment(models.Model):
    failed_shipment_id = models.CharField(primary_key=True, max_length=255)
    failure_date = models.DateField(blank=True, null=True)
    failure_reason = models.TextField()
    resolution_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    shipment = models.ForeignKey('ShipmentDetails', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'failed_shipment'


class GoodsIssue(models.Model):
    goods_issue_id = models.CharField(primary_key=True, max_length=255)
    issue_date = models.DateField(blank=True, null=True)
    issued_by = models.CharField(max_length=255, blank=True, null=True)
    billing_receipt = models.ForeignKey(BillingReceipt, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'goods_issue'


class LogisticsApprovalRequest(models.Model):
    approval_request_id = models.CharField(primary_key=True, max_length=255)
    request_date = models.DateField(blank=True, null=True)
    approval_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    approval_date = models.DateField(blank=True, null=True)
    approved_by = models.CharField(max_length=255, blank=True, null=True)
    del_order = models.ForeignKey(DeliveryOrder, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'logistics_approval_request'


class OperationalCost(models.Model):
    operational_cost_id = models.CharField(primary_key=True, max_length=255)
    additional_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_operational_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    shipping_cost = models.ForeignKey('ShippingCost', models.DO_NOTHING, blank=True, null=True)
    packing_cost = models.ForeignKey('PackingCost', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'operational_cost'


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
    picking_list = models.ForeignKey('PickingList', models.DO_NOTHING, blank=True, null=True)
    packing_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'packing_list'


class PickingList(models.Model):
    picking_list_id = models.CharField(primary_key=True, max_length=255)
    warehouse_id = models.CharField(max_length=255, blank=True, null=True)
    picked_by = models.CharField(max_length=255, blank=True, null=True)
    picked_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    picked_date = models.DateField(blank=True, null=True)
    approval_request = models.ForeignKey(LogisticsApprovalRequest, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'picking_list'


class Rejection(models.Model):
    rejection_id = models.CharField(primary_key=True, max_length=255)
    rejection_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    rejection_reason = models.TextField()
    rejection_date = models.DateField(blank=True, null=True)
    delivery_receipt = models.ForeignKey(DeliveryReceipt, models.DO_NOTHING, blank=True, null=True)

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
    failed_shipment = models.ForeignKey(FailedShipment, models.DO_NOTHING, blank=True, null=True)
    rework_types = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'rework_order'


class ShipmentDetails(models.Model):
    shipment_id = models.CharField(primary_key=True, max_length=255)
    carrier = models.ForeignKey(Carrier, models.DO_NOTHING, blank=True, null=True)
    shipment_date = models.DateField(blank=True, null=True)
    shipment_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    tracking_number = models.CharField(max_length=100)
    estimated_arrival_date = models.DateTimeField(blank=True, null=True)
    actual_arrival_date = models.DateTimeField(blank=True, null=True)
    packing_list = models.ForeignKey(PackingList, models.DO_NOTHING, blank=True, null=True)
    shipping_cost = models.ForeignKey('ShippingCost', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shipment_details'


class ShippingCost(models.Model):
    shipping_cost_id = models.CharField(primary_key=True, max_length=255)
    packing_list = models.ForeignKey(PackingList, models.DO_NOTHING, blank=True, null=True)
    cost_per_kg = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    cost_per_km = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    weight_kg = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    distance_km = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_shipping_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'shipping_cost'
