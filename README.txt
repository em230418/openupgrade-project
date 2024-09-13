./prepare.sh

export PGPASSWORD=odoo
export PGDATABASE=prod

# upload database on 15.0, browse it
docker-compose up odoo15

# ---

# backup database for 15.0
echo "create database ${PGDATABASE}15 with template ${PGDATABASE} owner odoo;" | psql -h localhost -p 5433 postgres odoo

echo "env['ir.module.module'].search([('state', '=', 'installed'), ('name', 'in', ['qr_generator'])]).button_immediate_uninstall()" | docker-compose run --rm odoo15 odoo shell -d ${PGDATABASE}

# upload fixes for migration
# cat fixes_v15.sql | psql -h localhost -p 5433 ${PGDATABASE} odoo

# migrate
docker-compose run --rm odoo16 odoo -d ${PGDATABASE} -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

# удаляем модули, которых нет
# echo "env['ir.module.module'].search([('name', 'in', ['web_diagram'])]).button_immediate_uninstall()" | docker-compose run --rm odoo15 odoo shell -d ${PGDATABASE}

# устанавливаем необходимый модуль
# echo "env['ir.module.module'].search([('name', 'in', [])]).button_immediate_install()" | docker-compose run --rm odoo15 odoo shell -d ${PGDATABASE}

# run odoo 16.0, make sure everything is fine
docker-compose up odoo16
