#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 13 started `date`" >> log.txt

# upload fixes for migration
cat prefixes_v13.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

docker compose run --rm odoo13 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,module_change_auto_install

echo "migrate to 13 ended  `date`" >> log.txt

echo "removing unused modules start `date`" >> log.txt

echo "env['ir.module.module'].search([('state', 'in', ('installed', 'to upgrade')), ('name', 'in', ('itl_tools', 'itl_styles', 'l10n_ru_itl', 'res_partner_completeness', 'model_completeness'))]).button_immediate_uninstall()"  | docker compose run --rm -T odoo13 odoo shell -d ${PGDATABASE}

echo "env['ir.module.module'].search([('state', '=', ('installed', 'to upgrade')), ('name', 'in', ('muk_web_theme_mail', 'payment_itl', 'muk_web_branding', 'saas_openshift_client', 'dms'))]).button_immediate_uninstall()"  | docker compose run --rm -T odoo13 odoo shell -d ${PGDATABASE}

echo "removing unused modules end `date`" >> log.txt
