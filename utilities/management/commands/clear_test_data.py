from django.core.management.base import BaseCommand, CommandError
from django.db import transaction
from django.db.models import ProtectedError
import sys

# Import all the necessary models
from shipment.models import (
    OperationalCost, GoodsIssue, BillingReceipt, ShipmentDetails, 
    FailedShipment, DeliveryReceipt, ShippingCost, Carrier
)
from packing.models import PackingList, PackingCost
from picking.models import PickingList
from rework.models import ReworkOrder, Rejection
from delivery.models import DeliveryOrder, LogisticsApprovalRequest


class Command(BaseCommand):
    help = 'Deletes test data in the correct order to handle foreign key constraints'

    def add_arguments(self, parser):
        parser.add_argument(
            '--force',
            action='store_true',
            help='Skip confirmation prompt',
        )
        # Remove the -v shorthand since Django uses it for verbosity
        parser.add_argument(
            '--verbose',
            action='store_true',
            help='Show detailed deletion information',
        )

    def handle(self, *args, **options):
        self.verbose = options['verbose']
        force = options['force']
        
        # Confirmation prompt unless --force is used
        if not force:
            confirm = input('\nWARNING: This will delete ALL data from the specified models.\nAre you sure? (y/N): ')
            if confirm.lower() != 'y':
                self.stdout.write(self.style.ERROR('Operation cancelled.'))
                return

        # Define the deletion order with proper model references
        deletion_order = [
            (OperationalCost, "Operational Costs"),
            (GoodsIssue, "Goods Issues"),
            (BillingReceipt, "Billing Receipts"),
            (ReworkOrder, "Rework Orders"),
            (Rejection, "Rejections"),
            (DeliveryReceipt, "Delivery Receipts"),
            (FailedShipment, "Failed Shipments"),
            (ShipmentDetails, "Shipment Details"),
            (ShippingCost, "Shipping Costs"),
            (PackingList, "Packing Lists"),
            (PackingCost, "Packing Costs"),
            (PickingList, "Picking Lists"),
            # (LogisticsApprovalRequest, "Logistics Approval Requests"),
            # (DeliveryOrder, "Delivery Orders"),
            # (Carrier, "Carriers")
        ]

        try:
            # Tracking total deletions
            total_deleted = 0
            
            # Start a transaction to ensure atomicity
            with transaction.atomic():
                self.stdout.write("Starting deletion process in the correct order...")
                
                # Process each model in order
                for model, model_name in deletion_order:
                    count, details = model.objects.all().delete()
                    total_deleted += count
                    
                    if count > 0 or self.verbose:
                        self.stdout.write(self.style.SUCCESS(f"  ✓ Deleted {count} {model_name}"))
                        
                        # If verbose, show detailed deletion information
                        if self.verbose and details:
                            for model_detail, del_count in details.items():
                                if del_count > 0:
                                    self.stdout.write(f"    - {del_count} from {model_detail}")
            
            # Final success message
            self.stdout.write(self.style.SUCCESS(f"\nSuccessfully deleted {total_deleted} total records!"))
        
        except ProtectedError as e:
            self.stdout.write(self.style.ERROR(f"\nFailed to delete objects due to protected foreign key: {str(e)}"))
            # Show which models still have data
            self.check_remaining_data(deletion_order)
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"\nAn error occurred: {str(e)}"))
    
    def check_remaining_data(self, models):
        """Check and report which models still have data after a failed deletion attempt"""
        self.stdout.write("\nRemaining data in models:")
        for model, model_name in models:
            count = model.objects.count()
            if count > 0:
                self.stdout.write(f"  • {model_name}: {count} records")