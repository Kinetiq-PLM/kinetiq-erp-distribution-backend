# rework/serializers.py
from rest_framework import serializers
from .models import Rejection, ReworkOrder
from django.db import connection

class RejectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rejection
        fields = ['rejection_id', 'rejection_status', 'rejection_reason', 
                 'rejection_date', 'delivery_receipt_id']

class ReworkOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReworkOrder
        fields = ['rework_id', 'assigned_to', 'rework_status', 'rework_date', 
                 'expected_completion', 'rejection_id', 'failed_shipment_id', 'rework_types']

class DetailedReworkOrderSerializer(serializers.ModelSerializer):
    rejection_info = serializers.SerializerMethodField()
    failed_shipment_info = serializers.SerializerMethodField()
    source_info = serializers.SerializerMethodField()
    original_order_info = serializers.SerializerMethodField()
    
    class Meta:
        model = ReworkOrder
        fields = ['rework_id', 'assigned_to', 'rework_status', 'rework_date', 
                 'expected_completion', 'rejection_id', 'failed_shipment_id', 'rework_types',
                 'rejection_info', 'failed_shipment_info', 'source_info', 'original_order_info']
    
    def get_rejection_info(self, obj):
        """Get detailed information about the rejection if applicable"""
        if not obj.rejection_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        rejection_id, rejection_status, rejection_reason, 
                        rejection_date, delivery_receipt_id
                    FROM distribution.rejection
                    WHERE rejection_id = %s
                """, [obj.rejection_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    return dict(zip(columns, result))
        except Exception as e:
            print(f"Error getting rejection info: {str(e)}")
            
        return None
    
    def get_failed_shipment_info(self, obj):
        """Get detailed information about the failed shipment if applicable"""
        if not obj.failed_shipment_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        failed_shipment_id, failure_date, failure_reason, 
                        resolution_status, shipment_id
                    FROM distribution.failed_shipment
                    WHERE failed_shipment_id = %s
                """, [obj.failed_shipment_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    return dict(zip(columns, result))
        except Exception as e:
            print(f"Error getting failed shipment info: {str(e)}")
            
        return None
    
    def get_source_info(self, obj):
        """Get information about the source of the rework (delivery receipt or shipment)"""
        result = {}
        try:
            # If this is a rejection-based rework
            if obj.rejection_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT 
                            dr.delivery_receipt_id, dr.delivery_date, dr.receipt_status,
                            dr.received_by, sd.shipment_id, sd.tracking_number
                        FROM distribution.rejection r
                        JOIN distribution.delivery_receipt dr ON r.delivery_receipt_id = dr.delivery_receipt_id
                        JOIN distribution.shipment_details sd ON dr.shipment_id = sd.shipment_id
                        WHERE r.rejection_id = %s
                    """, [obj.rejection_id])
                    
                    columns = [col[0] for col in cursor.description]
                    db_result = cursor.fetchone()
                    
                    if db_result:
                        result = dict(zip(columns, db_result))
                        result['source_type'] = 'Rejection'
            
            # If this is a failed shipment-based rework
            elif obj.failed_shipment_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT 
                            fs.failed_shipment_id, fs.failure_date, fs.resolution_status,
                            sd.shipment_id, sd.tracking_number, sd.shipment_date
                        FROM distribution.failed_shipment fs
                        JOIN distribution.shipment_details sd ON fs.shipment_id = sd.shipment_id
                        WHERE fs.failed_shipment_id = %s
                    """, [obj.failed_shipment_id])
                    
                    columns = [col[0] for col in cursor.description]
                    db_result = cursor.fetchone()
                    
                    if db_result:
                        result = dict(zip(columns, db_result))
                        result['source_type'] = 'Failed Shipment'
            
            return result
        except Exception as e:
            print(f"Error getting source info: {str(e)}")
            
        return {}
    
    def get_original_order_info(self, obj):
        """Get information about the original order that led to this rework"""
        try:
            sales_order_id = None
            
            # If this is a rejection-based rework
            if obj.rejection_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT delivery.sales_order_id
                        FROM distribution.rejection r
                        JOIN distribution.delivery_receipt dr ON r.delivery_receipt_id = dr.delivery_receipt_id
                        JOIN distribution.shipment_details sd ON dr.shipment_id = sd.shipment_id
                        JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                        JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                        JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                        JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                        WHERE r.rejection_id = %s AND delivery.sales_order_id IS NOT NULL
                    """, [obj.rejection_id])
                    
                    result = cursor.fetchone()
                    if result and result[0]:
                        sales_order_id = result[0]
            
            # If this is a failed shipment-based rework
            elif obj.failed_shipment_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT delivery.sales_order_id
                        FROM distribution.failed_shipment fs
                        JOIN distribution.shipment_details sd ON fs.shipment_id = sd.shipment_id
                        JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                        JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                        JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                        JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                        WHERE fs.failed_shipment_id = %s AND delivery.sales_order_id IS NOT NULL
                    """, [obj.failed_shipment_id])
                    
                    result = cursor.fetchone()
                    if result and result[0]:
                        sales_order_id = result[0]
            
            # If we found a sales order, get additional details
            if sales_order_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT 
                            o.order_id, o.shipping_date, o.shipment_status,
                            c.customer_id, c.name AS customer_name
                        FROM sales.delivery_note o
                        JOIN sales.statement s ON o.statement_id = s.statement_id
                        JOIN sales.customers c ON s.customer_id = c.customer_id
                        WHERE o.order_id = %s
                    """, [sales_order_id])
                    
                    columns = [col[0] for col in cursor.description]
                    result = cursor.fetchone()
                    
                    if result:
                        return dict(zip(columns, result))
            
            return None
        except Exception as e:
            print(f"Error getting original order info: {str(e)}")
            
        return None