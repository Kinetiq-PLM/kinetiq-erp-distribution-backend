from rest_framework import serializers
from .models import DeliveryOrder, LogisticsApprovalRequest

class DeliveryOrderSerializer(serializers.ModelSerializer):
    # Convert text fields to boolean for frontend consumption
    is_project_based = serializers.SerializerMethodField()
    is_partial_delivery = serializers.SerializerMethodField()
    
    class Meta:
        model = DeliveryOrder
        fields = ['del_order_id', 'order_status', 'content_id', 'is_project_based',
                 'is_partial_delivery', 'service_order_id', 'stock_transfer_id',
                 'sales_order_id', 'del_type']
    
    def get_is_project_based(self, obj):
        # Convert 'Yes'/'No' text to boolean
        return obj.is_project_based == 'Yes'
    
    def get_is_partial_delivery(self, obj):
        # Convert 'Yes'/'No' text to boolean
        return obj.is_partial_delivery == 'Yes'

class LogisticsApprovalRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = LogisticsApprovalRequest
        fields = ['approval_request_id', 'request_date', 'approval_status', 
                 'approval_date', 'approved_by']