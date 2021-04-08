FROM python:3-alpine

ENV DJANGO_SETTINGS_MODULE=ffplayout.settings.production
ARG version=3.0.0

# get ffplayout-api and all dependencies
RUN apk update && \
    apk add build-base gcc linux-headers tzdata libffi-dev zeromq-dev mediainfo && \
    cd /opt && \
    wget "https://github.com/ffplayout/ffplayout-api/archive/v${version}.zip" && \
    unzip "v${version}.zip" && \
    mv "ffplayout-api-${version}" 'ffplayout-api' && \
    rm "v${version}.zip" && \
    cd ffplayout-api && \
    pip install --no-cache-dir -r requirements-base.txt && \
    mkdir /etc/ffplayout && \
    # cleanup
    apk del build-base gcc linux-headers

RUN cd /opt/ffplayout-api/ffplayout && \
    secret=$(python -c 'import re;from random import choice; import sys; from django.core.management import utils; sys.stdout.write(re.escape(utils.get_random_secret_key()))') && \
    sed -i "s/---a-very-important-secret-key-_-generate-it-new---/$secret/g" ffplayout/settings/production.py && \
    sed -i "s/localhost/*/g" ffplayout/settings/production.py && \
    sed -i "s/ffplayout.local/ffplayout-api/g" ffplayout/settings/production.py && \
    sed -i "s/USE_SOCKET = False/USE_SOCKET = True/g" ffplayout/settings/common.py && \
    sed -i "s/SOCKET_IP = 'localhost'/SOCKET_IP = 'ffplayout-engine'/g" ffplayout/settings/common.py && \
    sed -i "s/SRS_IP = '127.0.0.1'/SRS_IP = 'srs'/g" ffplayout/settings/common.py && \
    sed -i "s/stream.m3u8/tv.m3u8/g" ../docs/db_data.json

COPY ./assets/start.sh /start.sh

WORKDIR /opt/ffplayout-api/ffplayout
EXPOSE 8001

ENTRYPOINT ["/start.sh"]
