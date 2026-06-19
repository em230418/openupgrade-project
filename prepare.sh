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

mkdir ou12
git clone https://github.com/OCA/OpenUpgrade --single-branch --depth 1 -b 13.0 ou13
git clone https://github.com/OCA/OpenUpgrade --single-branch $(addref /opt/odoo-projects/14.0/common/OCA/OpenUpgrade) -b 14.0 ou14
git clone https://github.com/OCA/OpenUpgrade --single-branch $(addref /opt/odoo-projects/15.0/common/OCA/OpenUpgrade) -b 15.0 ou15
git clone https://github.com/OCA/OpenUpgrade --single-branch $(addref /opt/odoo-projects/16.0/common/OCA/OpenUpgrade) -b 16.0 ou16
git clone https://github.com/OCA/OpenUpgrade --single-branch $(addref /opt/odoo-projects/17.0/common/OCA/OpenUpgrade) -b 17.0 ou17
git clone https://github.com/OCA/OpenUpgrade --single-branch $(addref /opt/odoo-projects/18.0/common/OCA/OpenUpgrade) -b 18.0 ou18

git clone https://github.com/OCA/server-tools.git -b 12.0 $(addref /opt/odoo-projects/12.0/common/OCA/server-tools) --single-branch vendor/12.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/server-tools) --single-branch vendor/13.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/server-tools) --single-branch vendor/14.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/server-tools) --single-branch vendor/15.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/server-tools) --single-branch vendor/16.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/server-tools) --single-branch vendor/17.0/server-tools
git clone https://github.com/OCA/server-tools.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/server-tools) --single-branch vendor/18.0/server-tools

git clone https://github.com/OCA/server-ux.git -b 12.0 $(addref /opt/odoo-projects/12.0/common/OCA/server-ux) --single-branch vendor/12.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/server-ux) --single-branch vendor/13.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/server-ux) --single-branch vendor/14.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/server-ux) --single-branch vendor/15.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/server-ux) --single-branch vendor/16.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/server-ux) --single-branch vendor/17.0/server-ux
git clone https://github.com/OCA/server-ux.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/server-ux) --single-branch vendor/18.0/server-ux

git clone https://github.com/OCA/web.git -b 12.0 $(addref /opt/odoo-projects/12.0/common/OCA/web) --single-branch vendor/12.0/web
git clone https://github.com/OCA/web.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/web) --single-branch vendor/13.0/web
git clone https://github.com/OCA/web.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/web) --single-branch vendor/14.0/web
git clone https://github.com/OCA/web.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/web) --single-branch vendor/15.0/web
git clone https://github.com/OCA/web.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/web) --single-branch vendor/16.0/web
git clone https://github.com/OCA/web.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/web) --single-branch vendor/17.0/web
git clone https://github.com/OCA/web.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/web) --single-branch vendor/18.0/web

git clone https://github.com/OCA/crm.git -b 12.0 $(addref /opt/odoo-projects/12.0/common/OCA/crm) --single-branch vendor/12.0/crm
git clone https://github.com/OCA/crm.git -b 13.0 $(addref /opt/odoo-projects/13.0/common/OCA/crm) --single-branch vendor/13.0/crm
git clone https://github.com/OCA/crm.git -b 14.0 $(addref /opt/odoo-projects/14.0/common/OCA/crm) --single-branch vendor/14.0/crm
git clone https://github.com/OCA/crm.git -b 15.0 $(addref /opt/odoo-projects/15.0/common/OCA/crm) --single-branch vendor/15.0/crm
git clone https://github.com/OCA/crm.git -b 16.0 $(addref /opt/odoo-projects/16.0/common/OCA/crm) --single-branch vendor/16.0/crm
git clone https://github.com/OCA/crm.git -b 17.0 $(addref /opt/odoo-projects/17.0/common/OCA/crm) --single-branch vendor/17.0/crm
git clone https://github.com/OCA/crm.git -b 18.0 $(addref /opt/odoo-projects/18.0/common/OCA/crm) --single-branch vendor/18.0/crm


export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

docker compose build

docker compose up -d db
sleep 5

# upload fixes for migration
cat auditlog_line_stop1.sql | docker compose run --rm -T -e PGPASSWORD=${PGPASSWORD} db psql -h db -p 5432 ${PGDATABASE} odoo
