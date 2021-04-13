#!/usr/bin/env bash

# Usage example:
# backup.sh ../dbbackups
# Author: Karl Levik
# Date: 20160314

OUT_DIR=$1

if [ -z "${DB}" ]
then
  DB="ispyb_build"
fi

OPTIONS="--add-drop-table --create-options --disable-keys --extended-insert --skip-add-locks --quick --set-charset --single-transaction --max_allowed_packet=1G --default-character-set=utf8"

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-data "${DB}" | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' | sed 's/ AUTO_INCREMENT=[0-9]*\b//g' > ${OUT_DIR}/tables.sql

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --routines --no-create-info --no-data "${DB}" | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' | sed -e 's/CREATE .* PROCEDURE/CREATE PROCEDURE/' | sed -e 's/CREATE .* FUNCTION/CREATE FUNCTION/' > ${OUT_DIR}/routines.sql

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --no-create-info --no-data --add-drop-trigger "${DB}" | sed -e 's/DEFINER=[^*]*\*/\*/' >> ${OUT_DIR}/routines.sql

source lookup_tables.sh

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-create-info --complete-insert ${DB} ${LOOKUP_TABLES_STRING} | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' > ${OUT_DIR}/lookups.sql

IGNORED_TABLES_STRING=''
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    IGNORED_TABLES_STRING+=" --ignore-table=${DB}.${TABLE}"
done

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-create-info --complete-insert ${IGNORED_TABLES_STRING} ${DB} | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' > ${OUT_DIR}/data.sql
