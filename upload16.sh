#!/usr/bin/env sh
set -xe

. ./common.sh

echo "uploading 16 started `date`" >> log.txt

echo "create database ${PGDATABASE} owner odoo;" | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 postgres odoo
zcat ${DBFILENAME} | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo

echo "uploading 16 finished `date`" >> log.txt

echo "removing unused modules `date`" >> log.txt

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['mrp_repair', 'hide_odoo_brand_in_top_right_corner', 'l10n_de_sale'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo16 odoo shell -d ${PGDATABASE}

echo "uploading fixes `date`" >> log.txt

# upload fixes for migration
# cat fixes_v16.sql | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo
