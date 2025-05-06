# picking/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('picking-lists/', views.picking_list_view, name='picking_list_view'),
    path('picking-lists/<str:pk>/', views.picking_list_detail, name='picking_list_detail'),
    path('picking-lists/<str:pk>/update/', views.picking_list_update, name='picking_list_update'),
    path('employees/', views.employee_list, name='employee_list'),
    path('warehouses/', views.warehouse_list, name='warehouse_list'),
    path('picking-lists/<str:pk>/items/', views.picking_items, name='picking_items'),
    path('picking-lists/<str:pk>/create-items/', views.create_picking_items, name='create_picking_items'),
    path('picking-items/<int:pk>/update/', views.update_picking_item, name='update_picking_item'),
    # New endpoints for partial delivery management
    path('delivery-notes/order/<str:order_id>/', views.delivery_notes_info, name='delivery_notes_info'),
    path('delivery-notes/order/<str:order_id>/force-next/', views.force_next_delivery, name='force_next_delivery'),
    path('shipments/<str:shipment_id>/create-next-batch/', views.create_next_batch_picking_list, name='create-next-batch-picking'),
]