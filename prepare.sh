#!/usr/bin/env sh
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

git clone https://github.com/OCA/OpenUpgrade --single-branch -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 17.0 ou17
git clone https://github.com/OCA/OpenUpgrade --single-branch -b 18.0 ou18

git clone https://github.com/odoomates/odooapps.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/odoomates/odooapps) vendor/16.0/om
git clone https://github.com/odoomates/odooapps.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/odoomates/odooapps) vendor/17.0/om
git clone https://github.com/odoomates/odooapps.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/odoomates/odooapps) vendor/18.0/om

git clone https://github.com/OCA/web.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/web) vendor/16.0/web
git clone https://github.com/OCA/web.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/web) vendor/17.0/web
git clone https://github.com/OCA/web.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/web) vendor/18.0/web

git clone https://github.com/OCA/social.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/social) vendor/16.0/social
git clone https://github.com/OCA/social.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/social) vendor/17.0/social
git clone https://github.com/OCA/social.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/social) vendor/18.0/social

mkdir -p vendor/16.0/mail
mkdir -p vendor/17.0/mail
git clone https://github.com/OCA/mail.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/mail) vendor/18.0/mail

git clone https://github.com/OCA/crm.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/crm) vendor/16.0/crm
git clone https://github.com/OCA/crm.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/crm) vendor/17.0/crm
git clone https://github.com/OCA/crm.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/crm) vendor/18.0/crm

git clone https://github.com/OCA/timesheet.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/timesheet) vendor/16.0/timesheet
git clone https://github.com/OCA/timesheet.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/timesheet) vendor/17.0/timesheet
git clone https://github.com/OCA/timesheet.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/timesheet) vendor/18.0/timesheet

git clone https://github.com/OCA/server-brand.git -b 16.0 --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/server-brand) vendor/16.0/server-brand
git clone https://github.com/OCA/server-brand.git -b 17.0 --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/server-brand) vendor/17.0/server-brand
git clone https://github.com/OCA/server-brand.git -b 18.0 --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/server-brand) vendor/18.0/server-brand

export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build

docker compose up -d db
sleep 5
