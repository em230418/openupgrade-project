#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 16 started `date`" >> log.txt

docker compose run --rm odoo16 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

echo "migrate to 16 ended  `date`" >> log.txt
