ive recently saw the full updated database scripts, im sorry to say that this code will not work with the updated scripts, because when i was developing i wasn't not aware of the changes in the tables that we are fetching data from. This code can still simulate from the old database, i will upload the db scripts that is applicable for this while i try to adjust the fetching to be updated with the finalized database scripts.


That being said here are some notes:

"python manage.py sync_delivery_orders" is that code to fetch the orders from the 4 modules that we are getting the 4 types of delivery from namely: sales, services, operations, inventory

-with the current dummy data that i saw i dont think you can simulate it, so whoever will test this out needs to insert in pgadmin 4 connected dummy datas

-operations module will update the approval_status in logistsics_approval_request table, for the meanwhile you can manually click the logistis_approval_request id in the delivery_orders record to approved it




