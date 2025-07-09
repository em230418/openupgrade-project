#!/usr/bin/env sh
set -xe

. ./common.sh

echo "downloading backup 17 started `date`" >> log.txt

OUTPUT_FILENAME=`date +backup%Y%m%d_%H%M%S.sql.gz`
docker compose run --rm -e PGPASSWORD=${PGPASSWORD} -T db pg_dump -h db -p 5432 -d ${PGDATABASE} -U odoo > $OUTPUT_FILENAME

echo "downloading backup 17 ended  `date`" >> log.txt
