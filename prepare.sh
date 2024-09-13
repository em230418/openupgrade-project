#!/usr/bin/env sh
set -xe

# install everyting
cd context
git clone https://github.com/OCA/openupgradelib.git
cd ..

git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
docker-compose build

# web_responsive
git clone https://github.com/OCA/web --single-branch -b 16.0 vendor/16.0/web

# disable_odoo_online
git clone https://github.com/OCA/server-brand.git --single-branch -b 16.0 vendor/16.0/server-brand

# om_account_accountant
# om_account_asset
# om_account_bank_statement_import
# om_account_budget
git clone https://github.com/odoomates/odooapps --single-branch -b 16.0 --depth 1 vendor/16.0/odoomates

# https://apps.odoo.com/apps/modules/16.0/dp_eu_gdpr
# https://apps.odoo.com/apps/modules/16.0/hide_odoo
# https://apps.odoo.com/apps/modules/16.0/hide_odoo_brand_in_top_right_corner
mkdir -p vendor/16.0/custom

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker-compose build
