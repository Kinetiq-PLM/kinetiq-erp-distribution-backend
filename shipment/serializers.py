# shipment/serializers.py
from rest_framework import serializers
from .models import (
    Carrier, ShippingCost, OperationalCost, 
    FailedShipment, ShipmentDetails, DeliveryReceipt, Customers
)
from django.db import connection

class CarrierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Carrier
        fields = ['carrier_id', 'carrier_name', 'service_type', 'carrier_count']

class ShippingCostSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingCost
        fields = ['shipping_cost_id', 'packing_list_id', 'cost_per_kg', 'cost_per_km', 
                 'weight_kg', 'distance_km', 'total_shipping_cost']

class OperationalCostSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationalCost
        fields = ['operational_cost_id', 'additional_cost', 'total_operational_cost', 
                 'shipping_cost_id', 'packing_cost_id']

class FailedShipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = FailedShipment
        fields = ['failed_shipment_id', 'failure_date', 'failure_reason', 
                 'resolution_status', 'shipment_id']

class DeliveryReceiptSerializer(serializers.ModelSerializer):
    rejection_reason = serializers.CharField(required=False, write_only=True)
    
    class Meta:
        model = DeliveryReceipt
        fields = ['delivery_receipt_id', 'delivery_date', 'received_by', 'signature', 
                 'receipt_status', 'shipment_id', 'total_amount', 'receiving_module', 
                 'rejection_reason']  # Add rejection_reason to fields

class ShipmentDetailsSerializer(serializers.ModelSerializer):
    carrier_name = serializers.SerializerMethodField()
    carrier_service_type = serializers.SerializerMethodField()
    delivery_type = serializers.SerializerMethodField()
    delivery_id = serializers.SerializerMethodField()
    source_location = serializers.SerializerMethodField()
    destination_location = serializers.SerializerMethodField()
    delivery_receipt_id = serializers.SerializerMethodField()
    delivery_receipt_info = serializers.SerializerMethodField()
    shipping_cost_info = serializers.SerializerMethodField()
    operational_cost_info = serializers.SerializerMethodField()
    packing_list_info = serializers.SerializerMethodField()
    items_details = serializers.SerializerMethodField()
    source_warehouses = serializers.SerializerMethodField()
    
    class Meta:
        model = ShipmentDetails
        fields = ['shipment_id', 'carrier_id', 'carrier_name', 'carrier_service_type',
                 'shipment_date', 'shipment_status', 'tracking_number',
                 'estimated_arrival_date', 'actual_arrival_date', 'packing_list_id',
                 'shipping_cost_id', 'delivery_type', 'delivery_id',
                 'source_location', 'destination_location', 'delivery_receipt_id',
                 'delivery_receipt_info', 'shipping_cost_info', 'operational_cost_info',
                 'packing_list_info', 'items_details', 'source_warehouses']
    
    def get_carrier_name(self, obj):
        """Get the name of the carrier"""
        if not obj.carrier_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT carrier_name
                    FROM distribution.carrier
                    WHERE carrier_id = %s
                """, [obj.carrier_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting carrier name: {str(e)}")
            
        return None
    
    def get_carrier_service_type(self, obj):
        """Get the service type of the carrier"""
        if not obj.carrier_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT service_type
                    FROM distribution.carrier
                    WHERE carrier_id = %s
                """, [obj.carrier_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting carrier service type: {str(e)}")
            
        return None
    
    def get_delivery_type(self, obj):
        """
        Determine the type of delivery associated with this shipment.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery.del_type
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    return result[0]
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
                    SELECT 
                        delivery.sales_order_id, 
                        delivery.service_order_id, 
                        delivery.content_id, 
                        delivery.stock_transfer_id
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result:
                    # Return the first non-null ID found
                    for id_value in result:
                        if id_value:
                            return id_value
        except Exception as e:
            print(f"Error getting delivery ID: {str(e)}")
            
        return None
    
    def get_source_location(self, obj):
        """
        Get the source location(s) of the shipment based on warehouse information.
        Returns the primary warehouse location or indicates multiple warehouses.
        """
        # Get the items details which will include warehouse information
        items_details = self.get_items_details(obj)
        unique_warehouses = {}
        
        # Collect unique warehouses from items
        for item in items_details:
            if item.get('warehouse_id') and item.get('warehouse_name'):
                warehouse_id = item.get('warehouse_id')
                if warehouse_id not in unique_warehouses:
                    unique_warehouses[warehouse_id] = item.get('warehouse_name')
        
        # If we have warehouses from items, use those
        if unique_warehouses:
            if len(unique_warehouses) == 1:
                # Return the single warehouse name
                return list(unique_warehouses.values())[0]
            else:
                # Return first warehouse and indicate multiple
                first_warehouse = list(unique_warehouses.values())[0]
                return f"{first_warehouse} (+{len(unique_warehouses)-1} more warehouses)"
        
        # Fallback to existing logic if no warehouses found in items
        try:
            # First check if this is a stock transfer
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery.stock_transfer_id
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s AND delivery.stock_transfer_id IS NOT NULL
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    # This is a stock transfer, get the source warehouse
                    cursor.execute("""
                        SELECT w.warehouse_location
                        FROM inventory.warehouse_movement wm
                        JOIN admin.warehouse w ON wm.source = w.warehouse_id
                        WHERE wm.movement_id = %s
                    """, [result[0]])
                    source_result = cursor.fetchone()
                    
                    if source_result and source_result[0]:
                        return source_result[0]
                
                # For other shipment types, use the warehouse from the picking list
                cursor.execute("""
                    SELECT w.warehouse_location
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    LEFT JOIN admin.warehouse w ON pkl.warehouse_id = w.warehouse_id
                    WHERE sd.shipment_id = %s AND w.warehouse_location IS NOT NULL
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting source location: {str(e)}")
            
        return None
    
    def get_destination_location(self, obj):
        """
        Get the destination location of the shipment.
        """
        try:
            # First check if this is a stock transfer
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery.stock_transfer_id
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s AND delivery.stock_transfer_id IS NOT NULL
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    # This is a stock transfer, get the destination warehouse
                    cursor.execute("""
                        SELECT w.warehouse_location
                        FROM inventory.warehouse_movement wm
                        JOIN admin.warehouse w ON wm.destination = w.warehouse_id
                        WHERE wm.movement_id = %s
                    """, [result[0]])
                    dest_result = cursor.fetchone()
                    
                    if dest_result and dest_result[0]:
                        return dest_result[0]
                
                # For external deliveries (sales/service), try to get customer address
                cursor.execute("""
                    SELECT 
                        delivery.sales_order_id,
                        delivery.service_order_id
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result:
                    sales_order_id = result[0]
                    service_order_id = result[1]
                    
                    if sales_order_id:
                        # Get customer address from sales order
                        cursor.execute("""
                            SELECT 
                                c.address_line1 || 
                                CASE WHEN c.address_line2 IS NOT NULL THEN ', ' || c.address_line2 ELSE '' END ||
                                ', ' || c.city || 
                                ', ' || c.postal_code || 
                                ', ' || c.country
                            FROM sales.orders o
                            JOIN sales.statement s ON o.statement_id = s.statement_id
                            JOIN sales.customers c ON s.customer_id = c.customer_id
                            WHERE o.order_id = %s
                        """, [sales_order_id])
                        addr_result = cursor.fetchone()
                        
                        if addr_result and addr_result[0]:
                            return addr_result[0]
                    
                    elif service_order_id:
                        # First try to get address directly from services.delivery_order table
                        cursor.execute("""
                            SELECT customer_address
                            FROM services.delivery_order
                            WHERE delivery_order_id = %s
                        """, [service_order_id])
                        direct_addr_result = cursor.fetchone()
                        
                        if direct_addr_result and direct_addr_result[0]:
                            return direct_addr_result[0]
                        
                        # If no direct address, fall back to getting it from customer record
                        cursor.execute("""
                            SELECT 
                                c.address_line1 || 
                                CASE WHEN c.address_line2 IS NOT NULL THEN ', ' || c.address_line2 ELSE '' END ||
                                ', ' || c.city || 
                                ', ' || c.postal_code || 
                                ', ' || c.country
                            FROM services.service_order so
                            JOIN sales.customers c ON so.customer_id = c.customer_id
                            WHERE so.service_order_id = %s
                        """, [service_order_id])
                        addr_result = cursor.fetchone()
                        
                        if addr_result and addr_result[0]:
                            return addr_result[0]
        except Exception as e:
            print(f"Error getting destination location: {str(e)}")
            
        return None
    def get_delivery_receipt_id(self, obj):
        """
        Get the delivery receipt ID associated with this shipment.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT delivery_receipt_id
                    FROM distribution.delivery_receipt
                    WHERE shipment_id = %s
                """, [obj.shipment_id])
                result = cursor.fetchone()
                
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting delivery receipt ID: {str(e)}")
            
        return None
    
    def get_delivery_receipt_info(self, obj):
        """
        Get information about the delivery receipt associated with this shipment.
        """
        delivery_receipt_id = self.get_delivery_receipt_id(obj)
        if not delivery_receipt_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        delivery_receipt_id, 
                        delivery_date, 
                        received_by, 
                        signature, 
                        receipt_status, 
                        total_amount,
                        receiving_module
                    FROM distribution.delivery_receipt
                    WHERE delivery_receipt_id = %s
                """, [delivery_receipt_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    receipt_data = dict(zip(columns, result))
                    
                    # Handle decimal types
                    if receipt_data.get('total_amount') is not None:
                        receipt_data['total_amount'] = float(receipt_data['total_amount'])
                    
                    return receipt_data
        except Exception as e:
            print(f"Error getting delivery receipt info: {str(e)}")
            
        return None
    
    def get_shipping_cost_info(self, obj):
        """
        Get information about the shipping cost associated with this shipment.
        """
        if not obj.shipping_cost_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        shipping_cost_id, 
                        cost_per_kg, 
                        cost_per_km, 
                        weight_kg, 
                        distance_km, 
                        total_shipping_cost
                    FROM distribution.shipping_cost
                    WHERE shipping_cost_id = %s
                """, [obj.shipping_cost_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    cost_data = dict(zip(columns, result))
                    
                    # Handle decimal types
                    for key in ['cost_per_kg', 'cost_per_km', 'weight_kg', 'distance_km', 'total_shipping_cost']:
                        if cost_data.get(key) is not None:
                            cost_data[key] = float(cost_data[key])
                    
                    return cost_data
        except Exception as e:
            print(f"Error getting shipping cost info: {str(e)}")
            
        return None
    
    def get_operational_cost_info(self, obj):
        """
        Get information about the operational cost associated with this shipment.
        """
        if not obj.shipping_cost_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT 
                        operational_cost_id, 
                        additional_cost, 
                        total_operational_cost,
                        packing_cost_id
                    FROM distribution.operational_cost
                    WHERE shipping_cost_id = %s
                """, [obj.shipping_cost_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    cost_data = dict(zip(columns, result))
                    
                    # Handle decimal types
                    for key in ['additional_cost', 'total_operational_cost']:
                        if cost_data.get(key) is not None:
                            cost_data[key] = float(cost_data[key])
                    
                    return cost_data
        except Exception as e:
            print(f"Error getting operational cost info: {str(e)}")
            
        return None
    
    def get_packing_list_info(self, obj):
        """
        Get information about the packing list associated with this shipment.
        """
        if not obj.packing_list_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                # Get basic packing list info
                cursor.execute("""
                    SELECT 
                        packing_list_id, 
                        packed_by, 
                        packing_status, 
                        packing_type, 
                        total_items_packed,
                        packing_cost_id,
                        packing_date
                    FROM distribution.packing_list
                    WHERE packing_list_id = %s
                """, [obj.packing_list_id])
                columns = [col[0] for col in cursor.description]
                result = cursor.fetchone()
                
                if result:
                    packing_data = dict(zip(columns, result))
                    
                    # Get packing cost info if available
                    if packing_data.get('packing_cost_id'):
                        cursor.execute("""
                            SELECT 
                                material_cost, 
                                labor_cost, 
                                total_packing_cost
                            FROM distribution.packing_cost
                            WHERE packing_cost_id = %s
                        """, [packing_data['packing_cost_id']])
                        cost_columns = [col[0] for col in cursor.description]
                        cost_result = cursor.fetchone()
                        
                        if cost_result:
                            cost_data = dict(zip(cost_columns, cost_result))
                            
                            # Handle decimal types
                            for key in ['material_cost', 'labor_cost', 'total_packing_cost']:
                                if cost_data.get(key) is not None:
                                    cost_data[key] = float(cost_data[key])
                            
                            packing_data['packing_cost_info'] = cost_data
                    
                    return packing_data
        except Exception as e:
            print(f"Error getting packing list info: {str(e)}")
            
        return None
    
    def get_items_details(self, obj):
        """
        Get details of items in this shipment.
        """
        items = []
        
        try:
            with connection.cursor() as cursor:
                # Get the delivery type and ID
                cursor.execute("""
                    SELECT 
                        delivery.del_type,
                        delivery.sales_order_id, 
                        delivery.service_order_id,
                        delivery.content_id,
                        delivery.stock_transfer_id
                    FROM distribution.shipment_details sd
                    JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                    JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order delivery ON lar.del_order_id = delivery.del_order_id
                    WHERE sd.shipment_id = %s
                """, [obj.shipment_id])
                
                del_result = cursor.fetchone()
                if not del_result:
                    return items
                
                del_type = del_result[0]
                sales_order_id = del_result[1]
                service_order_id = del_result[2]
                content_id = del_result[3]
                stock_transfer_id = del_result[4]
                
                # Map delivery types from del_type to the correct processing type
                delivery_type = None
                delivery_id = None
                
                # Determine delivery type based on which ID is present and del_type
                if sales_order_id:
                    delivery_type = "sales"
                    delivery_id = sales_order_id
                elif service_order_id:
                    delivery_type = "service"
                    delivery_id = service_order_id
                elif content_id:
                    delivery_type = "content"
                    delivery_id = content_id
                elif stock_transfer_id:
                    delivery_type = "stock"
                    delivery_id = stock_transfer_id
                    
                if not delivery_id:
                    return items
                    
                print(f"Processing items for {delivery_type} delivery with ID {delivery_id}")
                    
                # Fetch items based on delivery type
                if delivery_type == "sales":
                    cursor.execute("""
                        SELECT
                            si.inventory_item_id,
                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            si.quantity,
                            ii.warehouse_id,
                            w.warehouse_location as warehouse_name,
                            ii.item_no
                        FROM sales.orders o
                        JOIN sales.statement s ON o.statement_id = s.statement_id
                        JOIN sales.statement_item si ON s.statement_id = si.statement_id
                        LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                        WHERE o.order_id = %s
                    """, [delivery_id])
                    
                    columns = [col[0] for col in cursor.description]
                    result_items = cursor.fetchall()
                    print(f"Found {len(result_items)} sales items for order {delivery_id}")
                    
                    items = [dict(zip(columns, row)) for row in result_items]
                    
                    # If no items found, try getting from picking list
                    if not items:
                        print(f"No items found directly. Trying to get from picking list...")
                        cursor.execute("""
                            SELECT
                                pl_item.item_id as inventory_item_id,
                                COALESCE(imd.item_name, pl_item.item_id, 'Unknown Item') as item_name,
                                pl_item.quantity,
                                pl_item.warehouse_id,
                                w.warehouse_location as warehouse_name,
                                pl_item.item_number as item_no
                            FROM distribution.shipment_details sd
                            JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                            JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                            JOIN distribution.picking_list_item pl_item ON pkl.picking_list_id = pl_item.picking_list_id
                            LEFT JOIN admin.item_master_data imd ON pl_item.item_id = imd.item_id
                            LEFT JOIN admin.warehouse w ON pl_item.warehouse_id = w.warehouse_id
                            WHERE sd.shipment_id = %s
                        """, [obj.shipment_id])
                        
                        columns = [col[0] for col in cursor.description]
                        result_items = cursor.fetchall()
                        print(f"Found {len(result_items)} items from picking list")
                        
                        items = [dict(zip(columns, row)) for row in result_items]
                elif delivery_type == "service":
                    cursor.execute("""
                        SELECT
                            soi.item_id as inventory_item_id,
                            COALESCE(imd.item_name, soi.item_name, ii.item_id, 'Unknown Item') as item_name,
                            soi.item_quantity as quantity,
                            COALESCE(soi.warehouse_id, ii.warehouse_id) as warehouse_id,
                            w.warehouse_location as warehouse_name,
                            ii.item_no
                        FROM services.delivery_order sdo
                        JOIN services.service_order so ON sdo.service_order_id = so.service_order_id
                        JOIN services.service_order_item soi ON so.service_order_id = soi.service_order_id
                        LEFT JOIN inventory.inventory_item ii ON soi.item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON COALESCE(soi.warehouse_id, ii.warehouse_id) = w.warehouse_id
                        WHERE sdo.delivery_order_id = %s AND soi.item_quantity > 0
                    """, [delivery_id])
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]

                elif delivery_type == "content":
                    cursor.execute("""
                        SELECT
                            di.item_id as inventory_item_id,
                            COALESCE(imd.item_name, 'Unknown Item') as item_name,
                            di.quantity,
                            di.warehouse_id,
                            w.warehouse_location as warehouse_name,
                            di.item_no
                        FROM operations.document_items di
                        LEFT JOIN admin.item_master_data imd ON di.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON di.warehouse_id = w.warehouse_id
                        WHERE di.content_id = %s AND di.quantity > 0
                    """, [delivery_id])
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]

                elif delivery_type == "stock":
                    cursor.execute("""
                        SELECT
                            wmi.inventory_item_id,
                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            wmi.quantity,
                            wm.source as warehouse_id,
                            w.warehouse_location as warehouse_name,
                            ii.item_no
                        FROM inventory.warehouse_movement_items wmi
                        JOIN inventory.warehouse_movement wm ON wmi.movement_id = wm.movement_id
                        LEFT JOIN inventory.inventory_item ii ON wmi.inventory_item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON wm.source = w.warehouse_id
                        WHERE wmi.movement_id = %s AND wmi.quantity > 0
                    """, [delivery_id])
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    
        except Exception as e:
            print(f"Error getting items details for shipment {obj.shipment_id}: {str(e)}")
            import traceback
            traceback.print_exc()
            
        return items
        
    def get_source_warehouses(self, obj):
        """
        Get all source warehouses with their locations.
        """
        # First try to get warehouses from items_details
        items_details = self.get_items_details(obj)
        unique_warehouses = {}
        
        # Collect unique warehouses from items
        for item in items_details:
            if item.get('warehouse_id') and item.get('warehouse_name'):
                warehouse_id = item.get('warehouse_id')
                if warehouse_id not in unique_warehouses:
                    unique_warehouses[warehouse_id] = {
                        'id': warehouse_id,
                        'name': item.get('warehouse_name'),
                        'location': item.get('warehouse_name')
                    }
        
        # If no warehouses found from items, try to get from picking list
        if not unique_warehouses:
            try:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT DISTINCT 
                            w.warehouse_id,
                            w.warehouse_location
                        FROM distribution.shipment_details sd
                        JOIN distribution.packing_list pl ON sd.packing_list_id = pl.packing_list_id
                        JOIN distribution.picking_list pkl ON pl.picking_list_id = pkl.picking_list_id
                        JOIN admin.warehouse w ON pkl.warehouse_id = w.warehouse_id
                        WHERE sd.shipment_id = %s
                    """, [obj.shipment_id])
                    
                    for row in cursor.fetchall():
                        warehouse_id, warehouse_name = row
                        if warehouse_id and warehouse_id not in unique_warehouses:
                            unique_warehouses[warehouse_id] = {
                                'id': warehouse_id,
                                'name': warehouse_name,
                                'location': warehouse_name
                            }
            except Exception as e:
                print(f"Error getting source warehouses: {str(e)}")
        
        return list(unique_warehouses.values())
    
class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customers
        fields = ['customer_id', 'name', 'contact_person', 'email_address', 'phone_number', 
                 'address_line1', 'address_line2', 'city', 'postal_code', 'country']