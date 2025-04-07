# picking/serializers.py
from rest_framework import serializers
from .models import PickingList
from django.db import connection

class PickingListSerializer(serializers.ModelSerializer):
    delivery_type = serializers.SerializerMethodField()
    delivery_id = serializers.SerializerMethodField()
    items_count = serializers.SerializerMethodField()
    warehouse_name = serializers.SerializerMethodField()
    is_external = serializers.SerializerMethodField()  # Add this field
    
    class Meta:
        model = PickingList
        fields = ['picking_list_id', 'warehouse_id', 'warehouse_name', 'picked_by', 
                 'picked_status', 'picked_date', 'approval_request_id', 
                 'delivery_type', 'delivery_id', 'items_count', 'is_external']
    
    def get_is_external(self, obj):
        """
        Determine if this is an external order (sales or service) or internal (content or stock).
        """
        delivery_type = self.get_delivery_type(obj)
        return delivery_type in ['sales', 'service']
    
    def get_delivery_type(self, obj):
        """
        Determine the type of delivery associated with this picking list.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT sales_order_id, service_order_id, content_id, stock_transfer_id
                    FROM distribution.delivery_order
                    WHERE del_order_id = (
                        SELECT del_order_id
                        FROM distribution.logistics_approval_request
                        WHERE approval_request_id = %s
                    )
                """, [obj.approval_request_id])
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
                    SELECT sales_order_id, service_order_id, content_id, stock_transfer_id
                    FROM distribution.delivery_order
                    WHERE del_order_id = (
                        SELECT del_order_id
                        FROM distribution.logistics_approval_request
                        WHERE approval_request_id = %s
                    )
                """, [obj.approval_request_id])
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
    
    def get_items_count(self, obj):
        """
        Get the count of items to be picked based on the delivery type.
        """
        try:
            delivery_type = self.get_delivery_type(obj)
            delivery_id = self.get_delivery_id(obj)
            
            if not delivery_type or not delivery_id:
                return 0
                
            with connection.cursor() as cursor:
                # For stock transfers
                if delivery_type == "stock":
                    cursor.execute("""
                        SELECT quantity
                        FROM inventory.warehouse_movement
                        WHERE movement_id = %s
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
                
                # For content deliveries
                elif delivery_type == "content":
                    cursor.execute("""
                        SELECT quantity
                        FROM operations.document_items
                        WHERE content_id = %s
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
                
                # For sales orders
                elif delivery_type == "sales":
                    cursor.execute("""
                        SELECT SUM(quantity)
                        FROM sales.statement_item
                        WHERE statement_id = (
                            SELECT statement_id
                            FROM sales.orders
                            WHERE order_id = %s
                        )
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
                
                # For service orders
                elif delivery_type == "service":
                    cursor.execute("""
                        SELECT item_quantity
                        FROM services.service_order_item
                        WHERE service_order_item_id = (
                            SELECT service_order_item_id
                            FROM services.delivery_order
                            WHERE delivery_order_id = %s
                        )
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
        except Exception as e:
            print(f"Error getting items count: {str(e)}")
        
        return 0
    
    def get_warehouse_name(self, obj):
        """
        Get the warehouse name based on the warehouse_id.
        """
        if not obj.warehouse_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT warehouse_location
                    FROM admin.warehouse
                    WHERE warehouse_id = %s
                """, [obj.warehouse_id])
                result = cursor.fetchone()
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting warehouse name: {str(e)}")
        
        return None