from apscheduler.schedulers.background import BackgroundScheduler
from django.core.management import call_command
import logging
import sys

logger = logging.getLogger(__name__)

def sync_delivery_orders_job():
    try:
        logger.info("Running sync_delivery_orders command...")
        call_command('sync_delivery_orders')
        logger.info("sync_delivery_orders command completed successfully")
    except Exception as e:
        logger.error(f"Error running sync_delivery_orders: {str(e)}")

def start():
    try:
        scheduler = BackgroundScheduler()
        scheduler.add_job(
            sync_delivery_orders_job, 
            'interval', 
            seconds=10,  # Changed from minutes=1 to seconds=10
            id='sync_delivery_orders_job',
            replace_existing=True
        )
        scheduler.start()
        logger.info("Scheduler started! sync_delivery_orders will run every 10 seconds.")
        print("Scheduler started! sync_delivery_orders will run every 10 seconds.", file=sys.stderr)
    except Exception as e:
        logger.error(f"Error starting scheduler: {str(e)}")
        print(f"Error starting scheduler: {str(e)}", file=sys.stderr)