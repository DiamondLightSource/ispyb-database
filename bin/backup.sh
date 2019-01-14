#!/bin/sh

# Usage example:
# backup.sh ../dbbackups
# Author: Karl Levik
# Date: 20160314

OUT_DIR=$1
HOST=localhost
DB=ispyb_build
OPTIONS="--add-drop-table --add-locks --create-options --disable-keys --extended-insert --lock-tables --quick --set-charset --single-transaction --max_allowed_packet=1G --host=${HOST} --port=3306 --default-character-set=utf8"

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-data "${DB}" | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' | sed 's/ AUTO_INCREMENT=[0-9]*\b//g' > ${OUT_DIR}/tables.sql

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --routines --no-create-info --no-data "${DB}" | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' | sed -e 's/CREATE .* PROCEDURE/CREATE PROCEDURE/' | sed -e 's/CREATE .* FUNCTION/CREATE FUNCTION/' > ${OUT_DIR}/routines.sql

LOOKUP_TABLES=(
AdminVar
SchemaStatus
ComponentType
ComponentSubType
ConcentrationType
InspectionType
PlateType
SessionType
WorkflowType
Schedule
Imager
Detector
DewarLocationList
BeamLineSetup
BF_component
BF_subcomponent
BF_system
)

LOOKUP_TABLES_STRING=''
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    LOOKUP_TABLES_STRING+=" ${TABLE}"
done

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-create-info --complete-insert ${DB} ${LOOKUP_TABLES_STRING} | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' > ${OUT_DIR}/lookups.sql

IGNORED_TABLES_STRING=''
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    IGNORED_TABLES_STRING+=" --ignore-table=${DB}.${TABLE}"
done

mysqldump --defaults-file=../.my.cnf ${OPTIONS} --skip-triggers --no-create-info --complete-insert ${IGNORED_TABLES_STRING} ${DB} | sed -e 's/DEFINER=[^*]*\*/SQL SECURITY INVOKER \*/' > ${OUT_DIR}/data.sql
