# picking/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import PickingList, PickingItem
from .serializers import PickingListSerializer, PickingItemSerializer
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
            # Block any attempts to update warehouse_id - warehouse should be set by the module sending the request
            if 'warehouse_id' in request.data:
                return Response(
                    {"error": "Cannot update warehouse. The warehouse is determined by the module sending the delivery request."},
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
    Filtered to only show employees from HR department with specific position.
    """
    try:
        from django.db import connection
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT employee_id, first_name, last_name
                FROM human_resources.employees
                WHERE status = 'Active'
                AND position_id = 'REG-2504-faa8'
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
    Get a list of warehouses for display purposes.
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

@api_view(['POST'])
@permission_classes([IsAuthenticatedOrDevelopment])
def create_picking_items(request, pk):
    """
    Create picking items for a picking list based on its items_details
    """
    try:
        picking_list = PickingList.objects.get(pk=pk)
    except PickingList.DoesNotExist:
        return Response({"error": "Picking list not found"}, status=status.HTTP_404_NOT_FOUND)
    
    # Get items_details
    serializer = PickingListSerializer(picking_list)
    items_details = serializer.data.get('items_details', [])
    
    # Create picking items
    created_count = 0
    for item in items_details:
        # Skip if already exists
        if PickingItem.objects.filter(
            picking_list=picking_list,
            inventory_item_id=item.get('inventory_item_id')
        ).exists():
            continue
            
        PickingItem.objects.create(
            picking_list=picking_list,
            inventory_item_id=item.get('inventory_item_id', ''),
            item_name=item.get('item_name', ''),
            item_no=item.get('item_no', ''),
            quantity=item.get('quantity', 0),
            warehouse_id=item.get('warehouse_id', ''),
            warehouse_name=item.get('warehouse_name', '')
        )
        created_count += 1
    
    return Response({"created": created_count}, status=status.HTTP_201_CREATED)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def update_picking_item(request, pk):
    """
    Update a picking item status
    """
    try:
        picking_item = PickingItem.objects.get(pk=pk)
    except PickingItem.DoesNotExist:
        return Response({"error": "Picking item not found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingItemSerializer(picking_item, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        
        # Check if all items are picked and update list status if necessary
        picking_list = picking_item.picking_list
        items = PickingItem.objects.filter(picking_list=picking_list)
        all_picked = all(item.is_picked for item in items)
        
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def picking_items(request, pk):
    """
    Get all picking items for a picking list
    """
    try:
        picking_items = PickingItem.objects.filter(picking_list_id=pk)
    except PickingItem.DoesNotExist:
        return Response({"error": "No picking items found"}, status=status.HTTP_404_NOT_FOUND)
    
    serializer = PickingItemSerializer(picking_items, many=True)
    return Response(serializer.data)