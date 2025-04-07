# packing/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('packing-lists/', views.packing_list_view, name='packing_list_view'),
    path('packing-lists/<str:pk>/', views.packing_list_detail, name='packing_list_detail'),
    path('packing-lists/<str:pk>/update/', views.packing_list_update, name='packing_list_update'),
    path('employees/', views.employee_list, name='employee_list'),
    path('packing-types/', views.packing_types, name='packing_types'),
]