#!/usr/bin/env sh
set -xe

. ./common.sh

echo "uploading 14 started `date`" >> log.txt

echo "create database ${PGDATABASE} owner odoo;" | docker-compose run --rm -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 postgres odoo
zcat ${DBFILENAME} | docker-compose run --rm -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo

echo "uploading 14 finished `date`" >> log.txt

echo "removing unused moduls `date`" >> log.txt

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['abs_top_selling_products', 'account_move_line_drilldown', 'analytic_activity_based_cost', 'bom_cost_price_update', 'chart', 'dvit_bom_extra_cost', 'dvit_product_cost_bom_auto', 'dvit_warehouse_stock_restrictions', 'einv_pos_sa', 'mrp_analytic', 'mrp_analytic_child_mo', 'mrp_analytic_cost', 'om_credit_limit', 'pos_product_arabic', 'pos_report_session_summary', 'proweb_kartu_stok', 'combo_product', 'iap', 'sms', 'om_recurring_payments'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d ${PGDATABASE}

echo "uploading fixes `date`" >> log.txt

# upload fixes for migration
cat fixes_v14.sql | docker-compose run --rm -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
