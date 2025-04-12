# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


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


class Payments(models.Model):
    payment_id = models.CharField(primary_key=True, max_length=255)
    order = models.ForeignKey(Orders, models.DO_NOTHING, blank=True, null=True)
    payment_method = models.TextField(blank=True, null=True)  # This field type is a guess.
    payment_status = models.TextField(blank=True, null=True)  # This field type is a guess.
    payment_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'payments'


class ProductPricing(models.Model):
    product_id = models.CharField(primary_key=True, max_length=255)
    admin_product_id = models.CharField(max_length=255, blank=True, null=True)
    markup_percentage = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    selling_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    demand_level = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        managed = False
        db_table = 'product_pricing'


class Quotation(models.Model):
    quotation_id = models.CharField(primary_key=True, max_length=255)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    agreement = models.ForeignKey(BlanketAgreement, models.DO_NOTHING, blank=True, null=True)
    date_issued = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'quotation'


class Return(models.Model):
    return_id = models.CharField(primary_key=True, max_length=255)
    statement = models.ForeignKey('Statement', models.DO_NOTHING, blank=True, null=True)
    delivery_note = models.ForeignKey(DeliveryNote, models.DO_NOTHING, blank=True, null=True)
    return_date = models.DateTimeField(blank=True, null=True)
    status = models.TextField(blank=True, null=True)  # This field type is a guess.
    remarks = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'return'


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


class Statement(models.Model):
    statement_id = models.CharField(primary_key=True, max_length=255)
    customer = models.ForeignKey(Customers, models.DO_NOTHING, blank=True, null=True)
    salesrep_id = models.CharField(max_length=255, blank=True, null=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    discount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    total_tax = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

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
