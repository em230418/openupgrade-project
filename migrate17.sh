#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 17 started `date`" >> log.txt

# upload fixes for migration
cat prefixes_v17.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

docker compose run --rm odoo17 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework,mail_alias_domain_fix,module_change_auto_install

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['om_account_bank_statement_import'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo17 odoo shell -d ${PGDATABASE}

echo "migrate to 17 ended  `date`" >> log.txt

# upload fixes for migration
cat fixes_v17.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
