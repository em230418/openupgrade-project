#!/usr/bin/env sh
set -xe

. ./common.sh

echo "uploading 11 started `date`" >> log.txt

echo "create database ${PGDATABASE} owner odoo;" | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 postgres odoo
zcat ${DBFILENAME} | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db psql -h db -p 5432 ${PGDATABASE} odoo

echo "uploading 11 finished `date`" >> log.txt

echo "removing unused moduls `date`" >> log.txt

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['add_remove_follower_omax', 'automatic_backup', 'ehcs_signup_captcha', 'iap', 'account_asset', 'account_budget'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo11 odoo shell -d ${PGDATABASE}

echo "uploading fixes `date`" >> log.txt

# upload fixes for migration
# cat fixes_v11.sql | docker compose run --rm -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
