from django.db.models.signals import post_save
from django.dispatch import receiver
from django.db import connection
import json
import threading
import select
import psycopg2
import psycopg2.extensions
from django.conf import settings

# Import from management command
from delivery.management.commands.sync_delivery_orders import Command as SyncCommand

def listen_for_db_events():
    """
    Background thread that listens for PostgreSQL notifications
    """
    conn = psycopg2.connect(
        dbname=settings.DATABASES['default']['NAME'],
        user=settings.DATABASES['default']['USER'],
        password=settings.DATABASES['default']['PASSWORD'],
        host=settings.DATABASES['default']['HOST'],
        port=settings.DATABASES['default']['PORT']
    )
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    
    cursor = conn.cursor()
    cursor.execute("LISTEN new_sales_order;")
    cursor.execute("LISTEN new_service_order;")
    cursor.execute("LISTEN new_warehouse_movement;")
    cursor.execute("LISTEN new_document_item;")
    
    print("Listening for database notifications...")
    
    sync_command = SyncCommand()
    
    while True:
        if select.select([conn], [], [], 5) == ([], [], []):
            continue
            
        conn.poll()
        while conn.notifies:
            notify = conn.notifies.pop()
            channel = notify.channel
            payload = notify.payload
            print(f"Received notification on {channel}: {payload}")
            
            data = json.loads(payload)
            
            if channel == "new_sales_order":
                sync_command.create_delivery_order(data['id'], 'sales_order', True)
            elif channel == "new_service_order":
                sync_command.create_delivery_order(data['id'], 'service_order', True)
            elif channel == "new_warehouse_movement":
                sync_command.create_delivery_order(data['id'], 'stock_transfer', False)
            elif channel == "new_document_item":
                sync_command.create_delivery_order(data['id'], 'content', False)

# Start the listener thread when Django starts
def start_listener():
    thread = threading.Thread(target=listen_for_db_events, daemon=True)
    thread.start()
    print("PostgreSQL notification listener started")

# Create database triggers
def setup_db_triggers():
    with connection.cursor() as cursor:
        # Sales order trigger
        cursor.execute("""
        CREATE OR REPLACE FUNCTION notify_new_sales_order()
        RETURNS TRIGGER AS $$
        BEGIN
            PERFORM pg_notify('new_sales_order', json_build_object('id', NEW.order_id)::text);
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
        
        DROP TRIGGER IF EXISTS notify_sales_order_insert ON sales.orders;
        CREATE TRIGGER notify_sales_order_insert
        AFTER INSERT ON sales.orders
        FOR EACH ROW
        EXECUTE FUNCTION notify_new_sales_order();
        """)
        
        # Service order trigger
        cursor.execute("""
        CREATE OR REPLACE FUNCTION notify_new_service_order()
        RETURNS TRIGGER AS $$
        BEGIN
            PERFORM pg_notify('new_service_order', json_build_object('id', NEW.delivery_order_id)::text);
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
        
        DROP TRIGGER IF EXISTS notify_service_order_insert ON services.delivery_order;
        CREATE TRIGGER notify_service_order_insert
        AFTER INSERT ON services.delivery_order
        FOR EACH ROW
        EXECUTE FUNCTION notify_new_service_order();
        """)
        
        # Warehouse movement trigger
        cursor.execute("""
        CREATE OR REPLACE FUNCTION notify_new_warehouse_movement()
        RETURNS TRIGGER AS $$
        BEGIN
            PERFORM pg_notify('new_warehouse_movement', json_build_object('id', NEW.movement_id)::text);
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
        
        DROP TRIGGER IF EXISTS notify_warehouse_movement_insert ON inventory.warehouse_movement;
        CREATE TRIGGER notify_warehouse_movement_insert
        AFTER INSERT ON inventory.warehouse_movement
        FOR EACH ROW
        EXECUTE FUNCTION notify_new_warehouse_movement();
        """)
        
        # Document items trigger
        cursor.execute("""
        CREATE OR REPLACE FUNCTION notify_new_document_item()
        RETURNS TRIGGER AS $$
        BEGIN
            PERFORM pg_notify('new_document_item', json_build_object('id', NEW.content_id)::text);
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
        
        DROP TRIGGER IF EXISTS notify_document_item_insert ON operations.document_items;
        CREATE TRIGGER notify_document_item_insert
        AFTER INSERT ON operations.document_items
        FOR EACH ROW
        EXECUTE FUNCTION notify_new_document_item();
        """)

# Setup database triggers once at app startup
def setup_triggers_on_ready():
    try:
        setup_db_triggers()
        print("Database triggers created successfully")
        start_listener()
    except Exception as e:
        print(f"Error setting up database triggers: {str(e)}")