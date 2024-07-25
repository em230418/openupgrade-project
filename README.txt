# install everyting
cd context
git clone https://github.com/OCA/openupgradelib.git
cd ..

git clone https://github.com/OCA/OpenUpgrade --single-branch -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
docker-compose build

# account_analytic_parent
git clone https://github.com/OCA/account-analytic.git --single-branch -b 15.0 vendor/15.0/account-analytic
git clone https://github.com/OCA/account-analytic.git --single-branch -b 16.0 vendor/16.0/account-analytic

# account_journal_general_sequence
# account_financial_report
git clone https://github.com/OCA/account-financial-tools.git --single-branch -b 15.0 vendor/15.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git --single-branch -b 16.0 vendor/16.0/account-financial-tools

# account_reconciliation_widget (15.0)
# account_reconcile_oca (16.0)
git clone https://github.com/OCA/account-reconcile.git --single-branch -b 15.0 vendor/15.0/account-reconcile
git clone https://github.com/OCA/account-reconcile.git --single-branch -b 16.0 vendor/16.0/account-reconcile

# pos_order_remove_line
git clone https://github.com/OCA/pos.git --single-branch -b 15.0 vendor/15.0/pos
git clone https://github.com/OCA/pos.git --single-branch -b 16.0 vendor/16.0/pos

# report_xlsx
git clone https://github.com/OCA/reporting-engine --single-branch -b 15.0 vendor/15.0/reporting-engine
git clone https://github.com/OCA/reporting-engine --single-branch -b 16.0 vendor/16.0/reporting-engine

# auditlog
git clone https://github.com/OCA/server-tools.git --single-branch -b 15.0 vendor/15.0/server-tools
git clone https://github.com/OCA/server-tools.git --single-branch -b 16.0 vendor/16.0/server-tools

# date_range
git clone https://github.com/OCA/server-ux --single-branch -b 15.0 vendor/15.0/server-ux
git clone https://github.com/OCA/server-ux --single-branch -b 16.0 vendor/16.0/server-ux

# stock_request
# stock_request_direction
git clone https://github.com/OCA/stock-logistics-request --single-branch -b 16.0 vendor/16.0/stock-logistics-request
git clone https://github.com/OCA/stock-logistics-warehouse --single-branch -b 15.0 vendor/15.0/stock-logistics-request

# stock_restrict_lot
git clone https://github.com/OCA/stock-logistics-workflow --single-branch -b 15.0 vendor/15.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow --single-branch -b 16.0 vendor/15.0/stock-logistics-workflow

# web_domain_field
git clone https://github.com/OCA/web --single-branch -b 15.0 vendor/15.0/web
git clone https://github.com/OCA/web --single-branch -b 16.0 vendor/16.0/web

# accounting_pdf_reports
# om_account_accountant
# om_account_asset
# om_account_bank_statement_import
# om_account_budget
# om_account_daily_reports
# om_account_followup
# om_recurring_payments
git clone https://github.com/odoomates/odooapps --single-branch -b 15.0 vendor/15.0/odoomates
git clone https://github.com/odoomates/odooapps --single-branch -b 16.0 vendor/16.0/odoomates

# barcode_scanning_sale_purchase
# base_account_budget
# hr_contract_types
# hr_payroll_account_community
# hr_payroll_community
# inventory_barcode_scanning
# low_stocks_product_alert
# ohrms_loan
# pos_magnify_image
# pos_mrp_order
# pos_restrict
# product_barcode
git clone https://github.com/CybroOdoo/CybroAddons.git --single-branch -b 15.0 vendor/15.0/cybrosys
git clone https://github.com/CybroOdoo/CybroAddons.git --single-branch -b 16.0 vendor/16.0/cybrosys
git clone https://github.com/CybroOdoo/OpenHRMS.git --single-branch -b 15.0 vendor/15.0/OpenHRMS
git clone https://github.com/CybroOdoo/OpenHRMS.git --single-branch -b 16.0 vendor/16.0/OpenHRMS

# https://apps.odoo.com/apps/modules/15.0/ms_report_stock
# https://apps.odoo.com/apps/modules/16.0/mass_cancel_journal_entries
mkdir -p vendor/15.0/custom
mkdir -p vendor/16.0/custom

# Some info on modules to remove
# combo_product - not used. 3 combo products and all in archive

export PGPASSWORD=odoo
export DBNAME_BASE=bluesky

# upload database on 14.0, browse it
docker-compose up odoo14

# backup database for 14.0
echo "create database ${DBNAME_BASE}14 with template bluesky owner odoo;" | psql -h localhost -p 5433 postgres odoo

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['abs_top_selling_products', 'account_move_line_drilldown', 'analytic_activity_based_cost', 'bom_cost_price_update', 'chart', 'dvit_bom_extra_cost', 'dvit_product_cost_bom_auto', 'dvit_warehouse_stock_restrictions', 'einv_pos_sa', 'mrp_analytic', 'mrp_analytic_child_mo', 'mrp_analytic_cost', 'om_credit_limit', 'pos_product_arabic', 'pos_report_session_summary', 'proweb_kartu_stok', 'combo_product', 'iap', 'sms'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d ${DBNAME_BASE}

# migrate
docker-compose run --rm odoo15 odoo -d ${DBNAME_BASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

# удаляем модули, которых нет
echo "env['ir.module.module'].search([('name', 'in', ['web_diagram'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d ${DBNAME_BASE}

# устанавливаем необходимый модуль
# echo "env['ir.module.module'].search([('name', 'in', [])]).button_immediate_install()" | docker-compose run --rm odoo14 odoo shell -d ${DBNAME_BASE}

# run odoo 15.0, make sure everything is fine
docker-compose up odoo15
