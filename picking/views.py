# picking/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import PickingList
from .serializers import PickingListSerializer
from django.db import transaction, connection
from django.utils import timezone
from django.core.exceptions import ValidationError
from distribution_backend.permissions import IsAuthenticatedOrDevelopment

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_view(request):
    """
    Get all picking lists.
    """
    picking_lists = PickingList.objects.all().order_by('-picking_list_id')
    serializer = PickingListSerializer(picking_lists, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_detail(request, pk):
    """
    Get details of a specific picking list.
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingListSerializer(picking_list)
    return Response(serializer.data)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_list_update(request, pk):
    """
    Update a picking list.
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        with transaction.atomic():
            # Check if this is an internal order (content or stock transfer)
            is_internal = False
            
            if picking_list.approval_request_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        SELECT content_id, stock_transfer_id
                        FROM distribution.delivery_order
                        WHERE del_order_id = (
                            SELECT del_order_id
                            FROM distribution.logistics_approval_request
                            WHERE approval_request_id = %s
                        )
                    """, [picking_list.approval_request_id])
                    result = cursor.fetchone()
                    if result and (result[0] or result[1]):
                        is_internal = True
            
            # If trying to update warehouse_id on an internal order, block it
            if is_internal and 'warehouse_id' in request.data:
                return Response(
                    {"error": "Cannot update warehouse for internal orders. The warehouse is automatically determined."},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Handle status transition validation
            current_status = picking_list.picked_status
            new_status = request.data.get('picked_status', current_status)
            
            # Validate status transition
            if (current_status == 'Not Started' and new_status == 'Completed'):
                return Response(
                    {"error": "Picking list status cannot change directly from 'Not Started' to 'Completed'. It must first be set to 'In Progress'."},
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            # Update picked_date if status is changing to 'Completed'
            if new_status == 'Completed' and current_status != 'Completed':
                request.data['picked_date'] = timezone.now().date().isoformat()
            
            serializer = PickingListSerializer(picking_list, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except ValidationError as e:
        return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def employee_list(request):
    """
    Get a list of employees for the picker assignment dropdown.
    """
    try:
        from django.db import connection
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
def warehouse_list(request):
    """
    Get a list of warehouses for the picking list.
    """
    try:
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT warehouse_id, warehouse_location
                FROM admin.warehouse
                ORDER BY warehouse_location
            """)
            columns = [col[0] for col in cursor.description]
            warehouses = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            # Format the response to match expected format
            formatted_warehouses = []
            for warehouse in warehouses:
                formatted_warehouses.append({
                    'id': warehouse['warehouse_id'],
                    'name': warehouse['warehouse_location']
                })
                
            return Response(formatted_warehouses)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)