#!/usr/bin/env sh
set -xe

. ./common.sh

echo "migrate to 18 started `date`" >> log.txt

# upload fixes for migration
cat prefixes_v18.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

cat prefixes_v18.py | docker compose run --rm -T odoo17 odoo shell -d ${PGDATABASE}

docker compose run --rm odoo18 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework,module_change_auto_install

echo "env['ir.module.module'].search([('state', '!=', 'uninstalled'), ('name', 'in', ['account_statement_import_file', 'dadata_legal_info', 'dadata_partner', 'dms', 'itl_styles', 'itl_tools', 'l10n_ru_itl', 'mail_composer_on_send_message', 'mass_operation_abstract', 'model_completeness', 'muk_web_branding', 'muk_web_theme_mail', 'payment_itl', 'res_partner_completeness', 'saas_openshift_client', 'stormoff_crm_add_responsible_in_wizard', 'stormoff_crm_long_name', 'stormoff_ui_updates', 'users_ldap_groups'])]).button_immediate_uninstall()" | docker compose run --rm -T odoo18 odoo shell -d ${PGDATABASE}

echo "migrate to 18 ended  `date`" >> log.txt

# upload fixes for migration
# cat fixes_v18.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
