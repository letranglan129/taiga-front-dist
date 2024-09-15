# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

# Generated by Django 1.11.16 on 2019-02-19 13:45
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0012_add_due_date'),
        ('userstories', '0016_userstory_assigned_users'),
    ]

    operations = [
        migrations.AddField(
            model_name='userstory',
            name='generated_from_task',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='generated_user_stories', to='tasks.Task', verbose_name='generated from task'),
        ),
    ]
