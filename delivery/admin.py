from django.contrib import admin
from .models import DeliveryOrder, LogisticsApprovalRequest

@admin.register(DeliveryOrder)
class DeliveryOrderAdmin(admin.ModelAdmin):
    list_display = ('del_order_id', 'order_status', 'del_type', 'is_project_based', 'is_partial_delivery', 'sales_order_id', 'service_order_id', 'content_id', 'approval_request')
    search_fields = ('del_order_id', 'content_id', 'service_order_id', 'sales_order_id')
    list_filter = ('order_status', 'is_project_based', 'is_partial_delivery', 'del_type')
    raw_id_fields = ('approval_request',)

@admin.register(LogisticsApprovalRequest)
class LogisticsApprovalRequestAdmin(admin.ModelAdmin):
    list_display = ('approval_request_id', 'request_date', 'approval_status', 'approval_date', 'approved_by')
    search_fields = ('approval_request_id', 'approved_by')
    list_filter = ('approval_status', 'request_date', 'approval_date')
    raw_id_fields = ('del_order',)