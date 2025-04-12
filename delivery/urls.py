from django.urls import path
from . import views

urlpatterns = [
    path('delivery-orders/', views.delivery_order_list, name='delivery_order_list'),
    # TEMPORARY: URL for testing approval functionality - comment out to disable QA PURPOSES TANGINA
    path('approve-order/', views.temp_approve_delivery_order, name='temp_approve_delivery_order'),
]