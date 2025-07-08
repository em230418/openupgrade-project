#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 12 started `date`" >> log.txt

docker compose run --rm odoo12 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init

echo "migrate to 12 ended  `date`" >> log.txt
