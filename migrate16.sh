#!/usr/bin/env sh
set -xe

source ./common.sh

echo "migrate to 16 started `date`" >> log.txt

docker-compose run --rm odoo16 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

echo "migrate to 16 ended  `date`" >> log.txt

# upload fixes for migration
cat fixes_v16.sql | docker-compose run --rm -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

echo "installing modules `date`" >> log.txt

# installing other modules
echo "env['ir.module.module'].search([('name', 'in', ['ak_inventory_adjustments', 'l10n_sa_pos'])]).button_immediate_install()" | docker-compose run --rm odoo16 odoo shell -d ${PGDATABASE}

echo "installing modules done `date`" >> log.txt
