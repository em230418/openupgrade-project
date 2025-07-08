#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 13 started `date`" >> log.txt

docker compose run --rm odoo13 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init

echo "migrate to 13 ended  `date`" >> log.txt
