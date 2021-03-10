#!/bin/bash

# Exit on first error incl. pipeline errors
set -eo pipefail

# Get this scripts dir
dir=$(dirname $(realpath -e ${0}))

# Get the project'r root dir
project_root=$(dirname $(dirname "${dir}"))

# Load some function definitions in case we need them
source ${project_root}/bin/functions.sh

# Get a list + string with the names of the lookup tables
source ${project_root}/bin/lookup_tables.sh

# Unless already defined, set default values for database names
if [ -z "${db}" ]
then
  db="ispyb_build"
fi

if [ -z "${db_analytics}" ]
then
  db_analytics="ispyb_analytics"
fi

echo "Modifying ${db} database"
mysql --defaults-file="${project_root}"/.my.cnf -D "${db}" < "${dir}"/tables.sql
mysql --defaults-file="${project_root}"/.my.cnf -D "${db}" < "${dir}"/data.sql
mysql --defaults-file="${project_root}"/.my.cnf -D "${db}" < "${dir}"/modify_ispyb.sql

echo "Re-creating ${db_analytics} database with views"
mysql --defaults-file="${project_root}"/.my.cnf -e "DROP DATABASE IF EXISTS $db_analytics; CREATE DATABASE IF NOT EXISTS $db_analytics; SET GLOBAL log_bin_trust_function_creators=ON;"

# Read views.sql into variable, replace variable
sql=$(env ispyb="${db}" envsubst < "${dir}"/views.sql)
echo "${sql}" | mysql --defaults-file="${project_root}"/.my.cnf -D "${db_analytics}"

echo "Creating role and granting permission to access views"
mysql --defaults-file="${project_root}"/.my.cnf -D "${db_analytics}" < "${dir}"/grants.sql

# Create views and grants for the lookup tables
for TABLE in "${LOOKUP_TABLES[@]}"
do :
    mysql --defaults-file="${project_root}"/.my.cnf -D "${db_analytics}" -e "CREATE OR REPLACE SQL SECURITY DEFINER VIEW ${TABLE} AS SELECT * FROM $ispyb.${TABLE}"
    mysql --defaults-file="${project_root}"/.my.cnf -e "GRANT SELECT ON ${TABLE} TO data_scientist"
done

