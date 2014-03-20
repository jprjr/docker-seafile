#!/usr/bin/env bash

cd /srv/seafile
seafile-controller -c /srv/seafile/ccnet -d /srv/seafile/seafile-data
cd /srv/seafile/seafile-server/seahub

export PYTHONPATH="$PYTHONPATH:/srv/seafile/seafile-server/seahub/thirdpart"
export CCNET_CONF_DIR="/srv/seafile/ccnet" 
export SEAFILE_CONF_DIR="/srv/seafile/seafile-data"

/usr/lib/seafile/seafileenv/bin/python manage.py runfcgi host=0.0.0.0 port=8000 daemonize=false
