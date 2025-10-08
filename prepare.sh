#!/usr/bin/env bash
set -xe

cd context
git clone https://github.com/OCA/openupgradelib.git --depth 1
cd ..

function addref() {
    if [ -d "$1" ]; then
        echo "--reference $1"
    else
        echo "--depth 1"
    fi
}

mkdir ou13
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 14.0 ou14
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 17.0 ou17
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 18.0 ou18

mkdir vendor/13.0/cybrosys
mkdir vendor/14.0/cybrosys
mkdir vendor/15.0/cybrosys
mkdir vendor/16.0/cybrosys
mkdir vendor/17.0/cybrosys
git clone https://github.com/CybroOdoo/CybroAddons.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/CybroOdoo/CybroAddons) --single-branch vendor/18.0/cybrosys

git clone https://github.com/OCA/stock-logistics-workflow.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/stock-logistics-workflow) --single-branch vendor/13.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/stock-logistics-workflow) --single-branch vendor/14.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/stock-logistics-workflow) --single-branch vendor/15.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/stock-logistics-workflow) --single-branch vendor/16.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/stock-logistics-workflow) --single-branch vendor/17.0/stock-logistics-workflow
git clone https://github.com/OCA/stock-logistics-workflow.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/stock-logistics-workflow) --single-branch vendor/18.0/stock-logistics-workflow

git clone https://github.com/OCA/server-tools.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/server-tools) --single-branch vendor/13.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/server-tools) --single-branch vendor/14.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/server-tools) --single-branch vendor/15.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/server-tools) --single-branch vendor/16.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/server-tools) --single-branch vendor/17.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/server-tools) --single-branch vendor/18.0/server-tools

###BLOCK-COMMENT

git clone https://github.com/OCA/account-financial-tools.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/account-financial-tools) --single-branch vendor/13.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/account-financial-tools) --single-branch vendor/14.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/account-financial-tools) --single-branch vendor/15.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/account-financial-tools) --single-branch vendor/16.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/account-financial-tools) --single-branch vendor/17.0/account-financial-tools
git clone https://github.com/OCA/account-financial-tools.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/account-financial-tools) --single-branch vendor/18.0/account-financial-tools


mkdir vendor/13.0/account-financial-reporting
mkdir vendor/14.0/account-financial-reporting
mkdir vendor/15.0/account-financial-reporting
mkdir vendor/16.0/account-financial-reporting
mkdir vendor/17.0/account-financial-reporting
git clone https://github.com/OCA/account-financial-reporting.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/account-financial-reporting) --single-branch vendor/18.0/account-financial-reporting

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build

docker compose up -d db
sleep 5
