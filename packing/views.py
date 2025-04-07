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
    
    try:
        with transaction.atomic():
            # Check if trying to update packing costs
            if 'material_cost' in request.data or 'labor_cost' in request.data:
                # Get the packing cost record
                try:
                    packing_cost = PackingCost.objects.get(pk=packing_list.packing_cost_id)
                    
                    # Update material_cost if provided
                    if 'material_cost' in request.data:
                        packing_cost.material_cost = Decimal(request.data['material_cost'])
                    
                    # Update labor_cost if provided
                    if 'labor_cost' in request.data:
                        packing_cost.labor_cost = Decimal(request.data['labor_cost'])
                    
                    # The signal will calculate total_packing_cost
                    packing_cost.save()
                    
                    # Remove these from request.data to avoid confusion in the next step
                    if 'material_cost' in request.data:
                        del request.data['material_cost']
                    if 'labor_cost' in request.data:
                        del request.data['labor_cost']
                    
                except PackingCost.DoesNotExist:
                    return Response(
                        {"error": "Associated packing cost record not found"},
                        status=status.HTTP_404_NOT_FOUND
                    )
            
            # Handle status transition validation
            current_status = packing_list.packing_status
            new_status = request.data.get('packing_status', current_status)
            
            # Validate status transition
            if (current_status == 'Pending' and new_status == 'Shipped'):
                return Response(
                    {"error": "Packing list status cannot change directly from 'Pending' to 'Shipped'. It must first be set to 'Packed'."},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Update packing_date if status is changing to 'Packed'
            if new_status == 'Packed' and current_status != 'Packed':
                request.data['packing_date'] = timezone.now().date().isoformat()
            
            serializer = PackingListSerializer(packing_list, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                
                # Get the updated record with all related information
                updated = PackingList.objects.get(pk=pk)
                response_serializer = PackingListSerializer(updated)
                return Response(response_serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except ValidationError as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

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