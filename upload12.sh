#!/usr/bin/env sh
set -xe

. ./common.sh

echo "uploading 12 started `date`" >> log.txt

echo "create database ${PGDATABASE} owner odoo;" | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 postgres odoo

zcat ${DBFILENAME} | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo

cat auditlog_tables.sql | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo

echo "uploading 12 finished `date`" >> log.txt

echo "removing unused modules `date`" >> log.txt

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['auditlog'])]).button_immediate_upgrade()" | docker compose run --rm -T odoo12 odoo shell -d ${PGDATABASE}

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['muk_web_theme', 'muk_web_theme_mail', 'muk_fields_lobject', 'dms', 'stormoff_approve_invoice'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo12 odoo shell -d ${PGDATABASE}

echo "uploading fixes `date`" >> log.txt

# upload fixes for migration
#cat fixes_v12.sql | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo
