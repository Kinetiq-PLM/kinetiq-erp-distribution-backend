# packing/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import PackingList, PackingCost
from .serializers import PackingListSerializer, PackingCostSerializer
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from decimal import Decimal
from distribution_backend.permissions import IsAuthenticatedOrDevelopment

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_view(request):
    """
    Get all packing lists.
    """
    packing_lists = PackingList.objects.all().order_by('-packing_list_id')
    serializer = PackingListSerializer(packing_lists, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_detail(request, pk):
    """
    Get details of a specific packing list.
    """
    try:
        packing_list = PackingList.objects.get(pk=pk)
    except PackingList.DoesNotExist:
        return Response({"error": "Packing list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PackingListSerializer(packing_list)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_list_update(request, pk):
    """
    Update a packing list.
    """
    try:
        packing_list = PackingList.objects.get(pk=pk)
    except PackingList.DoesNotExist:
        return Response({"error": "Packing list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Extract packed_items_data but keep it separate from serializer validation
    packed_items_data = None
    if 'packed_items_data' in request.data:
        packed_items_data = request.data.pop('packed_items_data')
    
    serializer = PackingListSerializer(packing_list, data=request.data, partial=True)
    if serializer.is_valid():
        # If status changed to Packed, set packing_date
        if request.data.get('packing_status') == 'Packed':
            serializer.validated_data['packing_date'] = timezone.now().date()
        
        # Ensure total_items_packed is saved correctly by reading it from the request
        if 'total_items_packed' in request.data:
            # Make sure it's properly typed as integer
            serializer.validated_data['total_items_packed'] = int(request.data['total_items_packed'])
        
        serializer.save()
        return Response(serializer.data)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def employee_list(request):
    """
    Get a list of employees for the packer assignment dropdown.
    """
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT employee_id, first_name, last_name
                FROM human_resources.employees
                WHERE status = 'Active'
                ORDER BY last_name, first_name
            """)
            columns = [col[0] for col in cursor.description]
            employees = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            for employee in employees:
                employee['full_name'] = f"{employee['first_name']} {employee['last_name']}"
                
            return Response(employees)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def packing_types(request):
    """
    Get a list of valid packing types.
    """
    try:
        # These are the valid packing types from your enum
        types = [
            {"id": "Box", "name": "Box"},
            {"id": "Bubble Wrap", "name": "Bubble Wrap"},
            {"id": "Crate", "name": "Crate"}
        ]
        return Response(types)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)