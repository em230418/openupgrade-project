# install everyting
git clone https://github.com/OCA/openupgradelib.git context/
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
docker-compose build

git clone https://github.com/muk-it/muk_web.git --single-branch -b 13.0 vendor/13.0/muk_web
git clone https://github.com/muk-it/muk_web.git --single-branch -b 14.0 vendor/14.0/muk_web

git clone https://github.com/muk-it/muk_base.git --single-branch -b 13.0 vendor/13.0/muk_base
git clone https://github.com/muk-it/muk_base.git --single-branch -b 14.0 vendor/14.0/muk_base

git clone https://github.com/OCA/crm.git --single-branch -b 13.0 vendor/13.0/crm
git clone https://github.com/OCA/crm.git --single-branch -b 14.0 vendor/14.0/crm

git clone https://github.com/OCA/partner-contact.git --single-branch -b 13.0 vendor/13.0/partner-contact
git clone https://github.com/OCA/partner-contact.git --single-branch -b 14.0 vendor/14.0/partner-contact

export PGPASSWORD=odoo

# upload database on 13.0, browse it and exit
docker-compose up odoo13

# backup database for 13.0
echo "create database korvetlog13 with template korvetlog owner odoo;" | psql -h localhost -p 5433 postgres odoo
# migrate
docker-compose run --rm odoo14 /opt/ou14/odoo-bin -d korvetlog -u all -c /etc/odoo/odoo.conf --stop-after-init

# run odoo 14.0, make sure everything is fine
docker-compose up odoo14
