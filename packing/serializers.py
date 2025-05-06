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
    items_details = serializers.SerializerMethodField()
    delivery_notes_info = serializers.SerializerMethodField()
    
    class Meta:
        model = PackingList
        fields = ['packing_list_id', 'packed_by', 'packing_status', 'packing_type', 
                 'total_items_packed', 'packing_date', 'picking_list_id', 
                 'packing_cost_id', 'delivery_type', 'delivery_id', 'is_external',
                 'picking_list_info', 'packing_cost_info', 'items_details', 'delivery_notes_info']
    
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
    
    def get_delivery_notes_info(self, obj):
        """
        Get information about delivery notes for partial deliveries.
        """
        delivery_id = self.get_delivery_id(obj)
        delivery_type = self.get_delivery_type(obj)
        
        if delivery_type != 'sales' or not delivery_id:
            return None
            
        try:
            with connection.cursor() as cursor:
                # Get the picking list id to find which delivery notes this packing list is for
                picking_list_id = obj.picking_list_id
                
                if not picking_list_id:
                    return None
                    
                # First check if this is a partial delivery
                cursor.execute("""
                    SELECT COUNT(delivery_note_id)
                    FROM sales.delivery_note
                    WHERE order_id = %s
                """, [delivery_id])
                delivery_note_count = cursor.fetchone()[0]
                
                if delivery_note_count <= 1:
                    return None  # Not a partial delivery
                
                # Get all delivery notes for this order
                cursor.execute("""
                    SELECT 
                        delivery_note_id,
                        shipment_status,
                        created_at,
                        shipment_id,
                        statement_id,
                        ROW_NUMBER() OVER (ORDER BY created_at) as sequence_number
                    FROM sales.delivery_note
                    WHERE order_id = %s
                    ORDER BY created_at
                """, [delivery_id])
                
                columns = [col[0] for col in cursor.description]
                notes = [dict(zip(columns, row)) for row in cursor.fetchall()]
                
                # Get the delivery notes specifically for this packing list
                cursor.execute("""
                    SELECT DISTINCT delivery_note_id
                    FROM distribution.picking_item
                    WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                """, [picking_list_id])
                
                current_note_ids = [row[0] for row in cursor.fetchall()]
                
                # Count completed deliveries
                completed = sum(1 for note in notes if note.get('shipment_status') in ('Shipped', 'Delivered'))
                
                # For each delivery note, get the items count
                for note in notes:
                    statement_id = note.get('statement_id')
                    if statement_id:
                        cursor.execute("""
                            SELECT COUNT(*), SUM(quantity)
                            FROM sales.statement_item
                            WHERE statement_id = %s
                        """, [statement_id])
                        
                        item_counts = cursor.fetchone()
                        if item_counts:
                            note['item_count'] = item_counts[0] or 0
                            note['total_quantity'] = item_counts[1] or 0
                        else:
                            note['item_count'] = 0
                            note['total_quantity'] = 0
                    
                    # Mark if this note is part of the current packing list
                    note['is_current'] = note.get('delivery_note_id') in current_note_ids
                
                return {
                    "is_partial_delivery": True,
                    "total_deliveries": len(notes),
                    "completed_deliveries": completed,
                    "current_delivery_notes": current_note_ids,
                    "current_delivery": next((i+1 for i, n in enumerate(notes) 
                                    if n.get('delivery_note_id') in current_note_ids), None),
                    "delivery_notes": notes
                }
                
        except Exception as e:
            print(f"Error getting delivery notes info: {str(e)}")
            import traceback
            traceback.print_exc()
            
        return None
        
    def get_items_details(self, obj):
        """
        Get details of items in the packing list based on the delivery type.
        For partial deliveries, filter by the delivery note IDs related to this packing list.
        """
        items = []
        delivery_type = self.get_delivery_type(obj)
        delivery_id = self.get_delivery_id(obj)

        if not delivery_type or not delivery_id:
            return items

        try:
            with connection.cursor() as cursor:
                # First get the related picking list to find associated delivery notes (for partial deliveries)
                if delivery_type == "sales" and obj.picking_list_id:
                    cursor.execute("""
                        SELECT DISTINCT delivery_note_id
                        FROM distribution.picking_item
                        WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                    """, [obj.picking_list_id])
                    
                    delivery_note_ids = [row[0] for row in cursor.fetchall()]
                    
                    if delivery_note_ids:
                        # This is a partial delivery - only get items for the selected delivery notes
                        placeholders = ','.join(['%s'] * len(delivery_note_ids))
                        query = f"""
                            SELECT
                                si.inventory_item_id,
                                COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                                si.quantity,
                                ii.warehouse_id,
                                w.warehouse_location as warehouse_name,
                                ii.item_no,
                                dn.delivery_note_id
                            FROM sales.delivery_note dn
                            JOIN sales.statement s ON dn.statement_id = s.statement_id
                            JOIN sales.statement_item si ON s.statement_id = si.statement_id
                            LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                            LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                            LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                            WHERE dn.delivery_note_id IN ({placeholders}) AND si.quantity > 0
                        """
                        cursor.execute(query, delivery_note_ids)
                        columns = [col[0] for col in cursor.description]
                        items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    else:
                        # Regular (non-partial) sales order
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
                            WHERE o.order_id = %s AND si.quantity > 0
                        """, [delivery_id])
                        columns = [col[0] for col in cursor.description]
                        items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                
                # We'll add other delivery types (service, content, stock) with the same pattern
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
            print(f"Error getting items details for {delivery_type} {delivery_id}: {str(e)}")
            import traceback
            traceback.print_exc()

        return items
    
    def validate_packed_quantities(self, obj, packed_items_data):
        """
        Validate that packed quantities don't exceed available quantities from statement_items.
        """
        if not packed_items_data:
            return True
            
        delivery_note_ids = self.get_delivery_note_ids(obj)
        if not delivery_note_ids:
            return True
            
        errors = []
        
        with connection.cursor() as cursor:
            for note_id in delivery_note_ids:
                # Get statement_id for this delivery note
                cursor.execute("""
                    SELECT statement_id
                    FROM sales.delivery_note
                    WHERE delivery_note_id = %s
                """, [note_id])
                statement_result = cursor.fetchone()
                
                if statement_result and statement_result[0]:
                    statement_id = statement_result[0]
                    
                    # Get items and AGGREGATED quantities from statement_item
                    cursor.execute("""
                        SELECT inventory_item_id, SUM(quantity) as total_quantity
                        FROM sales.statement_item
                        WHERE statement_id = %s
                        GROUP BY inventory_item_id
                    """, [statement_id])
                    
                    statement_items = {row[0]: row[1] for row in cursor.fetchall()}
                    
                    # Check packed quantities against aggregated statement items
                    for warehouse_id, warehouse_items in packed_items_data.items():
                        for dn_id, delivery_note_items in warehouse_items.items():
                            if dn_id == note_id:
                                for item_id, item_data in delivery_note_items.items():
                                    packed_qty = item_data.get('packedQuantity', 0)
                                    max_qty = statement_items.get(item_id, 0)
                                    
                                    if packed_qty > max_qty:
                                        errors.append(f"Item {item_id} in delivery note {note_id} exceeds available quantity ({packed_qty} > {max_qty})")
        
        if errors:
            raise ValidationError({"packed_items_data": errors})
        
        return True

    def get_delivery_note_ids(self, obj):
        """
        Get delivery note IDs associated with this packing list's picking list.
        """
        if not obj.picking_list_id:
            return []
            
        try:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT DISTINCT delivery_note_id
                    FROM distribution.picking_item
                    WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                """, [obj.picking_list_id])
                
                return [row[0] for row in cursor.fetchall()]
        except Exception as e:
            print(f"Error getting delivery note IDs: {str(e)}")
            return []