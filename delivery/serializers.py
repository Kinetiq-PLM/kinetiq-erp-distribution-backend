from rest_framework import serializers
from .models import DeliveryOrder

class DeliveryOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryOrder
        fields = [
            'del_order_id', 
            'order_status', 
            'content_id',
            'is_project_based', 
            'is_partial_delivery',
            'service_order_id', 
            'stock_transfer_id',
            'sales_order_id',
            'del_type'
        ]