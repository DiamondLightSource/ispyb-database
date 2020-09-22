#!/bin/bash

# Script to create the database from the schema .sql files and identify any
# update .sql files that haven't been run. Also generate documentation from
# inline comments in the schema.

# Some code borrowed from Stefan Buck's gist file at:
# https://gist.github.com/stefanbuck/ce788fee19ab6eb0b4447a85fc99f447

# Author: Karl Levik

source bin/functions.sh

db="ispyb_build"

echo "Dropping + creating build database"
mysql --defaults-file=.my.cnf -e "DROP DATABASE IF EXISTS $db; CREATE DATABASE $db; SET GLOBAL log_bin_trust_function_creators=ON;"

if [[ $? -eq 0 ]]
then
  mysql --defaults-file=.my.cnf -D $db < schema/tables.sql
  mysql --defaults-file=.my.cnf -D $db < schema/lookups.sql
  mysql --defaults-file=.my.cnf -D $db < schema/data.sql
  mysql --defaults-file=.my.cnf -D $db < schema/routines.sql
  mysql --defaults-file=.my.cnf -D $db < grants/ispyb_acquisition.sql
  mysql --defaults-file=.my.cnf -D $db < grants/ispyb_processing.sql
  mysql --defaults-file=.my.cnf -D $db < grants/ispyb_web.sql
  mysql --defaults-file=.my.cnf -D $db < grants/ispyb_import.sql

  # Identify update .sql files that haven't been run, and run them
  all_sql_files=`cd schema/updates && ls *.sql && cd ../..`

  done_sql_files=`mysql --defaults-file=.my.cnf -D $db --skip-column-names --silent --raw -e "SELECT scriptName FROM SchemaStatus WHERE schemaStatus = 'DONE' ORDER BY recordTimeStamp;"`

  arr=()
  while read -r sql_file; do
    contains "$done_sql_files" "$sql_file"
    if [[ $? -ne 0 ]]
    then
      arr+=("$sql_file")
      mysql --defaults-file=.my.cnf -D $db < schema/updates/$sql_file
    fi
  done <<< "$all_sql_files"

  if [ -n "$arr" ]; then
    echo "The following schema/updates/*.sql files were sourced:"
    for val in "${arr[@]}"; do
      echo "$val"
    done
  else
    echo "No new schema/updates/*.sql files."
  fi

  # Generate table and sproc documentation
  if [ -d "bin" ] && [ -d "docs" ]; then
    cd bin
    ./db_procs_to_rst.sh $db > ../docs/list_of_procs.rst
    ./db_tables_to_rst.sh $db > ../docs/list_of_tables_and_columns.rst
    cd ..
  fi

fi
