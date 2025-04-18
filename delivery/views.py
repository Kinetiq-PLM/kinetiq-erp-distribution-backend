from django.http import JsonResponse
from .models import DeliveryOrder, LogisticsApprovalRequest
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
import json
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

def delivery_order_list(request):
    # Get all delivery orders
    delivery_orders = DeliveryOrder.objects.all()
    
    # Convert QuerySet to list of dictionaries for JSON serialization
    orders_list = []
    for order in delivery_orders:
        orders_list.append({
            'del_order_id': order.del_order_id,
            'order_status': order.order_status,
            'content_id': order.content_id,
            'is_project_based': order.is_project_based == 'Yes',  # Convert to boolean if stored as text
            'is_partial_delivery': order.is_partial_delivery == 'Yes',  # Convert to boolean if stored as text
            'service_order_id': order.service_order_id,
            'stock_transfer_id': order.stock_transfer_id,
            'sales_order_id': order.sales_order_id,
            'del_type': order.del_type
        })
    
    # Return JSON response
    return JsonResponse(orders_list, safe=False)

# TEMPORARY: API endpoint for testing approval functionality
# Comment out this entire function to disable the temporary approval feature QA PURPOSES TANGINA
@api_view(['POST'])
@csrf_exempt
def temp_approve_delivery_order(request):
    try:
        # Parse request data
        data = request.data
        del_order_id = data.get('del_order_id')
        
        if not del_order_id:
            return Response({"error": "Delivery order ID is required"}, status=status.HTTP_400_BAD_REQUEST)
            
        # Find the delivery order
        try:
            delivery_order = DeliveryOrder.objects.get(del_order_id=del_order_id)
        except DeliveryOrder.DoesNotExist:
            return Response({"error": f"Delivery order with ID {del_order_id} not found"}, status=status.HTTP_404_NOT_FOUND)
            
        # Check if there's already an approval request
        approval_request = None
        if hasattr(delivery_order, 'approval_request') and delivery_order.approval_request:
            approval_request = delivery_order.approval_request
        else:
            # Create a new approval request
            approval_request = LogisticsApprovalRequest.objects.create(
                approval_request_id=f"TEMP-{del_order_id}-{timezone.now().strftime('%Y%m%d%H%M%S')}",
                request_date=timezone.now().date(),
                approval_status='Pending',
                del_order=delivery_order
            )
            
        # Update approval request to approved status
        approval_request.approval_status = 'Approved'
        approval_request.approval_date = timezone.now().date()
        # approval_request.approved_by = 'QA Tester'
        approval_request.save()
        
        # The signal handler in signals.py will handle the rest of the logic
        
        return Response({"success": True, "message": f"Delivery order {del_order_id} has been approved for testing"})
        
    except Exception as e:
        import traceback
        print(f"Error in temp_approve_delivery_order: {str(e)}")
        print(traceback.format_exc())  # Print full traceback for debugging
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)