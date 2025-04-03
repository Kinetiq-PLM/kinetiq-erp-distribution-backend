from django.apps import AppConfig

class DeliveryConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'delivery'

    def ready(self):
        import delivery.signals
        # Initialize real-time triggers and listener
        from delivery.signals import setup_triggers_on_ready
        setup_triggers_on_ready()