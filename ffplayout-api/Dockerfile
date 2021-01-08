FROM python:3-alpine

ENV DJANGO_SETTINGS_MODULE=ffplayout.settings.production

# get ffplayout-api and all dependencies
RUN apk update && \
    apk add build-base gcc linux-headers tzdata libffi-dev zeromq-dev mediainfo && \
    # sets timezone
    cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    echo "Europe/Berlin" >  /etc/timezone && \
    cd /opt && \
    wget "https://github.com/ffplayout/ffplayout-api/archive/v2.2.0-r1.zip" && \
    unzip 'v2.2.0-r1.zip' && \
    mv 'ffplayout-api-2.1.0' 'ffplayout-api' && \
    rm 'v2.2.0-r1.zip' && \
    cd ffplayout-api && \
    pip install --no-cache-dir -r requirements-base.txt && \
    mkdir /etc/ffplayout && \
    # cleanup
    apk del build-base gcc linux-headers tzdata

RUN cd /opt/ffplayout-api/ffplayout && \
    sed -i "s/---a-very-important-secret-key\:-generate-it-new---/$(python manage.py shell -c 'from django.core.management import utils; print(utils.get_random_secret_key())')/g" ffplayout/settings/production.py && \
    sed -i "s/localhost/*/g" ffplayout/settings/production.py && \
    sed -i "s/ffplayout.local/ffplayout-api:8088/g" ffplayout/settings/production.py && \
    sed -i "s/USE_SOCKET = False/USE_SOCKET = True/g" ffplayout/settings/common.py && \
    sed -i "s/SOCKET_IP = '127.0.0.1'/SOCKET_IP = 'ffplayout-engine'/g" ffplayout/settings/common.py && \
    sed -i "s/http\:\/\/localhost\/live\/stream.m3u8/http\:\/\/localhost\:8088\/live\/tv.m3u8/g" ../docs/db_data.json

COPY ./assets/start.sh /start.sh

WORKDIR /opt/ffplayout-api/ffplayout
EXPOSE 8001

ENTRYPOINT ["/start.sh"]
