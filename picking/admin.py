from django.contrib import admin
from .models import PickingList

@admin.register(PickingList)
class PickingListAdmin(admin.ModelAdmin):
    list_display = ('picking_list_id', 'warehouse_id', 'picked_by', 'picked_status', 'picked_date')
    search_fields = ('picking_list_id', 'warehouse_id', 'picked_by')
    list_filter = ('picked_status', 'picked_date')
    raw_id_fields = ('approval_request',)