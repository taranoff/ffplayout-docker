#!/bin/sh

if [[ ! -f 'dbs/player.sqlite3' ]]; then
    python manage.py makemigrations
    python manage.py migrate
    python manage.py loaddata ../docs/db_data.json
    python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')"

    sed -i "s|TIME_ZONE = 'UTC'|TIME_ZONE = '$(cat /etc/timezone)'|g" /opt/ffplayout-api/ffplayout/ffplayout/settings/common.py
fi

if [[ ! -d 'static/rest_framework' ]]; then
    python manage.py collectstatic --noinput
fi

/usr/local/bin/gunicorn --workers 4 --worker-class=gevent --timeout 10800 --log-level=info --log-file=- --access-logfile=- --bind 0.0.0.0:8001 ffplayout.wsgi:application
