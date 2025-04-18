from django.apps import AppConfig

class PackingConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'packing'

    def ready(self):
        import packing.signals