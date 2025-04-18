# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class EquipmentEquipment(models.Model):
    equipment_id = models.CharField(primary_key=True, max_length=255)
    equipment_name = models.CharField(max_length=255)
    description = models.TextField()
    availability_status = models.CharField(max_length=50)
    last_maintenance_date = models.DateField()
    equipment_cost = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'Equipment_equipment'


class AdditionalService(models.Model):
    additional_service_id = models.CharField(primary_key=True, max_length=255)
    total_fee = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'additional_service'


class AdditionalServiceType(models.Model):
    additional_service_type_id = models.CharField(primary_key=True, max_length=255)
    additional_service = models.ForeignKey(AdditionalService, models.DO_NOTHING, blank=True, null=True)
    service_type = models.TextField()
    service_fee = models.DecimalField(max_digits=10, decimal_places=2)
    duration = models.IntegerField(blank=True, null=True)
    date_start = models.DateField()
    status = models.TextField()
    total_service_fee = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'additional_service_type'


class AdminNotifications(models.Model):
    notifications_id = models.CharField(primary_key=True, max_length=255)
    module = models.CharField()
    to_user_id = models.CharField()
    message = models.CharField()
    notifications_status = models.CharField()
    created_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'admin.notifications'


class AfterAnalysisSched(models.Model):
    analysis_sched_id = models.CharField(primary_key=True, max_length=255)
    analysis = models.ForeignKey('ServiceAnalysis', models.DO_NOTHING, blank=True, null=True)
    service_date = models.DateField()
    technician_id = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    service_status = models.TextField()

    class Meta:
        managed = False
        db_table = 'after_analysis_sched'


class AuditLog(models.Model):
    log_id = models.CharField(primary_key=True, max_length=255)
    user_id = models.CharField(max_length=255, blank=True, null=True)
    action = models.TextField()
    timestamp = models.DateTimeField()
    ip_address = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'audit_log'


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
    user_id = models.IntegerField(unique=True)

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


class BlanketAgreement(models.Model):
    agreement_id = models.CharField(primary_key=True, max_length=255)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    start_date = models.DateTimeField(blank=True, null=True)
    end_date = models.DateTimeField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    signed_date = models.DateTimeField(blank=True, null=True)
    agreement_method = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'blanket_agreement'


class CampaignContacts(models.Model):
    contact_id = models.CharField(primary_key=True, max_length=255)
    customer = models.ForeignKey('Customers', models.DO_NOTHING, blank=True, null=True)
    campaign = models.ForeignKey('Campaigns', models.DO_NOTHING, blank=True, null=True)
    response_status = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'campaign_contacts'


class Campaigns(models.Model):
    campaign_id = models.CharField(primary_key=True, max_length=255)
    campaign_name = models.CharField(max_length=255, blank=True, null=True)
    type = models.TextField(blank=True, null=True)  # This field type is a guess.
    start_date = models.DateTimeField(blank=True, null=True)
    end_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'campaigns'


class Carrier(models.Model):
    carrier_id = models.CharField(primary_key=True, max_length=255)
    carrier_name = models.CharField(max_length=255, blank=True, null=True)
    service_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    carrier_count = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'carrier'


class Customers(models.Model):
    customer_id = models.CharField(primary_key=True, max_length=255)
    gl_account_id = models.CharField(max_length=255, blank=True, null=True)
    partner_id = models.CharField(max_length=255, blank=True, null=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    contact_person = models.CharField(max_length=255, blank=True, null=True)
    email_address = models.CharField(unique=True, max_length=255, blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    address_line1 = models.CharField(max_length=255, blank=True, null=True)
    address_line2 = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    postal_code = models.CharField(max_length=20, blank=True, null=True)
    country = models.CharField(max_length=100, blank=True, null=True)
    customer_type = models.TextField(blank=True, null=True)  # This field type is a guess.
    status = models.TextField(blank=True, null=True)  # This field type is a guess.
    debt = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'customers'


class DeliveryNote(models.Model):
    delivery_note_id = models.CharField(primary_key=True, max_length=255)
    order = models.ForeignKey('Orders', models.DO_NOTHING, blank=True, null=True)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    shipment_id = models.CharField(max_length=255, blank=True, null=True)
    rework_id = models.CharField(max_length=255, blank=True, null=True)
    shipping_method = models.TextField(blank=True, null=True)  # This field type is a guess.
    tracking_num = models.CharField(max_length=255, blank=True, null=True)
    preferred_delivery_date = models.DateField(blank=True, null=True)
    shipping_date = models.DateTimeField(blank=True, null=True)
    estimated_delivery = models.DateTimeField(blank=True, null=True)
    actual_delivery_date = models.DateTimeField(blank=True, null=True)
    shipment_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'delivery_note'


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


class DeprecationReport(models.Model):
    deprecation_report_id = models.CharField(primary_key=True, max_length=255)
    inventory_item = models.ForeignKey('InventoryItem', models.DO_NOTHING, blank=True, null=True)
    reported_date = models.DateTimeField()
    deprecation_status = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'deprecation_report'


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


class DjangoCeleryBeatClockedschedule(models.Model):
    clocked_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_celery_beat_clockedschedule'


class DjangoCeleryBeatCrontabschedule(models.Model):
    minute = models.CharField(max_length=240)
    hour = models.CharField(max_length=96)
    day_of_week = models.CharField(max_length=64)
    day_of_month = models.CharField(max_length=124)
    month_of_year = models.CharField(max_length=64)
    timezone = models.CharField(max_length=63)

    class Meta:
        managed = False
        db_table = 'django_celery_beat_crontabschedule'


class DjangoCeleryBeatIntervalschedule(models.Model):
    every = models.IntegerField()
    period = models.CharField(max_length=24)

    class Meta:
        managed = False
        db_table = 'django_celery_beat_intervalschedule'


class DjangoCeleryBeatPeriodictask(models.Model):
    name = models.CharField(unique=True, max_length=200)
    task = models.CharField(max_length=200)
    args = models.TextField()
    kwargs = models.TextField()
    queue = models.CharField(max_length=200, blank=True, null=True)
    exchange = models.CharField(max_length=200, blank=True, null=True)
    routing_key = models.CharField(max_length=200, blank=True, null=True)
    expires = models.DateTimeField(blank=True, null=True)
    enabled = models.BooleanField()
    last_run_at = models.DateTimeField(blank=True, null=True)
    total_run_count = models.IntegerField()
    date_changed = models.DateTimeField()
    description = models.TextField()
    crontab = models.ForeignKey(DjangoCeleryBeatCrontabschedule, models.DO_NOTHING, blank=True, null=True)
    interval = models.ForeignKey(DjangoCeleryBeatIntervalschedule, models.DO_NOTHING, blank=True, null=True)
    solar = models.ForeignKey('DjangoCeleryBeatSolarschedule', models.DO_NOTHING, blank=True, null=True)
    one_off = models.BooleanField()
    start_time = models.DateTimeField(blank=True, null=True)
    priority = models.IntegerField(blank=True, null=True)
    headers = models.TextField()
    clocked = models.ForeignKey(DjangoCeleryBeatClockedschedule, models.DO_NOTHING, blank=True, null=True)
    expire_seconds = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'django_celery_beat_periodictask'


class DjangoCeleryBeatPeriodictasks(models.Model):
    ident = models.SmallIntegerField(primary_key=True)
    last_update = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_celery_beat_periodictasks'


class DjangoCeleryBeatSolarschedule(models.Model):
    event = models.CharField(max_length=24)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)

    class Meta:
        managed = False
        db_table = 'django_celery_beat_solarschedule'
        unique_together = (('event', 'latitude', 'longitude'),)


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


class DocumentHeader(models.Model):
    document_id = models.CharField(primary_key=True, max_length=255)
    document_type = models.TextField()  # This field type is a guess.
    vendor_code = models.CharField(max_length=255, blank=True, null=True)
    document_no = models.IntegerField(unique=True, blank=True, null=True)
    transaction_id = models.CharField(unique=True, max_length=255)
    content_id = models.CharField(max_length=255, blank=True, null=True)
    invoice_id = models.CharField(max_length=255, blank=True, null=True)
    ar_credit_memo = models.CharField(unique=True, max_length=255, blank=True, null=True)
    status = models.TextField()  # This field type is a guess.
    posting_date = models.DateField()
    delivery_date = models.DateField(blank=True, null=True)
    document_date = models.DateField()
    buyer = models.CharField(max_length=255, blank=True, null=True)
    employee_id = models.CharField(max_length=255, blank=True, null=True)
    initial_amount = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    discount_rate = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    discount_amount = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    freight = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    tax_rate = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    tax_amount = models.DecimalField(max_digits=18, decimal_places=2, blank=True, null=True)
    transaction_cost = models.DecimalField(max_digits=18, decimal_places=2)

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
    quantity = models.IntegerField(blank=True, null=True)
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


class Equipment(models.Model):
    equipment_id = models.CharField(primary_key=True, max_length=255)
    equipment_name = models.CharField(max_length=255)
    description = models.TextField()
    availability_status = models.CharField(max_length=50)
    last_maintenance_date = models.DateField()
    equipment_cost = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'equipment'


class ExpiryReport(models.Model):
    expiry_report_id = models.CharField(primary_key=True, max_length=255)
    inventory_item = models.ForeignKey('InventoryItem', models.DO_NOTHING, blank=True, null=True)
    reported_date = models.DateTimeField()
    expiry_report_status = models.TextField()  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'expiry_report'


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
    expiry_report_id = models.CharField(max_length=255, blank=True, null=True)
    rework_quantity = models.IntegerField(blank=True, null=True)
    reason_rework = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'external_module'


class ExternalProjectTaskList(models.Model):
    task_id = models.CharField(primary_key=True, max_length=255)
    task_deadline = models.DateField()

    class Meta:
        managed = False
        db_table = 'external_project_task_list'


class FailedShipment(models.Model):
    failed_shipment_id = models.CharField(primary_key=True, max_length=255)
    failure_date = models.DateField(blank=True, null=True)
    failure_reason = models.TextField()
    resolution_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    shipment = models.ForeignKey('ShipmentDetails', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'failed_shipment'


class FeatureGoodsTrackingDepartmentdata(models.Model):
    dept_id = models.CharField(primary_key=True, max_length=255)
    dept_name = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'feature_goods_tracking_departmentdata'


class FeatureGoodsTrackingProductdocuitemdata(models.Model):
    productdocu_id = models.CharField(primary_key=True, max_length=255)
    manuf_date = models.DateField()
    expiry_date = models.DateField()
    product_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'feature_goods_tracking_productdocuitemdata'


class FeatureInternalTransferExternalmoduleproductorderdata(models.Model):
    external_id = models.CharField(primary_key=True, max_length=255)
    rework_quantity = models.IntegerField()
    reason_rework = models.CharField(max_length=255)
    production_order_detail_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'feature_internal_transfer_externalmoduleproductorderdata'


class GeneralLedgerAccounts(models.Model):
    gl_account_id = models.CharField(primary_key=True, max_length=255)
    account_name = models.CharField(max_length=255)
    account_code = models.CharField(max_length=255)
    account_id = models.CharField(max_length=255, blank=True, null=True)
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'general_ledger_accounts'


class GoodsIssue(models.Model):
    goods_issue_id = models.CharField(primary_key=True, max_length=255)
    issue_date = models.DateField(blank=True, null=True)
    issued_by = models.CharField(max_length=255, blank=True, null=True)
    billing_receipt = models.ForeignKey(BillingReceipt, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'goods_issue'


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


class JournalEntries(models.Model):
    description = models.CharField(max_length=255)
    currency_id = models.CharField(max_length=255)
    invoice_id = models.CharField(max_length=255, blank=True, null=True)
    journal_date = models.DateField()
    journal_id = models.CharField(primary_key=True, max_length=255)
    total_credit = models.DecimalField(max_digits=15, decimal_places=2)
    total_debit = models.DecimalField(max_digits=15, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'journal_entries'


class JournalEntryLines(models.Model):
    entry_line_id = models.CharField(primary_key=True, max_length=255)
    gl_account_id = models.CharField(max_length=255, blank=True, null=True)
    debit_amount = models.DecimalField(max_digits=15, decimal_places=2)
    credit_amount = models.DecimalField(max_digits=15, decimal_places=2)
    description = models.CharField(max_length=255, blank=True, null=True)
    journal = models.ForeignKey(JournalEntries, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'journal_entry_lines'


class Labor(models.Model):
    labor_id = models.CharField(primary_key=True, max_length=255)
    production_order_id = models.CharField(max_length=255)
    employee_id = models.CharField(max_length=255)
    date_worked = models.DateTimeField()
    days_worked = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'labor'


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


class Opportunities(models.Model):
    opportunity_id = models.CharField(primary_key=True, max_length=255)
    customer = models.ForeignKey(Customers, models.DO_NOTHING, blank=True, null=True)
    partner_id = models.CharField(max_length=255, blank=True, null=True)
    salesrep_id = models.CharField(max_length=255, blank=True, null=True)
    estimated_value = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    weighted_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    gross_profit_percentage = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    gross_profit_total = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    starting_date = models.DateTimeField(blank=True, null=True)
    expected_closed_date = models.DateField(blank=True, null=True)
    stage = models.TextField(blank=True, null=True)  # This field type is a guess.
    status = models.TextField(blank=True, null=True)  # This field type is a guess.
    description = models.TextField(blank=True, null=True)
    reason_lost = models.TextField(blank=True, null=True)
    interest_level = models.TextField(blank=True, null=True)  # This field type is a guess.
    probability_percentage = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'opportunities'


class Orders(models.Model):
    order_id = models.CharField(primary_key=True, max_length=255)
    quotation = models.ForeignKey('Quotation', models.DO_NOTHING, blank=True, null=True)
    agreement = models.ForeignKey(BlanketAgreement, models.DO_NOTHING, blank=True, null=True)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    ext_project_request_id = models.CharField(max_length=255, blank=True, null=True)
    order_date = models.DateTimeField(blank=True, null=True)
    order_type = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'orders'


class PackingCost(models.Model):
    packing_cost_id = models.CharField(primary_key=True, max_length=255)
    material_cost = models.DecimalField(max_digits=10, decimal_places=2)
    labor_cost = models.DecimalField(max_digits=10, decimal_places=2)
    total_packing_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

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


class PoliciesPolicydocument(models.Model):
    document = models.CharField(max_length=100)
    uploaded_at = models.DateTimeField()
    policy_id = models.CharField(primary_key=True, max_length=255)

    class Meta:
        managed = False
        db_table = 'policies_policydocument'


class ProductDocumentItems(models.Model):
    productdocu_id = models.CharField(primary_key=True, max_length=255)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    manuf_date = models.DateField()
    expiry_date = models.DateField()
    content_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'product_document_items'


class ProductPricing(models.Model):
    product_id = models.CharField(primary_key=True, max_length=255)
    admin_product_id = models.CharField(max_length=255, blank=True, null=True)
    markup_percentage = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    selling_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    demand_level = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'product_pricing'


class ProductionOrdersDetails(models.Model):
    production_order_id = models.CharField(primary_key=True, max_length=255)
    actual_quantity = models.IntegerField()
    cost_of_production = models.DecimalField(max_digits=10, decimal_places=2)
    miscellaneous_costs = models.DecimalField(max_digits=10, decimal_places=2)
    rework_required = models.BooleanField()
    rework_notes = models.TextField()

    class Meta:
        managed = False
        db_table = 'production_orders_details'


class ProductionOrdersHeader(models.Model):
    production_order_id = models.CharField(primary_key=True, max_length=255)
    task_id = models.CharField(max_length=255)
    bom_id = models.CharField(max_length=255)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    target_quantity = models.IntegerField()
    notes = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'production_orders_header'


class ProjectEquipment(models.Model):
    project_equipment_id = models.CharField(primary_key=True, max_length=255)
    equipment_id = models.CharField(max_length=255)
    product_id = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'project_equipment'


class PurchaseOrderShipment(models.Model):
    shipment_id = models.CharField(primary_key=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'purchase_order_shipment'


class Quotation(models.Model):
    quotation_id = models.CharField(primary_key=True, max_length=255)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    agreement = models.ForeignKey(BlanketAgreement, models.DO_NOTHING, blank=True, null=True)
    date_issued = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'quotation'


class Rejection(models.Model):
    rejection_id = models.CharField(primary_key=True, max_length=255)
    rejection_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    rejection_reason = models.TextField()
    rejection_date = models.DateField(blank=True, null=True)
    delivery_receipt = models.ForeignKey(DeliveryReceipt, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rejection'


class ReworkCost(models.Model):
    production_order_id = models.CharField(primary_key=True, max_length=255)
    additional_cost = models.DecimalField(max_digits=10, decimal_places=2)
    additional_misc = models.DecimalField(max_digits=10, decimal_places=2)
    total_rework_cost = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'rework_cost'


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


class RolesPermission(models.Model):
    role_id = models.CharField(primary_key=True, max_length=255)
    role_name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    permissions = models.TextField(blank=True, null=True)
    access_level = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'roles_permission'


class SalesInvoices(models.Model):
    invoice_id = models.CharField(primary_key=True, max_length=255)
    delivery_note = models.ForeignKey(DeliveryNote, models.DO_NOTHING, blank=True, null=True)
    is_returned = models.BooleanField(blank=True, null=True)
    invoice_date = models.DateTimeField(blank=True, null=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_amount_paid = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    remaining_balance = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sales_invoices'


class SerialTracking(models.Model):
    serial_id = models.CharField(primary_key=True, max_length=255)
    document_id = models.CharField(max_length=255, blank=True, null=True)
    serial_no = models.CharField(unique=True, max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'serial_tracking'


class ServiceAnalysis(models.Model):
    analysis_id = models.CharField(primary_key=True, max_length=255)
    service_request = models.ForeignKey('ServiceRequest', models.DO_NOTHING, blank=True, null=True)
    analysis_date = models.DateField(blank=True, null=True)
    technician_id = models.CharField(max_length=255, blank=True, null=True)
    customer_id = models.CharField(max_length=255, blank=True, null=True)
    analysis_status = models.TextField()
    analysis_description = models.TextField(blank=True, null=True)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    contract = models.ForeignKey('ServiceContract', models.DO_NOTHING, blank=True, null=True)
    labor_cost = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_analysis'


class ServiceBilling(models.Model):
    service_billing_id = models.CharField(primary_key=True, max_length=255)
    service_order = models.ForeignKey('ServiceOrder', models.DO_NOTHING, blank=True, null=True)
    renewal = models.ForeignKey('WarrantyRenewal', models.DO_NOTHING, blank=True, null=True)
    analysis = models.ForeignKey(ServiceAnalysis, models.DO_NOTHING, blank=True, null=True)
    service_request = models.ForeignKey('ServiceRequest', models.DO_NOTHING, blank=True, null=True)
    service_billing_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    outsource_fee = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    operational_cost_id = models.CharField(max_length=255, blank=True, null=True)
    total_payable = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    billing_status = models.TextField()
    date_paid = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_billing'


class ServiceCall(models.Model):
    service_call_id = models.CharField(primary_key=True, max_length=255)
    date_created = models.DateTimeField(blank=True, null=True)
    service_ticket_id = models.CharField(max_length=255, blank=True, null=True)
    customer_id = models.CharField(max_length=255, blank=True, null=True)
    call_type = models.TextField()
    technician_id = models.CharField(max_length=255, blank=True, null=True)
    call_status = models.TextField()
    date_closed = models.DateTimeField(blank=True, null=True)
    contract = models.ForeignKey('ServiceContract', models.DO_NOTHING, blank=True, null=True)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    priority_level = models.TextField()
    resolution = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_call'


class ServiceContract(models.Model):
    contract_id = models.CharField(primary_key=True, max_length=255)
    statement_item_id = models.CharField(max_length=255, blank=True, null=True)
    customer_id = models.CharField(max_length=255, blank=True, null=True)
    additional_service = models.ForeignKey(AdditionalService, models.DO_NOTHING, blank=True, null=True)
    contract_description = models.TextField(blank=True, null=True)
    date_issued = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    contract_status = models.TextField()
    product_quantity = models.IntegerField(blank=True, null=True)
    renewal = models.ForeignKey('WarrantyRenewal', models.DO_NOTHING, blank=True, null=True)
    renewal_date = models.DateField(blank=True, null=True)
    renewal_end_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_contract'


class ServiceOrder(models.Model):
    service_order_id = models.CharField(primary_key=True, max_length=255)
    analysis = models.ForeignKey(ServiceAnalysis, models.DO_NOTHING, blank=True, null=True)
    customer_id = models.CharField(max_length=255, blank=True, null=True)
    order_date = models.DateTimeField(blank=True, null=True)
    order_total_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_order'


class ServiceOrderItem(models.Model):
    service_order_item_id = models.CharField(primary_key=True, max_length=255)
    service_order = models.ForeignKey(ServiceOrder, models.DO_NOTHING, blank=True, null=True)
    item_id = models.CharField(max_length=255, blank=True, null=True)
    principal_item_id = models.CharField(max_length=255, blank=True, null=True)
    item_name = models.CharField(max_length=255, blank=True, null=True)
    item_quantity = models.IntegerField(blank=True, null=True)
    item_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_order_item'


class ServiceReport(models.Model):
    report_id = models.CharField(primary_key=True, max_length=255)
    service_call = models.ForeignKey(ServiceCall, models.DO_NOTHING, blank=True, null=True)
    service_ticket_id = models.CharField(max_length=255, blank=True, null=True)
    service_billing = models.ForeignKey(ServiceBilling, models.DO_NOTHING, blank=True, null=True)
    service_request = models.ForeignKey('ServiceRequest', models.DO_NOTHING, blank=True, null=True)
    renewal = models.ForeignKey('WarrantyRenewal', models.DO_NOTHING, blank=True, null=True)
    technician_id = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    report_status = models.TextField()
    request_type = models.TextField(blank=True, null=True)
    submission_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_report'


class ServiceRequest(models.Model):
    service_request_id = models.CharField(primary_key=True, max_length=255)
    service_call = models.ForeignKey(ServiceCall, models.DO_NOTHING, blank=True, null=True)
    request_date = models.DateField(blank=True, null=True)
    customer_id = models.CharField(max_length=255, blank=True, null=True)
    technician_id = models.CharField(max_length=255, blank=True, null=True)
    request_type = models.TextField()
    request_status = models.TextField()
    request_description = models.TextField(blank=True, null=True)
    request_remarks = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'service_request'


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


class Statement(models.Model):
    statement_id = models.CharField(primary_key=True, max_length=255)
    customer = models.ForeignKey(Customers, models.DO_NOTHING, blank=True, null=True)
    salesrep_id = models.CharField(max_length=255, blank=True, null=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    discount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_tax = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    subtotal = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'statement'


class StatementItem(models.Model):
    statement_item_id = models.CharField(primary_key=True, max_length=255)
    statement = models.ForeignKey(Statement, models.DO_NOTHING, blank=True, null=True)
    product_id = models.CharField(max_length=255, blank=True, null=True)
    additional_service_id = models.CharField(max_length=255, blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    quantity_to_deliver = models.IntegerField(blank=True, null=True)
    unit_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    discount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    tax_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    special_requests = models.TextField(blank=True, null=True)
    return_reason = models.TextField(blank=True, null=True)
    return_action = models.TextField(blank=True, null=True)  # This field type is a guess.
    quantity_delivered = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'statement_item'


class Ticket(models.Model):
    ticket_id = models.CharField(primary_key=True, max_length=255)
    customer = models.ForeignKey(Customers, models.DO_NOTHING, blank=True, null=True)
    salesrep_id = models.CharField(max_length=255, blank=True, null=True)
    subject = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    status = models.TextField(blank=True, null=True)  # This field type is a guess.
    priority = models.TextField(blank=True, null=True)  # This field type is a guess.
    type = models.TextField(blank=True, null=True)  # This field type is a guess.
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ticket'


class TicketConvo(models.Model):
    convo_id = models.CharField(primary_key=True, max_length=255)
    ticket = models.ForeignKey(Ticket, models.DO_NOTHING, blank=True, null=True)
    subject = models.CharField(max_length=255, blank=True, null=True)
    content = models.CharField(max_length=255, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ticket_convo'


class Users(models.Model):
    user_id = models.CharField(primary_key=True, max_length=255)
    employee_id = models.CharField(max_length=255, blank=True, null=True)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.CharField(unique=True, max_length=255)
    password = models.CharField(max_length=255)
    status = models.CharField(max_length=10)
    type = models.CharField(max_length=10)
    created_at = models.DateTimeField()
    updated_at = models.DateTimeField()
    role = models.ForeignKey(RolesPermission, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'users'


class VReworkGlAccountId(models.Model):
    gl_account_id = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'v_rework_gl_account_id'


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
    movement = models.ForeignKey(WarehouseMovement, models.DO_NOTHING)
    inventory_item = models.ForeignKey(InventoryItem, models.DO_NOTHING)
    quantity = models.IntegerField()
    warehouse_movement_items_id = models.CharField(primary_key=True, max_length=255)

    class Meta:
        managed = False
        db_table = 'warehouse_movement_items'
        unique_together = (('movement', 'inventory_item'),)


class WarrantyRenewal(models.Model):
    renewal_id = models.CharField(primary_key=True, max_length=255)
    service_call = models.ForeignKey(ServiceCall, models.DO_NOTHING, blank=True, null=True)
    contract = models.ForeignKey(ServiceContract, models.DO_NOTHING, blank=True, null=True)
    duration = models.IntegerField(blank=True, null=True)
    renewal_warranty_start = models.DateField(blank=True, null=True)
    renewal_warranty_end = models.DateField(blank=True, null=True)
    renewal_fee = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'warranty_renewal'
