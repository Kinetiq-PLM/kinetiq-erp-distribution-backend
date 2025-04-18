from django.apps import AppConfig

class ReworkConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'rework'

    def ready(self):
        import rework.signals  # Import signals when app is ready