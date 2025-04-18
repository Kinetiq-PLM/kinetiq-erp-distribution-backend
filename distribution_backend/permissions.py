# distribution_backend/permissions.py

from rest_framework import permissions
from django.conf import settings

class IsAuthenticatedOrDevelopment(permissions.BasePermission):
    """
    Custom permission class that allows access in development mode
    but requires authentication in production.
    """
    
    def has_permission(self, request, view):
        # Allow all requests in development mode
        if settings.DEBUG:
            return True
        # Require authentication in production
        return request.user and request.user.is_authenticated