#!/bin/bash

# Script to create the database from the schema .sql files and identify any
# update .sql files that haven't been run. Also generate documentation from
# inline comments in the schema.

# Author: Karl Levik

function contains() {
    [[ $1 =~ (^|[[:space:]])"$2"($|[[:space:]]) ]] && return 0 || return 1
}

db="tempdb_"`date +%Y%m%d_%H%M%S`

mysql --defaults-file=.my.cnf -e "CREATE DATABASE $db; SET GLOBAL log_bin_trust_function_creators=ON;"

if [[ $? -eq 0 ]]
then
  mysql --defaults-file=.my.cnf -D $db < schema/tables.sql
  mysql --defaults-file=.my.cnf -D $db < schema/data.sql
  mysql --defaults-file=.my.cnf -D $db < schema/routines.sql

  # Verify that all update .sql files have been run, if not exit with message
  all_sql_files=`cd schema/updates && ls *.sql && cd ../..`

  done_sql_files=`mysql --defaults-file=.my.cnf -D $db --skip-column-names --silent --raw -e "SELECT scriptName FROM SchemaStatus WHERE schemaStatus = 'DONE' ORDER BY recordTimeStamp;"`

  arr=()
  while read -r sql_file; do
    contains "$done_sql_files" "$sql_file"
    if [[ $? -ne 0 ]]
    then
      arr+=("$sql_file\n")
    fi
  done <<< "$all_sql_files"

  if [ -n "$arr" ]; then
    echo "These .sql files appear not to have been run yet:"
    echo ${arr[@]}
    exit 1
  fi
  echo "All .sql files appear to have been run."

  # Generate table and sproc documentation
  cd bin
  ./db_procs_to_rst.sh $db > ../doc/list_of_procs.rst
  ./db_tables_to_rst.sh $db > ../doc/list_of_tables_and_columns.rst
  cd ..

  # Clean up
  mysql --defaults-file=.my.cnf -e "DROP DATABASE $db;"
fi
