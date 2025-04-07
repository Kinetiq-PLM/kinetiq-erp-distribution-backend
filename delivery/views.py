from django.http import JsonResponse
from .models import DeliveryOrder

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