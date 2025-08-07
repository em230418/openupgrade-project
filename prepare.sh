#!/usr/bin/env sh
set -xe

cd context
git clone https://github.com/OCA/openupgradelib.git --depth 1
cd ..

if [ -d "/opt/odoo-projects/odoo-master-bare" ]; then
    OLD_OU_GIT_PARAMS="--reference /opt/odoo-projects/odoo-master-bare --reference /opt/odoo-projects"
    OLD_OU_GIT_PARAM_SUFFIX11="/11.0/common/odoo/odoo"
    OLD_OU_GIT_PARAM_SUFFIX12="/12.0/common/odoo/odoo"
    OLD_OU_GIT_PARAM_SUFFIX13="/13.0/common/odoo/odoo"
else
    OLD_OU_GIT_PARAMS="--depth 1"
    OLD_OU_GIT_PARAM_SUFFIX11=""
    OLD_OU_GIT_PARAM_SUFFIX12=""
    OLD_OU_GIT_PARAM_SUFFIX13=""
fi

#git clone https://github.com/OCA/OpenUpgrade --single-branch -b 11.0 ou11 $OLD_OU_GIT_PARAMS$OLD_OU_GIT_PARAM_SUFFIX11
#git clone https://github.com/OCA/OpenUpgrade --single-branch -b 12.0 ou12 $OLD_OU_GIT_PARAMS$OLD_OU_GIT_PARAM_SUFFIX12
#git clone https://github.com/OCA/OpenUpgrade --single-branch -b 13.0 ou13 $OLD_OU_GIT_PARAMS$OLD_OU_GIT_PARAM_SUFFIX13
mkdir ou13
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 17.0 ou17
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 18.0 ou18

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build

docker compose up -d db
sleep 5
