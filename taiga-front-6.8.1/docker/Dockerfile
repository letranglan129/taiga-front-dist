# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC

FROM nginx:1.24.0-alpine

# ENV TAIGA_WEBSOCKETS_URL=ws://192.168.2.92:9000
ENV TAIGA_SUBPATH=
# ENV TAIGA_URL=http://192.168.2.92:9000

COPY dist usr/share/nginx/html
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/conf.json.template /

RUN set -eux; \
    apk update; \
    apk add --no-cache --virtual .build-deps \
       subversion; \
    apk add \
       bash; \
    mv /conf.json.template usr/share/nginx/html;\
    envsubst < /usr/share/nginx/html/conf.json.template > /usr/share/nginx/html/conf.json; \
    sed -i 's;<base href="/">;<base href="'"${TAIGA_SUBPATH}/"'">;g' /usr/share/nginx/html/index.html

