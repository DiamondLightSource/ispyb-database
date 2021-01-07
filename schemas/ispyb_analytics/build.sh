#!/bin/bash

# Exit on first error incl. pipeline errors
set -eo pipefail

# Get this scripts dir
dir=$(dirname $(realpath -e ${0}))

# Get the project'r root dir
project_root=$(dirname $(dirname "${dir}"))

# Load some function definitions in case we need them
source ${project_root}/bin/functions.sh

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

# Read views.sql into variable without removing trailing newlines:
views="$(cat $dir/views.sql; printf a)"
views="${views%a}"

# Replace occurrences of literal '$ispyb' with the value of var ${db}:
echo "${views//\$ispyb/${db}}" | mysql --defaults-file="${project_root}"/.my.cnf -D "${db_analytics}"

