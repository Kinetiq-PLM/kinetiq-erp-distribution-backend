from django.apps import AppConfig


class DistributionBackendConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'distribution_backend'

    def ready(self):
        # Check if this is the main process
        import os
        
        # Only start scheduler in main process (not in runserver reloader)
        if os.environ.get('RUN_MAIN', None) == 'true':
            # Import the scheduler code when Django is ready
            from . import scheduler
            scheduler.start()