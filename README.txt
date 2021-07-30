# install everyting
git clone https://github.com/OCA/openupgradelib.git context/
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
docker-compose build

cd ou14
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2741.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2856.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2789.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2823.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2864.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2865.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2854.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2842.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2822.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2742.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2790.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2844.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2843.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2845.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2862.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2858.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2825.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2788.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2841.patch | patch -p1
curl https://patch-diff.githubusercontent.com/raw/OCA/OpenUpgrade/pull/2819.patch | patch -p1
cd ..

git clone https://github.com/muk-it/muk_web.git --single-branch -b 13.0 vendor/13.0/muk_web
git clone https://github.com/muk-it/muk_web.git --single-branch -b 14.0 vendor/14.0/muk_web

git clone https://github.com/muk-it/muk_base.git --single-branch -b 13.0 vendor/13.0/muk_base
git clone https://github.com/muk-it/muk_base.git --single-branch -b 14.0 vendor/14.0/muk_base

git clone https://github.com/OCA/crm.git --single-branch -b 13.0 vendor/13.0/crm
git clone https://github.com/OCA/crm.git --single-branch -b 14.0 vendor/14.0/crm

git clone https://github.com/OCA/partner-contact.git --single-branch -b 13.0 vendor/13.0/partner-contact
git clone https://github.com/OCA/partner-contact.git --single-branch -b 14.0 vendor/14.0/partner-contact

git clone https://github.com/OCA/bank-statement-import.git --single-branch -b 13.0 vendor/13.0/bank-statement-import
git clone https://github.com/OCA/bank-statement-import.git --single-branch -b 14.0 vendor/14.0/bank-statement-import

export PGPASSWORD=odoo

# upload database on 13.0, browse it
docker-compose up odoo13

# backup database for 13.0
echo "create database korvetlog13 with template korvetlog owner odoo;" | psql -h localhost -p 5433 postgres odoo

echo "env['ir.module.module'].search([('name', 'in', ['muk_autovacuum', 'muk_web_utils', 'muk_web_theme', 'muk_utils', 'iap', 'sms', 'sale_timesheet', 'website', 'stock'])]).button_immediate_uninstall()" | docker-compose run --rm odoo13 odoo shell -d korvetlog

# migrate
docker-compose run --rm odoo14 odoo -d korvetlog -u all -c /etc/odoo/odoo.conf --stop-after-init --load=base,web,openupgrade_framework

# удаляем модули, которых нет
echo "env['ir.module.module'].search([('name', 'in', ['account_bank_statement_import', 'web_diagram'])]).button_immediate_uninstall()" | docker-compose run --rm odoo14 odoo shell -d korvetlog

# устанавливаем необходимый модуль
echo "env['ir.module.module'].search([('name', 'in', ['account_statement_import', 'account_edi'])]).button_immediate_install()" | docker-compose run --rm odoo14 odoo shell -d korvetlog

# run odoo 14.0, make sure everything is fine
docker-compose up odoo14
