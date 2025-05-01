from django.contrib import admin
from django.urls import path, include
from django.views.generic import RedirectView

urlpatterns = [
    path('admin/', admin.site.urls),
    # Add redirect to external API Gateway
    path('admin/', 
         RedirectView.as_view(url='http://127.0.0.1:8000'),
         name='admin'),
    # Include the delivery app URLs under the /api/ path
    path('api/', include('delivery.urls')),
    path('api/', include('picking.urls')),
    path('api/', include('packing.urls')),
    path('api/', include('shipment.urls')),
    path('api/', include('rework.urls')),
    # path('api/', include('login/')),
    
]