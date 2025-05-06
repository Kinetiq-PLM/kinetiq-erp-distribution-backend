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
    items_details = serializers.SerializerMethodField()
    warehouse_id = serializers.SerializerMethodField()
    picking_items = PickingItemSerializer(many=True, read_only=True)
    picking_progress = serializers.SerializerMethodField()
    delivery_notes_info = serializers.SerializerMethodField()  # New field for partial delivery info

    class Meta:
        model = PickingList
        fields = ['picking_list_id', 'warehouse_id', 'warehouse_name', 'picked_by',
                 'picked_status', 'picked_date', 'approval_request_id',
                 'delivery_type', 'delivery_id', 'items_details', 'is_external', 
                 'picking_items', 'picking_progress', 'delivery_notes_info']

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
        warehouse_id = self.get_warehouse_id(obj)
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
            print(f"Error getting warehouse_name for warehouse_id {warehouse_id}: {str(e)}")
        
        return None

    def get_items_details(self, obj):
        delivery_type = self.get_delivery_type(obj)
        delivery_id = self.get_delivery_id(obj)
        items = []
        
        if not delivery_id:
            return items
            
        try:
            with connection.cursor() as cursor:
                if delivery_type == "sales":
                    # Check if this is a partial delivery
                    cursor.execute("""
                        SELECT COUNT(DISTINCT delivery_note_id)
                        FROM sales.delivery_note
                        WHERE order_id = %s
                    """, [delivery_id])
                    
                    count = cursor.fetchone()[0]
                    
                    if count > 1:  # This is a partial delivery
                        # Find delivery notes associated with this picking list
                        cursor.execute("""
                            SELECT DISTINCT delivery_note_id
                            FROM distribution.picking_item
                            WHERE picking_list_id = %s AND delivery_note_id IS NOT NULL
                        """, [obj.picking_list_id])
                        
                        delivery_note_ids = [row[0] for row in cursor.fetchall()]
                        
                        if not delivery_note_ids:
                            # If no delivery notes yet associated, find the first pending one
                            cursor.execute("""
                                SELECT delivery_note_id
                                FROM sales.delivery_note
                                WHERE order_id = %s AND 
                                      (shipment_status IS NULL OR shipment_status = 'Pending')
                                ORDER BY created_at ASC
                                LIMIT 1
                            """, [delivery_id])
                            
                            result = cursor.fetchone()
                            if result:
                                target_delivery_note_id = result[0]
                                
                                # Modified query to properly group and sum quantities
                                query = """
                                    SELECT
                                        si.inventory_item_id,
                                        COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                                        ii.item_no,
                                        SUM(si.quantity) as quantity,
                                        ii.warehouse_id,
                                        w.warehouse_location as warehouse_name,
                                        %s as delivery_note_id
                                    FROM sales.delivery_note dn
                                    JOIN sales.statement s ON dn.statement_id = s.statement_id
                                    JOIN sales.statement_item si ON s.statement_id = si.statement_id
                                    LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                                    LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                                    LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                                    WHERE dn.delivery_note_id = %s AND si.quantity > 0
                                    GROUP BY si.inventory_item_id, imd.item_name, ii.item_id, ii.item_no, ii.warehouse_id, w.warehouse_location
                                    ORDER BY item_name
                                """
                                
                                cursor.execute(query, [target_delivery_note_id, target_delivery_note_id])
                                columns = [col[0] for col in cursor.description]
                                items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                        else:
                            # Use existing delivery notes
                            placeholders = ','.join(['%s'] * len(delivery_note_ids))
                            params = delivery_note_ids
                            
                            query = f"""
                                SELECT
                                    si.inventory_item_id,
                                    COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                                    ii.item_no,
                                    SUM(si.quantity) as quantity,
                                    ii.warehouse_id,
                                    w.warehouse_location as warehouse_name,
                                    dn.delivery_note_id
                                FROM sales.delivery_note dn
                                JOIN sales.statement s ON dn.statement_id = s.statement_id
                                JOIN sales.statement_item si ON s.statement_id = si.statement_id
                                LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                                LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                                LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                                WHERE dn.delivery_note_id IN ({placeholders}) AND si.quantity > 0
                                GROUP BY si.inventory_item_id, imd.item_name, ii.item_id, ii.item_no, ii.warehouse_id, w.warehouse_location, dn.delivery_note_id
                                ORDER BY dn.delivery_note_id, item_name
                            """
                            
                            cursor.execute(query, params)
                            columns = [col[0] for col in cursor.description]
                            items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    else:
                        # For non-partial sales orders
                        cursor.execute("""
                            SELECT delivery_note_id 
                            FROM sales.delivery_note
                            WHERE order_id = %s
                            ORDER BY created_at DESC
                            LIMIT 1
                        """, [delivery_id])
                        
                        delivery_note = cursor.fetchone()
                        if delivery_note:
                            delivery_note_id = delivery_note[0]
                            
                            cursor.execute("""
                                SELECT
                                    si.inventory_item_id,
                                    COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                                    ii.item_no,
                                    si.quantity,
                                    ii.warehouse_id,
                                    w.warehouse_location as warehouse_name,
                                    %s as delivery_note_id
                                FROM sales.delivery_note dn
                                JOIN sales.statement s ON dn.statement_id = s.statement_id
                                JOIN sales.statement_item si ON s.statement_id = si.statement_id
                                LEFT JOIN inventory.inventory_item ii ON si.inventory_item_id = ii.inventory_item_id
                                LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                                LEFT JOIN admin.warehouse w ON ii.warehouse_id = w.warehouse_id
                                WHERE dn.delivery_note_id = %s AND si.quantity > 0
                            """, [delivery_note_id, delivery_note_id])
                            
                            columns = [col[0] for col in cursor.description]
                            items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                
                elif delivery_type == "service":
                    # Handle service orders - FIXED query to first get service_order_id from delivery_order_id
                    cursor.execute("""
                        SELECT
                            soi.item_id as inventory_item_id,
                            COALESCE(soi.item_name, imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            ii.item_no,
                            soi.item_quantity as quantity,
                            COALESCE(soi.warehouse_id, ii.warehouse_id) as warehouse_id,
                            w.warehouse_location as warehouse_name,
                            NULL as delivery_note_id
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
                    # Handle content deliveries
                    cursor.execute("""
                        SELECT
                            di.item_id as inventory_item_id,
                            COALESCE(imd.item_name, di.item_id, 'Unknown Item') as item_name,
                            NULL as item_no,
                            di.quantity,
                            di.warehouse_id,
                            w.warehouse_location as warehouse_name,
                            NULL as delivery_note_id
                        FROM operations.document_items di
                        LEFT JOIN admin.item_master_data imd ON di.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON di.warehouse_id = w.warehouse_id
                        WHERE di.content_id = %s AND di.quantity > 0
                    """, [delivery_id])
                    
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    
                elif delivery_type == "stock":
                    # Handle stock transfers
                    cursor.execute("""
                        SELECT
                            wmi.inventory_item_id,
                            COALESCE(imd.item_name, ii.item_id, 'Unknown Item') as item_name,
                            ii.item_no,
                            wmi.quantity,
                            wm.source as warehouse_id,
                            w.warehouse_location as warehouse_name,
                            NULL as delivery_note_id
                        FROM inventory.warehouse_movement wm
                        JOIN inventory.warehouse_movement_items wmi ON wm.movement_id = wmi.movement_id
                        LEFT JOIN inventory.inventory_item ii ON wmi.inventory_item_id = ii.inventory_item_id
                        LEFT JOIN admin.item_master_data imd ON ii.item_id = imd.item_id
                        LEFT JOIN admin.warehouse w ON wm.source = w.warehouse_id
                        WHERE wm.movement_id = %s AND wmi.quantity > 0
                    """, [delivery_id])
                    
                    columns = [col[0] for col in cursor.description]
                    items = [dict(zip(columns, row)) for row in cursor.fetchall()]
                    
        except Exception as e:
            print(f"Error getting items details: {str(e)}")
            
        return items

    def get_delivery_notes_info(self, obj):
        """
        Get partial delivery information if applicable (for sales orders).
        """
        delivery_type = self.get_delivery_type(obj)
        delivery_id = self.get_delivery_id(obj)

        if delivery_type != "sales" or not delivery_id:
            return None

        try:
            with connection.cursor() as cursor:
                # Check if the sales order exists
                cursor.execute("SELECT 1 FROM sales.orders WHERE order_id = %s", [delivery_id])
                if not cursor.fetchone():
                    return {"error": "Sales order not found"}

                # Get all delivery notes for the order
                cursor.execute("""
                    SELECT 
                        delivery_note_id,
                        shipment_status,
                        created_at,
                        shipment_id,
                        statement_id,
                        admin_override, -- Added admin override info
                        admin_override_reason,
                        admin_override_date,
                        ROW_NUMBER() OVER (ORDER BY created_at) as sequence_number
                    FROM sales.delivery_note
                    WHERE order_id = %s
                    ORDER BY created_at
                """, [delivery_id])
                
                columns = [col[0] for col in cursor.description]
                notes = [dict(zip(columns, row)) for row in cursor.fetchall()]

                if len(notes) <= 1:
                    # Not considered partial if only one note exists
                    return {
                        "is_partial_delivery": False,
                        "total_deliveries": len(notes),
                        "delivery_notes": notes
                    }

                # Count completed deliveries
                completed = sum(1 for note in notes if note.get('shipment_status') in ('Shipped', 'Delivered'))
                
                # Get item counts for each note
                for note in notes:
                    statement_id = note.get('statement_id')
                    if statement_id:
                        cursor.execute("""
                            SELECT COUNT(*), SUM(quantity)
                            FROM sales.statement_item
                            WHERE statement_id = %s
                        """, [statement_id])
                        item_counts = cursor.fetchone()
                        note['item_count'] = item_counts[0] if item_counts else 0
                        note['total_quantity'] = item_counts[1] if item_counts else 0
                    else:
                        note['item_count'] = 0
                        note['total_quantity'] = 0

                # Find the current delivery note (first one not Shipped or Delivered)
                current_delivery_index = next((i for i, n in enumerate(notes) 
                                            if n.get('shipment_status') not in ('Shipped', 'Delivered')), 
                                            len(notes)) # Default to end if all are completed
                current_delivery_number = current_delivery_index + 1

                return {
                    "is_partial_delivery": True,
                    "total_deliveries": len(notes),
                    "completed_deliveries": completed,
                    "current_delivery": current_delivery_number,
                    "delivery_notes": notes
                }

        except Exception as e:
            print(f"Error getting delivery notes info for order {delivery_id}: {str(e)}")
            return {"error": str(e)}

    def get_picking_progress(self, obj):
        """Calculate picking progress for this picking list"""
        items = PickingItem.objects.filter(picking_list=obj)
        total_items = items.count()
        picked_items = items.filter(is_picked=True).count()
        
        if total_items == 0:
            return 0
        
        return int((picked_items / total_items) * 100)

    def check_all_items_picked(picking_list_id):
        """
        Check if all items in a picking list have been picked.
        For partial deliveries, verify items by delivery note ID.
        """
        try:
            from picking.models import PickingItem
            
            items = PickingItem.objects.filter(picking_list_id=picking_list_id)
            
            if not items.exists():
                return False
                
            # Group items by delivery note
            delivery_notes = {}
            for item in items:
                delivery_note_id = item.delivery_note_id or 'no_note'
                if delivery_note_id not in delivery_notes:
                    delivery_notes[delivery_note_id] = []
                delivery_notes[delivery_note_id].append(item)
            
            # Check each delivery note's items
            for note_id, note_items in delivery_notes.items():
                if not all(item.is_picked for item in note_items):
                    return False
                    
            return True
        except Exception as e:
            print(f"Error checking if all items are picked: {str(e)}")
            return False

