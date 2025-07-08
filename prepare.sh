#!/usr/bin/env sh
set -xe

docker pull odoo:16.0

# install everyting
cd context
git clone https://github.com/OCA/openupgradelib.git
cd ..

git clone https://github.com/OCA/OpenUpgrade --reference /opt/odoo-projects/odoo-master-bare --reference /opt/odoo-projects/11.0/common/odoo/odoo --single-branch -b 11.0 ou11
git clone https://github.com/OCA/OpenUpgrade --reference /opt/odoo-projects/odoo-master-bare --reference /opt/odoo-projects/12.0/common/odoo/odoo --single-branch -b 12.0 ou12
git clone https://github.com/OCA/OpenUpgrade --reference /opt/odoo-projects/odoo-master-bare --reference /opt/odoo-projects/13.0/common/odoo/odoo --single-branch -b 13.0 ou13
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 17.0 ou17

docker compose build

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build
