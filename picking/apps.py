from django.apps import AppConfig

class PickingConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'picking'

    def ready(self):
        import picking.signals