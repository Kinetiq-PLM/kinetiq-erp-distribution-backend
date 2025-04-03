from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import DeliveryOrder
from .serializers import DeliveryOrderSerializer

@api_view(['GET'])
def delivery_order_list(request):
    delivery_orders = DeliveryOrder.objects.all()
    serializer = DeliveryOrderSerializer(delivery_orders, many=True)
    return Response(serializer.data)