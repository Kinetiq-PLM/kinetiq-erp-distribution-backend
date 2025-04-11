# packing/serializers.py
from rest_framework import serializers
from .models import PackingList, PackingCost
from django.db import connection
from django.utils import timezone

class PackingCostSerializer(serializers.ModelSerializer):
    class Meta:
        model = PackingCost
        fields = ['packing_cost_id', 'material_cost', 'labor_cost', 'total_packing_cost']

class PackingListSerializer(serializers.ModelSerializer):
    delivery_type = serializers.SerializerMethodField()
    delivery_id = serializers.SerializerMethodField()
    picking_list_info = serializers.SerializerMethodField()
    is_external = serializers.SerializerMethodField()
    packing_cost_info = serializers.SerializerMethodField()
    
    class Meta:
        model = PackingList
        fields = ['packing_list_id', 'packed_by', 'packing_status', 'packing_type', 
                 'total_items_packed', 'packing_date', 'picking_list_id', 
                 'packing_cost_id', 'delivery_type', 'delivery_id', 'is_external',
                 'picking_list_info', 'packing_cost_info']
    
    def get_is_external(self, obj):
        """
        Determine if this is an external order (sales or service) or internal (content or stock).
        """
        delivery_type = self.get_delivery_type(obj)
        return delivery_type in ['sales', 'service']
    
    def get_delivery_type(self, obj):
        """
        Determine the type of delivery associated with this packing list.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery.sales_order_id, delivery.service_order_id, delivery.content_id, delivery.stock_transfer_id
                    FROM distribution.packing_list pl
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE pl.packing_list_id = %s
                """, [obj.packing_list_id])
                result = cursor.fetchone()
                
                if result:
                    if result[0]:  # sales_order_id
                        return "sales"
                    elif result[1]:  # service_order_id
                        return "service"
                    elif result[2]:  # content_id
                        return "content"
                    elif result[3]:  # stock_transfer_id
                        return "stock"
        except Exception as e:
            print(f"Error getting delivery type: {str(e)}")
            
        return None
    
    def get_delivery_id(self, obj):
        """
        Get the specific delivery ID based on the type of delivery.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery.sales_order_id, delivery.service_order_id, delivery.content_id, delivery.stock_transfer_id
                    FROM distribution.packing_list pl
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE pl.packing_list_id = %s
                """, [obj.packing_list_id])
                result = cursor.fetchone()
                
                if result:
                    if result[0]:  # sales_order_id
                        return result[0]
                    elif result[1]:  # service_order_id
                        return result[1]
                    elif result[2]:  # content_id
                        return result[2]
                    elif result[3]:  # stock_transfer_id
                        return result[3]
        except Exception as e:
            print(f"Error getting delivery ID: {str(e)}")
            
        return None
    
    def get_picking_list_info(self, obj):
        """
        Get information about the related picking list.
        """
        if not obj.picking_list_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT picking_list_id, picked_by, picked_status, picked_date, warehouse_id
                    FROM distribution.picking_list
                    WHERE picking_list_id = %s
                """, [obj.picking_list_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    # Get warehouse name if warehouse_id exists
                    warehouse_name = None
                    if result[4]:  # warehouse_id
                        cursor.execute("""
                            SELECT warehouse_location
                            FROM admin.warehouse
                            WHERE warehouse_id = %s
                        """, [result[4]])
                        warehouse_result = cursor.fetchone()
                        if warehouse_result:
                            warehouse_name = warehouse_result[0]
                    
                    return {
                        'picking_list_id': result[0],
                        'picked_by': result[1],
                        'picked_status': result[2],
                        'picked_date': result[3],
                        'warehouse_id': result[4],
                        'warehouse_name': warehouse_name
                    }
        except Exception as e:
            print(f"Error getting picking list info: {str(e)}")
        
        return None
    
    def get_packing_cost_info(self, obj):
        """
        Get information about the related packing cost.
        """
        if not obj.packing_cost_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT packing_cost_id, material_cost, labor_cost, total_packing_cost
                    FROM distribution.packing_cost
                    WHERE packing_cost_id = %s
                """, [obj.packing_cost_id])
                result = cursor.fetchone()
                
                if result:
                    return {
                        'packing_cost_id': result[0],
                        'material_cost': float(result[1]),
                        'labor_cost': float(result[2]),
                        'total_packing_cost': float(result[3])
                    }
        except Exception as e:
            print(f"Error getting packing cost info: {str(e)}")
        
        return None