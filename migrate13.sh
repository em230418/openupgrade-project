#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 13 started `date`" >> log.txt

docker compose run --rm odoo13 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init

echo "migrate to 13 ended  `date`" >> log.txt

echo "removing unused modules start `date`" >> log.txt

# upload fixes for migration
cat fixes_v13.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['iap', 'account_bank_statement_import'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo13 odoo shell -d ${PGDATABASE}

echo "removing unused modules end `date`" >> log.txt
