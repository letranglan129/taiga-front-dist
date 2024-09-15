#!/bin/bash

# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC

FILE=/usr/share/nginx/html/conf.json
if [ ! -f "$FILE" ]; then
    envsubst < /usr/share/nginx/html/conf.json.template \
             > /usr/share/nginx/html/conf.json
fi

sed -i 's;<base href="/">;<base href="'"${TAIGA_SUBPATH}/"'">;g' /usr/share/nginx/html/index.html
