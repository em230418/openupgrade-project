# install everyting
git clone https://github.com/OCA/openupgradelib.git context/
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 11.0 ou11
docker-compose build

export PGPASSWORD=odoo

# make demo database on 10.0, browse it and exit
docker-compose up odoo10

# backup database for 10.0
echo "create database test_upgrade10 with template test_upgrade owner odoo;" | psql -h localhost -p 5433 postgres odoo
# migrate
docker-compose run --rm odoo11 /opt/ou11/odoo-bin -d test_upgrade -u all -c /etc/odoo/odoo.conf --stop-after-init

# run odoo 11.0, make sure everything is fine
docker-compose up odoo11

# backup database for 11.0
echo "create database test_upgrade11 with template test_upgrade owner odoo;" | psql -h localhost -p 5433 postgres odoo
# migrate
docker-compose run --rm odoo12 /opt/ou12/odoo-bin -d test_upgrade -u all -c /etc/odoo/odoo.conf --stop-after-init
# run odoo 12.0, make sure everything is fine
docker-compose up odoo12
