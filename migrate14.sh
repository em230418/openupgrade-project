#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 14 started `date`" >> log.txt

docker compose run --rm odoo14 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework,module_change_auto_install

echo "migrate to 14 ended  `date`" >> log.txt
