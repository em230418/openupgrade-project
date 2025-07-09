#!/usr/bin/env sh
set -xe

docker pull odoo:16.0
docker pull odoo:17.0

cd context
git clone https://github.com/OCA/openupgradelib.git --depth 1
cd ..

if [ -d "/opt/odoo-projects/odoo-master-bare" ]; then
    OLD_OU_GIT_PARAMS="--reference /opt/odoo-projects/odoo-master-bare --reference /opt/odoo-projects/"
else
    OLD_OU_GIT_PARAMS="--depth 1 #"
fi

git clone https://github.com/OCA/OpenUpgrade --single-branch -b 11.0 ou11 $OLD_OU_GIT_PARAMS/11.0/common/odoo/odoo
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 11.0 ou12 $OLD_OU_GIT_PARAMS/12.0/common/odoo/odoo
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 11.0 ou13 $OLD_OU_GIT_PARAMS/13.0/common/odoo/odoo
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 17.0 ou17

cd vendor/17.0/
git clone https://github.com/OCA/sale-reporting -b 17.0 --single-branch --depth 1
cd custom
ln -s ../sale-reporting/sale_quotation_builder
cd ..
cd ..

docker compose build

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build
