# rework/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('reworks/', views.rework_list, name='rework_list'),
    path('reworks/<str:pk>/', views.rework_detail, name='rework_detail'),
    path('reworks/<str:pk>/assign/', views.assign_rework, name='assign_rework'),
    path('reworks/<str:pk>/update-status/', views.update_rework_status, name='update_rework_status'),
    path('reworks/<str:pk>/complete/', views.complete_rework, name='complete_rework'),
    path('employees/', views.employee_list, name='employee_list'),
]