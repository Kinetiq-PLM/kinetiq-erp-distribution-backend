from django.contrib import admin
from .models import Rejection, ReworkOrder

@admin.register(Rejection)
class RejectionAdmin(admin.ModelAdmin):
    list_display = ('rejection_id', 'rejection_status', 'rejection_reason', 'rejection_date')
    search_fields = ('rejection_id', 'rejection_reason')
    list_filter = ('rejection_status', 'rejection_date')
    raw_id_fields = ('delivery_receipt',)

@admin.register(ReworkOrder)
class ReworkOrderAdmin(admin.ModelAdmin):
    list_display = ('rework_id', 'assigned_to', 'rework_status', 'rework_date', 'expected_completion', 'rework_types')
    search_fields = ('rework_id', 'assigned_to')
    list_filter = ('rework_status', 'rework_date', 'rework_types')
    raw_id_fields = ('rejection', 'failed_shipment')