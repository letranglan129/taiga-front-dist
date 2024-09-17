# -*- coding: utf-8 -*-
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2021-present Kaleidos INC

# Generated by Django 1.10.2 on 2016-10-26 11:35
from __future__ import unicode_literals

from django.db import migrations
from django.contrib.postgres.fields import JSONField


class Migration(migrations.Migration):

    dependencies = [
        ('userstorage', '0002_fix_json_field_not_null'),
    ]

    operations = [
        migrations.RunSQL(
            """
                ALTER TABLE "{table_name}"
                   ALTER COLUMN "{column_name}"
                           TYPE jsonb
                          USING regexp_replace("{column_name}"::text, '[\\\\]+u0000', '\\\\\\\\u0000', 'g')::jsonb;
            """.format(
                table_name="userstorage_storageentry",
                column_name="value",
            ),
            reverse_sql=migrations.RunSQL.noop
        ),
    ]
