from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.db import connection
from shipment.models import OperationalCost
import traceback
from decimal import Decimal

@receiver(pre_save, sender=OperationalCost)
def update_total_operational_cost(sender, instance, **kwargs):
    """
    Automatically recalculate total_operational_cost when any component changes,
    including additional_cost.
    """
    try:
        shipping_cost_total = Decimal('0.00')
        packing_cost_total = Decimal('0.00')
        additional = instance.additional_cost or Decimal('0.00')
        
        # Get shipping cost if it exists
        if instance.shipping_cost_id:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT total_shipping_cost
                    FROM distribution.shipping_cost
                    WHERE shipping_cost_id = %s
                """, [instance.shipping_cost_id])
                result = cursor.fetchone()
                if result and result[0]:
                    shipping_cost_total = result[0]
        
        # Get packing cost if it exists
        if instance.packing_cost_id:
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT total_packing_cost
                    FROM distribution.packing_cost
                    WHERE packing_cost_id = %s
                """, [instance.packing_cost_id])
                result = cursor.fetchone()
                if result and result[0]:
                    packing_cost_total = result[0]
        
        # Calculate total
        instance.total_operational_cost = shipping_cost_total + packing_cost_total + additional
        print(f"Recalculated operational cost: {instance.total_operational_cost} = {shipping_cost_total} + {packing_cost_total} + {additional}")
        
    except Exception as e:
        print(f"Error updating total operational cost: {str(e)}")
        traceback.print_exc()