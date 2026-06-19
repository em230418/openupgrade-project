#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 15 started `date`" >> log.txt

# upload fixes for migration
cat prefixes_v15.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

cat prefixes_v15.py | docker compose run --rm -T odoo15 odoo shell -d ${PGDATABASE}

docker compose run --rm odoo15 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

echo "migrate to 15 ended  `date`" >> log.txt
