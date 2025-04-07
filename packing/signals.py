from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.db import transaction, connection
from django.core.exceptions import ValidationError
from packing.models import PackingList, PackingCost
from shipment.models import ShippingCost
import traceback
from datetime import date, timedelta  # Added timedelta import
from decimal import Decimal

@receiver(pre_save, sender=PackingCost)
def calculate_total_packing_cost(sender, instance, **kwargs):
    """
    Automatically calculate total_packing_cost before saving
    """
    instance.total_packing_cost = instance.material_cost + instance.labor_cost

# Add this new signal to validate status transitions and set packing_date
@receiver(pre_save, sender=PackingList)
def validate_packing_status_transition_and_set_date(sender, instance, **kwargs):
    """
    Validates packing status transitions and sets packing_date when status changes to 'Packed'
    """
    try:
        # Only run this for existing objects (not on creation)
        if instance.pk:
            # Get the current state from the database before changes
            with connection.cursor() as cursor:
                cursor.execute("""
                    SELECT packing_status
                    FROM distribution.packing_list
                    WHERE packing_list_id = %s
                """, [instance.packing_list_id])
                result = cursor.fetchone()
                
                if result:
                    current_status = result[0]
                    new_status = instance.packing_status
                    
                    # If status is changing
                    if new_status != current_status:
                        # Validate transitions
                        if current_status == 'Pending' and new_status == 'Packed':
                            # Set packing_date when changing to 'Packed'
                            instance.packing_date = date.today()
                            print(f"Setting packing_date to {instance.packing_date} for {instance.packing_list_id}")
                        elif current_status == 'Packed' and new_status == 'Shipped':
                            # This is valid
                            pass
                        elif current_status == 'Pending' and new_status == 'Shipped':
                            # Can't skip from Pending to Shipped
                            raise ValidationError("Cannot change status directly from 'Pending' to 'Shipped'. Must first be 'Packed'.")
    except ValidationError:
        raise
    except Exception as e:
        print(f"Error in validate_packing_status_transition: {str(e)}")
        traceback.print_exc()

# Add this new signal to update operational cost when packing cost changes
@receiver(post_save, sender=PackingCost)
def update_operational_cost_from_packing(sender, instance, **kwargs):
    """
    When packing cost is updated, recalculate the associated operational cost
    """
    try:
        with transaction.atomic():
            with connection.cursor() as cursor:
                # Find operational cost record(s) linked to this packing cost
                cursor.execute("""
                    SELECT operational_cost_id, shipping_cost_id, additional_cost
                    FROM distribution.operational_cost
                    WHERE packing_cost_id = %s
                """, [instance.packing_cost_id])
                results = cursor.fetchall()
                
                for result in results:
                    operational_cost_id = result[0]
                    shipping_cost_id = result[1]
                    additional_cost = result[2] or Decimal('0.00')
                    
                    # Get shipping cost if it exists
                    shipping_cost = Decimal('0.00')
                    if shipping_cost_id:
                        cursor.execute("""
                            SELECT total_shipping_cost
                            FROM distribution.shipping_cost
                            WHERE shipping_cost_id = %s
                        """, [shipping_cost_id])
                        shipping_result = cursor.fetchone()
                        shipping_cost = shipping_result[0] if shipping_result and shipping_result[0] else Decimal('0.00')
                    
                    # Calculate new total operational cost
                    total_operational_cost = instance.total_packing_cost + shipping_cost + additional_cost
                    
                    # Update the operational_cost record
                    cursor.execute("""
                        UPDATE distribution.operational_cost
                        SET total_operational_cost = %s
                        WHERE operational_cost_id = %s
                    """, [total_operational_cost, operational_cost_id])
                    
                    print(f"Updated operational_cost_id {operational_cost_id} from packing cost change: total_operational_cost = {total_operational_cost}")
    except Exception as e:
        print(f"Error updating operational_cost from packing cost: {str(e)}")
        traceback.print_exc()

# Add this new signal to calculate shipping cost
@receiver(pre_save, sender=ShippingCost)
def calculate_total_shipping_cost(sender, instance, **kwargs):
    """
    Automatically calculate total_shipping_cost before saving
    """
    # Only recalculate if weight and distance are set
    if instance.weight_kg is not None and instance.distance_km is not None:
        instance.total_shipping_cost = (instance.weight_kg * instance.cost_per_kg) + (instance.distance_km * instance.cost_per_km)

# Add this new signal to update operational cost when shipping cost changes
@receiver(post_save, sender=ShippingCost)
def update_operational_cost(sender, instance, **kwargs):
    """
    When shipping cost is updated, recalculate the associated operational cost
    """
    try:
        with transaction.atomic():
            with connection.cursor() as cursor:
                # First check if an operational_cost record exists for this shipping_cost
                cursor.execute("""
                    SELECT operational_cost_id, packing_cost_id, additional_cost
                    FROM distribution.operational_cost
                    WHERE shipping_cost_id = %s
                """, [instance.shipping_cost_id])
                result = cursor.fetchone()
                
                if result:
                    operational_cost_id = result[0]
                    packing_cost_id = result[1]
                    additional_cost = result[2] or Decimal('0.00')
                    
                    # Get the total_packing_cost
                    cursor.execute("""
                        SELECT total_packing_cost
                        FROM distribution.packing_cost
                        WHERE packing_cost_id = %s
                    """, [packing_cost_id])
                    packing_result = cursor.fetchone()
                    total_packing_cost = packing_result[0] if packing_result else Decimal('0.00')
                    
                    # Calculate new total operational cost
                    total_operational_cost = total_packing_cost + instance.total_shipping_cost + additional_cost
                    
                    # Update the operational_cost record
                    cursor.execute("""
                        UPDATE distribution.operational_cost
                        SET total_operational_cost = %s
                        WHERE operational_cost_id = %s
                    """, [total_operational_cost, operational_cost_id])
                    
                    print(f"Updated operational_cost_id {operational_cost_id}: total_operational_cost = {total_operational_cost}")
                else:
                    print(f"No operational_cost found for shipping_cost_id {instance.shipping_cost_id}")
    
    except Exception as e:
        print(f"Error updating operational_cost: {str(e)}")
        traceback.print_exc()

@receiver(post_save, sender=PackingList)
def create_shipment_data(sender, instance, **kwargs):
    """
    When a PackingList is marked as 'Packed', 
    automatically create associated ShippingCost, OperationalCost, and ShipmentDetails
    """
    if instance.packing_status == 'Packed':
        try:
            with transaction.atomic():
                with connection.cursor() as cursor:
                    # First, get the packing_cost_id and total_packing_cost
                    packing_cost_id = instance.packing_cost_id
                    print(f"Using packing_cost_id: {packing_cost_id}")
                    
                    cursor.execute("""
                        SELECT total_packing_cost
                        FROM distribution.packing_cost
                        WHERE packing_cost_id = %s
                    """, [packing_cost_id])
                    result = cursor.fetchone()
                    total_packing_cost = result[0] if result else Decimal('0.00')
                    print(f"Retrieved total_packing_cost: {total_packing_cost}")
                    
                    # Set default values in PHP (Philippine Peso)
                    default_cost_per_kg = Decimal('150.00')  # ₱150 per kg
                    default_cost_per_km = Decimal('20.00')   # ₱20 per km
                    
                    # Start with zero weight and distance - will be set via admin
                    initial_weight_kg = Decimal('0.00')  
                    initial_distance_km = Decimal('0.00')
                    
                    # Initial shipping cost will be zero
                    initial_shipping_cost = Decimal('0.00')
                    
                    # Generate a unique shipping_cost_id
                    try:
                        cursor.execute("""
                            INSERT INTO distribution.shipping_cost 
                            (packing_list_id, cost_per_kg, cost_per_km, weight_kg, distance_km, total_shipping_cost)
                            VALUES (%s, %s, %s, %s, %s, %s)
                            RETURNING shipping_cost_id
                        """, [
                            instance.packing_list_id, 
                            default_cost_per_kg,
                            default_cost_per_km,
                            initial_weight_kg,
                            initial_distance_km,
                            initial_shipping_cost
                        ])
                        result = cursor.fetchone()
                        shipping_cost_id = result[0] if result else None
                        print(f"Created shipping_cost_id: {shipping_cost_id}")
                        
                        if shipping_cost_id is None:
                            raise Exception("Failed to create shipping_cost record")
                            
                    except Exception as e:
                        print(f"Error creating shipping_cost: {str(e)}")
                        raise
                    
                    # Default additional cost - also as Decimal
                    additional_cost = Decimal('0.00')
                    
                    # Create the operational_cost record
                    total_operational_cost = total_packing_cost + initial_shipping_cost + additional_cost
                    try:
                        cursor.execute("""
                            INSERT INTO distribution.operational_cost
                            (additional_cost, total_operational_cost, shipping_cost_id, packing_cost_id)
                            VALUES (%s, %s, %s, %s)
                            RETURNING operational_cost_id
                        """, [
                            additional_cost,
                            total_operational_cost,
                            shipping_cost_id,
                            packing_cost_id
                        ])
                        result = cursor.fetchone()
                        operational_cost_id = result[0] if result else None
                        print(f"Created operational_cost_id: {operational_cost_id}")
                        
                        if operational_cost_id is None:
                            raise Exception("Failed to create operational_cost record")
                            
                    except Exception as e:
                        print(f"Error creating operational_cost: {str(e)}")
                        raise

                    # Create ShipmentDetails using the generated shipping_cost_id
                    try:
                        tracking_number = 'TRK' + instance.packing_list_id[-8:] if len(instance.packing_list_id) >= 8 else 'TRK-' + str(date.today().strftime('%y%m%d'))
                        
                        # Add estimated_arrival_date calculation at creation time
                        shipment_date = date.today()  # Today is when it's packed
                        estimated_arrival_date = shipment_date + timedelta(days=2)  # Estimate 2 days for delivery
                        
                        cursor.execute("""
                            INSERT INTO distribution.shipment_details 
                            (shipment_date, shipment_status, tracking_number, estimated_arrival_date, packing_list_id, shipping_cost_id)
                            VALUES (%s, %s, %s, %s, %s, %s)
                            RETURNING shipment_id
                        """, [
                            shipment_date,  # Set shipment_date at creation (instead of NULL)
                            'Pending',  # Default shipment_status 
                            tracking_number,
                            estimated_arrival_date,  # Set estimated date at creation
                            instance.packing_list_id,
                            shipping_cost_id
                        ])
                        result = cursor.fetchone()
                        shipment_id = result[0] if result else None
                        print(f"Created shipment_id: {shipment_id} with estimated delivery on {estimated_arrival_date}")
                        
                        if shipment_id is None:
                            raise Exception("Failed to create shipment_details record")
                            
                    except Exception as e:
                        print(f"Error creating shipment_details: {str(e)}")
                        raise
                
                print(f"Successfully created all records for PackingList {instance.packing_list_id}")
                
        except Exception as e:
            print(f"CRITICAL ERROR in create_shipment_data: {str(e)}")
            traceback.print_exc()