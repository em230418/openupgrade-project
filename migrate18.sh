#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 18 started `date`" >> log.txt

docker compose run --rm odoo18 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

echo "migrate to 18 ended  `date`" >> log.txt

# upload fixes for migration
# cat fixes_v18.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
