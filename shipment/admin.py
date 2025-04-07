from django.contrib import admin
from .models import (
    Carrier, ShippingCost, OperationalCost, 
    FailedShipment, ShipmentDetails, 
    DeliveryReceipt, BillingReceipt, GoodsIssue
)

@admin.register(Carrier)
class CarrierAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'service_type', 'carrier_count')
    search_fields = ('carrier_id', 'carrier_name')
    list_filter = ('service_type',)

@admin.register(ShippingCost)
class ShippingCostAdmin(admin.ModelAdmin):
    list_display = ('shipping_cost_id', 'cost_per_kg', 'cost_per_km', 'weight_kg', 'distance_km', 'total_shipping_cost')
    search_fields = ('shipping_cost_id',)
    raw_id_fields = ('packing_list',)

@admin.register(OperationalCost)
class OperationalCostAdmin(admin.ModelAdmin):
    list_display = ('operational_cost_id', 'additional_cost', 'total_operational_cost')
    search_fields = ('operational_cost_id',)
    raw_id_fields = ('shipping_cost', 'packing_cost')

@admin.register(FailedShipment)
class FailedShipmentAdmin(admin.ModelAdmin):
    list_display = ('failed_shipment_id', 'failure_date', 'failure_reason', 'resolution_status')
    search_fields = ('failed_shipment_id', 'failure_reason')
    list_filter = ('failure_date', 'resolution_status')
    raw_id_fields = ('shipment',)

@admin.register(ShipmentDetails)
class ShipmentDetailsAdmin(admin.ModelAdmin):
    list_display = ('shipment_id', 'shipment_date', 'shipment_status', 'tracking_number', 'estimated_arrival_date')
    search_fields = ('shipment_id', 'tracking_number')
    list_filter = ('shipment_date', 'shipment_status')
    raw_id_fields = ('carrier', 'packing_list', 'shipping_cost')

@admin.register(DeliveryReceipt)
class DeliveryReceiptAdmin(admin.ModelAdmin):
    list_display = ('delivery_receipt_id', 'delivery_date', 'received_by', 'receipt_status', 'total_amount')
    search_fields = ('delivery_receipt_id', 'received_by')
    list_filter = ('delivery_date', 'receipt_status')
    raw_id_fields = ('shipment',)

@admin.register(BillingReceipt)
class BillingReceiptAdmin(admin.ModelAdmin):
    list_display = ('billing_receipt_id', 'sales_invoice_id', 'service_billing_id', 'total_receipt')
    search_fields = ('billing_receipt_id', 'sales_invoice_id', 'service_billing_id')
    raw_id_fields = ('delivery_receipt',)

@admin.register(GoodsIssue)
class GoodsIssueAdmin(admin.ModelAdmin):
    list_display = ('goods_issue_id', 'issue_date', 'issued_by')
    search_fields = ('goods_issue_id', 'issued_by')
    list_filter = ('issue_date',)
    raw_id_fields = ('billing_receipt',)