#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 18 started `date`" >> log.txt

docker compose run --rm odoo18 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework,module_change_auto_install

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['account_financial_report'])]).button_immediate_install()" | docker compose run --rm -T odoo18 odoo shell -d ${PGDATABASE}

echo "migrate to 18 ended  `date`" >> log.txt

# upload fixes for migration
# cat fixes_v18.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
