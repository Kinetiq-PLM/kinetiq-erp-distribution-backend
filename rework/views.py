# rework/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .models import Rejection, ReworkOrder
from .serializers import DetailedReworkOrderSerializer, ReworkOrderSerializer
from django.db import transaction, connection
from distribution_backend.permissions import IsAuthenticatedOrDevelopment
from django.utils import timezone
import traceback

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def rework_list(request):
    """
    Get a list of all rework orders.
    """
    try:
        reworks = ReworkOrder.objects.all().order_by('-rework_date')
        serializer = DetailedReworkOrderSerializer(reworks, many=True)
        return Response(serializer.data)
    except Exception as e:
        print(f"Error in rework_list: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def rework_detail(request, pk):
    """
    Get detailed information about a specific rework order.
    """
    try:
        rework = ReworkOrder.objects.get(pk=pk)
        serializer = DetailedReworkOrderSerializer(rework)
        return Response(serializer.data)
    except ReworkOrder.DoesNotExist:
        return Response({"error": "Rework order not found"}, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        print(f"Error in rework_detail: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def assign_rework(request, pk):
    """
    Assign a rework order to an employee.
    """
    try:
        rework = ReworkOrder.objects.get(pk=pk)
    except ReworkOrder.DoesNotExist:
        return Response({"error": "Rework order not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        assigned_to = request.data.get('assigned_to')
        if not assigned_to:
            return Response({"error": "Employee ID is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        with transaction.atomic():
            # Update the rework order
            rework.assigned_to = assigned_to
            
            # Update status to 'In Progress' if it was 'Pending'
            if rework.rework_status == 'Pending':
                rework.rework_status = 'In Progress'
            
            rework.save()
            
            # Return the updated rework order
            serializer = DetailedReworkOrderSerializer(rework)
            return Response(serializer.data)
    except Exception as e:
        print(f"Error in assign_rework: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def update_rework_status(request, pk):
    """
    Update the status of a rework order.
    """
    try:
        rework = ReworkOrder.objects.get(pk=pk)
    except ReworkOrder.DoesNotExist:
        return Response({"error": "Rework order not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        new_status = request.data.get('rework_status')
        if not new_status:
            return Response({"error": "New status is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        # Validate the status transition
        if new_status == 'Completed' and rework.rework_status == 'Pending':
            return Response(
                {"error": "Cannot change status directly from 'Pending' to 'Completed'. It must first be 'In Progress'"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        with transaction.atomic():
            # Update the rework order status
            rework.rework_status = new_status
            rework.save()
            
            # Return the updated rework order
            serializer = DetailedReworkOrderSerializer(rework)
            return Response(serializer.data)
    except Exception as e:
        print(f"Error in update_rework_status: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['PUT'])
@permission_classes([IsAuthenticatedOrDevelopment])
def complete_rework(request, pk):
    """
    Mark a rework order as completed.
    """
    try:
        rework = ReworkOrder.objects.get(pk=pk)
    except ReworkOrder.DoesNotExist:
        return Response({"error": "Rework order not found"}, status=status.HTTP_404_NOT_FOUND)
    
    try:
        # Validate the status transition
        if rework.rework_status == 'Pending':
            return Response(
                {"error": "Cannot complete a rework that is still 'Pending'. It must first be 'In Progress'"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        with transaction.atomic():
            # Update the rework order
            rework.rework_status = 'Completed'
            rework.save()
            
            # If this rework is for a failed shipment, update its resolution status
            if rework.failed_shipment_id:
                with connection.cursor() as cursor:
                    cursor.execute("""
                        UPDATE distribution.failed_shipment
                        SET resolution_status = 'Resolved'
                        WHERE failed_shipment_id = %s
                    """, [rework.failed_shipment_id])
                    if cursor.rowcount > 0:
                        print(f"Updated failed shipment {rework.failed_shipment_id} status to 'Resolved'")
            
            # Return the updated rework order
            serializer = DetailedReworkOrderSerializer(rework)
            return Response(serializer.data)
    except Exception as e:
        print(f"Error in complete_rework: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticatedOrDevelopment])
def employee_list(request):
    """
    Get a list of employees for assignment.
    """
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    employee_id, 
                    first_name || ' ' || last_name AS full_name,
                    job_title,
                    dept_id
                FROM human_resources.employees
                WHERE status = 'Active'
                ORDER BY full_name
            """)
            
            columns = [col[0] for col in cursor.description]
            employees = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            return Response(employees)
    except Exception as e:
        print(f"Error in employee_list: {str(e)}")
        traceback.print_exc()
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)