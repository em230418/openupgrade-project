./prepare.sh

export PGPASSWORD=odoo
export PGDATABASE=migbluesky

# upload database on 14.0, browse it
docker-compose up odoo14

# backup database for 14.0
echo "create database ${PGDATABASE}14 with template bluesky owner odoo;" | psql -h localhost -p 5433 postgres odoo

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['abs_top_selling_products', 'account_move_line_drilldown', 'analytic_activity_based_cost', 'bom_cost_price_update', 'chart', 'dvit_bom_extra_cost', 'dvit_product_cost_bom_auto', 'dvit_warehouse_stock_restrictions', 'einv_pos_sa', 'mrp_analytic', 'mrp_analytic_child_mo', 'mrp_analytic_cost', 'om_credit_limit', 'pos_product_arabic', 'pos_report_session_summary', 'proweb_kartu_stok', 'combo_product', 'iap', 'sms', 'om_recurring_payments'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d ${PGDATABASE}

# migrate
docker-compose run --rm odoo15 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

# удаляем модули, которых нет
echo "env['ir.module.module'].search([('name', 'in', ['web_diagram'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d ${PGDATABASE}

# устанавливаем необходимый модуль
# echo "env['ir.module.module'].search([('name', 'in', [])]).button_immediate_install()" | docker-compose run --rm odoo14 odoo shell -d ${PGDATABASE}

# run odoo 15.0, make sure everything is fine
docker-compose up odoo15
