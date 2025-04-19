# shipment/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('shipments/', views.shipment_list, name='shipment_list'),
    path('shipments/<str:pk>/', views.shipment_detail, name='shipment_detail'),
    path('shipments/<str:pk>/update/', views.shipment_update, name='shipment_update'),
    path('shipments/<str:pk>/ship/', views.shipment_ship, name='shipment_ship'),
    path('shipments/<str:pk>/fail/', views.shipment_fail, name='shipment_fail'),
    path('delivery-receipts/<str:pk>/', views.delivery_receipt_detail, name='delivery_receipt_detail'),
    path('delivery-receipts/<str:pk>/update/', views.delivery_receipt_update, name='delivery_receipt_update'),
    path('carriers/', views.carrier_list_create, name='carrier_list_create'),
    path('carriers/<str:pk>/', views.carrier_detail, name='carrier_detail'),
    path('failed-shipments/', views.failed_shipment_list, name='failed_shipment_list'),
    path('customers/<str:pk>/', views.customer_detail, name='customer_detail'),
    path('failed-shipments/', views.failed_shipments_list, name='failed_shipments_list'),
]