from django.contrib import admin
from .models import PackingCost, PackingList

@admin.register(PackingCost)
class PackingCostAdmin(admin.ModelAdmin):
    list_display = ('packing_cost_id', 'material_cost', 'labor_cost', 'total_packing_cost')
    search_fields = ('packing_cost_id',)

@admin.register(PackingList)
class PackingListAdmin(admin.ModelAdmin):
    list_display = ('packing_list_id', 'packed_by', 'packing_status', 'packing_type', 'total_items_packed')
    search_fields = ('packing_list_id', 'packed_by')
    list_filter = ('packing_status', 'packing_type')
    raw_id_fields = ('packing_cost', 'picking_list')