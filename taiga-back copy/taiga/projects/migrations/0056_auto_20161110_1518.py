# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

# Generated by Django 1.9.2 on 2016-11-10 15:18
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0055_json_to_jsonb'),
    ]

    operations = [
        migrations.AddField(
            model_name='project',
            name='is_contact_activated',
            field=models.BooleanField(default=True, verbose_name='active contact'),
        ),
        migrations.AddField(
            model_name='projecttemplate',
            name='is_contact_activated',
            field=models.BooleanField(default=True, verbose_name='active contact'),
        ),
    ]