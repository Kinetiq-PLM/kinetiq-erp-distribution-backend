# Generated by Django 5.1.6 on 2025-03-25 12:29

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Rejection',
            fields=[
                ('rejection_id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('rejection_status', models.TextField(blank=True, null=True)),
                ('rejection_reason', models.TextField()),
                ('rejection_date', models.DateField(blank=True, null=True)),
            ],
            options={
                'db_table': 'rejection',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='ReworkOrder',
            fields=[
                ('rework_id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('assigned_to', models.CharField(blank=True, max_length=255, null=True)),
                ('rework_status', models.TextField(blank=True, null=True)),
                ('rework_date', models.DateField(blank=True, null=True)),
                ('expected_completion', models.DateTimeField(blank=True, null=True)),
                ('rework_types', models.TextField(blank=True, null=True)),
            ],
            options={
                'db_table': 'rework_order',
                'managed': False,
            },
        ),
    ]
