#!/usr/bin/env sh
set -xe

source ./common.sh

echo "migrate to 15 started `date`" >> log.txt

docker-compose run --rm odoo15 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

echo "migrate to 15 ended  `date`" >> log.txt
