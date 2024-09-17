# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

# Generated by Django 1.9.2 on 2016-09-28 07:55
from __future__ import unicode_literals

from django.db import migrations, models
import taiga.base.utils.time


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0010_auto_20160614_1201'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='taskboard_order',
            field=models.BigIntegerField(default=taiga.base.utils.time.timestamp_ms, verbose_name='taskboard order'),
        ),
        migrations.AlterField(
            model_name='task',
            name='us_order',
            field=models.BigIntegerField(default=taiga.base.utils.time.timestamp_ms, verbose_name='us order'),
        ),
    ]
