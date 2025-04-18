# Generated by Django 5.1.6 on 2025-03-25 12:29

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='PackingCost',
            fields=[
                ('packing_cost_id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('material_cost', models.DecimalField(decimal_places=2, max_digits=10)),
                ('labor_cost', models.DecimalField(decimal_places=2, max_digits=10)),
                ('total_packing_cost', models.DecimalField(decimal_places=2, max_digits=10)),
            ],
            options={
                'db_table': 'packing_cost',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='PackingList',
            fields=[
                ('packing_list_id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('packed_by', models.CharField(blank=True, max_length=255, null=True)),
                ('packing_status', models.TextField(blank=True, null=True)),
                ('packing_type', models.TextField(blank=True, null=True)),
                ('total_items_packed', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'packing_list',
                'managed': False,
            },
        ),
    ]
