# picking/serializers.py
from rest_framework import serializers
from .models import PickingList, PickingItem
from django.db import connection

class PickingItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = PickingItem
        fields = '__all__'

class PickingListSerializer(serializers.ModelSerializer):
    delivery_type = serializers.SerializerMethodField()
    delivery_id = serializers.SerializerMethodField()
    warehouse_name = serializers.SerializerMethodField()
    is_external = serializers.SerializerMethodField()
    items_details = serializers.SerializerMethodField() # New field for item details
    warehouse_id = serializers.SerializerMethodField() # Ensure warehouse_id is fetched
    picking_items = PickingItemSerializer(many=True, read_only=True)
    picking_progress = serializers.SerializerMethodField()

    class Meta:
        model = PickingList
        fields = ['picking_list_id', 'warehouse_id', 'warehouse_name', 'picked_by',
                 'picked_status', 'picked_date', 'approval_request_id',
                 'delivery_type', 'delivery_id', 'items_details', 'is_external', 'picking_items', 'picking_progress'] # Updated fields

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
                    SELECT del_order.sales_order_id, del_order.service_order_id, del_order.content_id, del_order.stock_transfer_id
                    FROM distribution.picking_list pkl
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order del_order ON lar.del_order_id = del_order.del_order_id
                    WHERE pkl.picking_list_id = %s
                """, [obj.picking_list_id]) # Use picking_list_id directly
                result = cursor.fetchone()

                if result:
                    if result[0]: return "sales"
                    if result[1]: return "service"
                    if result[2]: return "content"
                    if result[3]: return "stock"
        except Exception as e:
            print(f"Error getting delivery type for picking list {obj.picking_list_id}: {str(e)}")
        return None

    def get_delivery_id(self, obj):
        """
        Get the specific delivery ID based on the type of delivery.
        """
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT del_order.sales_order_id, del_order.service_order_id, del_order.content_id, del_order.stock_transfer_id
                    FROM distribution.picking_list pkl
                    JOIN distribution.logistics_approval_request lar ON pkl.approval_request_id = lar.approval_request_id
                    JOIN distribution.delivery_order del_order ON lar.del_order_id = del_order.del_order_id
                    WHERE pkl.picking_list_id = %s
                """, [obj.picking_list_id]) # Use picking_list_id directly
                result = cursor.fetchone()

                if result:
                    # Return the first non-null ID found
                    for id_value in result:
                        if id_value:
                            return id_value
        except Exception as e:
            print(f"Error getting delivery ID for picking list {obj.picking_list_id}: {str(e)}")
        return None

    def get_warehouse_id(self, obj):
        """
        Get the warehouse ID. For sales and service orders, derive from the first item.
        """
        # If warehouse_id is already set on the model, return it
        if obj.warehouse_id:
            return obj.warehouse_id
    
        # Get delivery type and ID
        delivery_type = self.get_delivery_type(obj)
        delivery_id = self.get_delivery_id(obj)
        
        if not delivery_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                # For sales orders
                if delivery_type == "sales":
                    # Find the warehouse_id from the first inventory item linked to the sales order
                    cursor.execute("""
                        SELECT ii.warehouse_id
                        FROM sales.orders o
                        JOIN sales.statement s ON o.statement_id = s.statement_id
                        JOIN sales.statement_item si ON s.statement_id = si.statement_id
                        JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                        WHERE o.order_id = %s AND ii.warehouse_id IS NOT NULL
                        LIMIT 1
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
                        
                # For service orders - Added this section
                elif delivery_type == "service":
                    # Find the warehouse_id from the service order items through delivery_order
                    cursor.execute("""
                        SELECT soi.warehouse_id
                        FROM services.delivery_order sdo
                        JOIN services.service_order so ON sdo.service_order_id = so.service_order_id
                        JOIN services.service_order_item soi ON so.service_order_id = soi.service_order_id
                        WHERE sdo.delivery_order_id = %s AND soi.warehouse_id IS NOT NULL
                        LIMIT 1
                    """, [delivery_id])
                    result = cursor.fetchone()
                    if result and result[0]:
                        return result[0]
        except Exception as e:
            print(f"Error getting warehouse_id for {delivery_type} {delivery_id}: {str(e)}")
        
        return None  # Return None if not found

    def get_warehouse_name(self, obj):
        """
        Get the warehouse name based on the warehouse_id.
        """
        warehouse_id = self.get_warehouse_id(obj) # Use the potentially derived warehouse_id
        if not warehouse_id:
            return None

        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT warehouse_location
                    FROM admin.warehouse
                    WHERE warehouse_id = %s
                """, [warehouse_id])
                result = cursor.fetchone()
                if result and result[0]:
                    return result[0]
        except Exception as e:
            print(f"Error getting warehouse name for ID {warehouse_id}: {str(e)}")
        return None

    def get_items_details(self, obj):
        """
        Get details of items to be picked based on the delivery type.
        """
        items = []
        delivery_type = self.get_delivery_type(obj)
        delivery_id = self.get_delivery_id(obj)

        if not delivery_type or not delivery_id:
            return items

        try:
            with connection.cursor() as cursor:
                if delivery_type == "sales":
                    cursor.execute("""
                        SELECT
                            si.inventory_item_id,
                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            si.quantity,
                            ii.warehouse_id,
                            w.warehouse_location as warehouse_name,
                            ii.item_no,
                            dn.delivery_note_id
                        FROM sales.orders o
                        JOIN sales.statement s ON o.statement_id = s.statement_id
                        JOIN sales.statement_item si ON s.statement_id = si.statement_id
                        LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                        LEFT JOIN sales.delivery_note dn ON dn.order_id = o.order_id
                        WHERE o.order_id = %s AND si.quantity > 0
                    """, [delivery_id])
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    
                    # For items without a specific delivery note assigned yet, 
                    # we can assign to the first available one for this order
                    if items and any(item.get('delivery_note_id') is None for item in items):
                        cursor.execute("""
                            SELECT delivery_note_id FROM sales.delivery_note
                            WHERE order_id = %s
                            ORDER BY created_at DESC
                            LIMIT 1
                        """, [delivery_id])
                        default_note = cursor.fetchone()
                        default_note_id = default_note[0] if default_note else None
                        
                        for item in items:
                            if item.get('delivery_note_id') is None:
                                item['delivery_note_id'] = default_note_id

                elif delivery_type == "service":
                    # Modified this query to properly join through delivery_order
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
                    # Direct join to admin.item_master_data without going through inventory_item
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
                    
                    # Add debug output to see what's coming back
                    raw_results = cursor.fetchall()
                    print(f"Content delivery query results: Found {len(raw_results)} items")
                    if len(raw_results) > 0:
                        print(f"First item details: {raw_results[0]}")
                    
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in raw_results]

                elif delivery_type == "stock":
                    cursor.execute("""
                        SELECT
                            wmi.inventory_item_id,
                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            wmi.quantity,
                            wm.source as warehouse_id, -- Source warehouse for stock transfer picking
                            w.warehouse_location as warehouse_name,
                            ii.item_no
                        FROM inventory.warehouse_movement_items wmi
                        JOIN inventory.warehouse_movement wm ON wmi.movement_id = wm.movement_id
                        LEFT JOIN inventory.inventory_item ii ON wmi.inventory_item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON wm.source = w.warehouse_id -- Warehouse is the source
                        WHERE wmi.movement_id = %s AND wmi.quantity > 0
                    """, [delivery_id])
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]

        except Exception as e:
            print(f"Error getting items details for {delivery_type} {delivery_id}: {str(e)}")
            import traceback
            traceback.print_exc()

        return items

    def get_picking_progress(self, obj):
        """Calculate picking progress for this picking list"""
        items = PickingItem.objects.filter(picking_list=obj)
        total_items = items.count()
        picked_items = items.filter(is_picked=True).count()
        
        if total_items == 0:
            return 0
        
        return int((picked_items / total_items) * 100)