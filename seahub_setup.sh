#!/usr/bin/env bash

SEAFILE_VERSION=2.1.5

cd /srv/seafile
mkdir seafile-server

curl -R -L https://github.com/haiwen/seahub/archive/v${SEAFILE_VERSION}-server.tar.gz \
    | tar -C /srv/seafile/seafile-server -xz && \
    ln -s /srv/seafile/seafile-server/seahub-${SEAFILE_VERSION}-server /srv/seafile/seafile-server/seahub
