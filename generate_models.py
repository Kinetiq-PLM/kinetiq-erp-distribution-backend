import os
import sys
import django
from django.conf import settings
from django.core.management import call_command
from django.db import connections

# Add your project to the path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'distribution_backend.settings')
django.setup()

# Schemas to process and their respective output files
schemas = {
    'human_resources': 'hr_models.py',
    'services': 'services_models.py',
    'inventory': 'inventory_models.py',
    'operations': 'operations_models.py',
    'sales': 'sales_models.py',
    'admin': 'admin_models.py'
}

for schema, output_file in schemas.items():
    print(f"Generating models for {schema} schema...")
    
    # Close any existing connections before changing settings
    connections.close_all()
    
    # Modify the database settings to include the schema in search path
    settings.DATABASES['default']['OPTIONS']['options'] = f'-c search_path={schema},public'
    
    # Force a new connection with the updated settings
    connections['default'].connect()
    
    # Ensure the search path is set correctly for this connection
    with connections['default'].cursor() as cursor:
        cursor.execute(f'SET search_path TO {schema},public')
    
    # Run inspectdb and save output to the desired file
    with open(os.path.join('distribution_backend', output_file), 'w') as f:
        call_command('inspectdb', stdout=f)
    
    print(f"Generated {output_file}")

print("All models generated successfully!")