from django.urls import path
from . import views

urlpatterns = [
    path('delivery-orders/', views.delivery_order_list, name='delivery_order_list'),
]