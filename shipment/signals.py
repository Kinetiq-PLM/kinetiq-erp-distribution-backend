# Main signals file - imports all other signal modules to ensure they're registered

from shipment import signals_shipment
from shipment import signals_delivery_receipt
from shipment import signals_operational_cost

# This file serves as the entry point to ensure all signal handlers are loaded