#!/usr/bin/env sh
set -xe

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
git clone https://github.com/OCA/account-financial-tools.git --single-branch -b 15.0 vendor/15.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git --single-branch -b 16.0 vendor/16.0/account-financial-tools

# account_financial_report
git clone https://github.com/OCA/account-financial-reporting.git --single-branch -b 15.0 vendor/15.0/account-financial-reporting
git clone https://github.com/OCA/account-financial-reporting.git --single-branch -b 16.0 vendor/16.0/account-financial-reporting

# account_reconciliation_widget (15.0)
# account_reconcile_oca (16.0)
git clone https://github.com/OCA/account-reconcile.git --single-branch -b 15.0 vendor/15.0/account-reconcile
git clone https://github.com/OCA/account-reconcile.git --single-branch -b 16.0 vendor/16.0/account-reconcile

# pos_order_remove_line
# pos_picking_delayed
git clone https://github.com/OCA/pos.git --single-branch -b 15.0 vendor/15.0/pos
git clone https://github.com/OCA/pos.git --single-branch -b 16.0 vendor/16.0/pos

# queue_job
git clone https://github.com/OCA/queue.git --single-branch -b 15.0 vendor/15.0/queue
git clone https://github.com/OCA/queue.git --single-branch -b 16.0 vendor/16.0/queue

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
mkdir -p vendor/15.0/stock-logistics-request
git clone https://github.com/OCA/stock-logistics-request --single-branch -b 16.0 vendor/16.0/stock-logistics-request
git clone https://github.com/OCA/stock-logistics-warehouse --single-branch -b 16.0 vendor/16.0/stock-logistics-warehouse
git clone https://github.com/OCA/stock-logistics-warehouse --single-branch -b 15.0 vendor/15.0/stock-logistics-warehouse

# stock_restrict_lot
git clone https://github.com/OCA/stock-logistics-workflow --single-branch -b 15.0 vendor/15.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow --single-branch -b 16.0 vendor/16.0/stock-logistics-workflow

# web_domain_field
# web_notify
git clone https://github.com/OCA/web --single-branch -b 15.0 vendor/15.0/web
git clone https://github.com/OCA/web --single-branch -b 16.0 vendor/16.0/web

# bluesky_*
git clone git@gitlab.com:itpp/dev/private-soladrive.git --single-branch -b 14.0 vendor/15.0/it-projects-llc-addons  # yes, we are deliberatly using 14.0 branch for 15.0
git clone git@gitlab.com:itpp/dev/private-soladrive.git --single-branch -b 16.0 vendor/16.0/it-projects-llc-addons

# accounting_pdf_reports
# om_account_accountant
# om_account_asset
# om_account_bank_statement_import
# om_account_budget
# om_account_daily_reports
# om_account_followup
git clone https://github.com/odoomates/odooapps --single-branch -b 15.0 --depth 1 vendor/15.0/odoomates
git clone https://github.com/odoomates/odooapps --single-branch -b 16.0 --depth 1 vendor/16.0/odoomates

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
git clone https://github.com/CybroOdoo/CybroAddons.git --depth 1 --single-branch -b 15.0 vendor/15.0/cybrosys
git clone https://github.com/CybroOdoo/CybroAddons.git --depth 1 --single-branch -b 16.0 vendor/16.0/cybrosys
git clone https://github.com/CybroOdoo/OpenHRMS.git --single-branch -b 15.0 vendor/15.0/OpenHRMS
git clone https://github.com/CybroOdoo/OpenHRMS.git --single-branch -b 16.0 vendor/16.0/OpenHRMS

# https://apps.odoo.com/apps/modules/17.0/ms_report_stock
# https://apps.odoo.com/apps/modules/16.0/mass_cancel_journal_entries
# https://apps.odoo.com/apps/modules/16.0/ak_inventory_adjustments
mkdir -p vendor/15.0/custom
mkdir -p vendor/16.0/custom

# Some info on modules to remove
# combo_product - not used. 3 combo products and all in archive

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker-compose build
