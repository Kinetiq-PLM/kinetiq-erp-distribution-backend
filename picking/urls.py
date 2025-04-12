# picking/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('picking-lists/', views.picking_list_view, name='picking_list_view'),
    path('picking-lists/<str:pk>/', views.picking_list_detail, name='picking_list_detail'),
    path('picking-lists/<str:pk>/update/', views.picking_list_update, name='picking_list_update'),
    path('employees/', views.employee_list, name='employee_list'),
    path('warehouses/', views.warehouse_list, name='warehouse_list'),
]