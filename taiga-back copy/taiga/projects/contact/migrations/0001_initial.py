# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

# Generated by Django 1.9.2 on 2016-11-10 15:18
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('projects', '0056_auto_20161110_1518'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='ContactEntry',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comment', models.TextField(verbose_name='comment')),
                ('created_date', models.DateTimeField(auto_now_add=True, verbose_name='created date')),
                ('project', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='contact_entries', to='projects.Project', verbose_name='project')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='contact_entries', to=settings.AUTH_USER_MODEL, verbose_name='user')),
            ],
            options={
                'verbose_name': 'contact entry',
                'ordering': ['-created_date', 'id'],
                'verbose_name_plural': 'contact entries',
            },
        ),
    ]