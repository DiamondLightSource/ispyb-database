#!/usr/bin/env bash

# Script to create the database from the schema .sql files and identify any
# update .sql files that haven't been run. Also generate documentation from
# inline comments in the schema.

# Some code borrowed from Stefan Buck's gist file at:
# https://gist.github.com/stefanbuck/ce788fee19ab6eb0b4447a85fc99f447

# Author: Karl Levik

source bin/functions.sh

if [ -z "${DB}" ]
then
  DB="ispyb_build"
fi

echo "Dropping + creating build database"
mysql --defaults-file=.my.cnf -e "DROP DATABASE IF EXISTS $DB; CREATE DATABASE $DB; SET GLOBAL log_bin_trust_function_creators=ON;"

if [[ $? -eq 0 ]]
then
  mysql --defaults-file=.my.cnf -D $DB < schemas/ispyb/tables.sql
  mysql --defaults-file=.my.cnf -D $DB < schemas/ispyb/lookups.sql
  mysql --defaults-file=.my.cnf -D $DB < schemas/ispyb/data.sql
  mysql --defaults-file=.my.cnf -D $DB < schemas/ispyb/routines.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_acquisition.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_import.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_processing.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_ro_nopii.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_scripts_processing.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_touchscreen.sql
  mysql --defaults-file=.my.cnf -D $DB < grants/ispyb_web.sql

  arr=$(bin/missed_updates.sh)

  if [ -n "$arr" ]; then
    echo "Running schemas/ispyb/updates/*.sql files that haven't yet been run:"
    for sql_file in ${arr[@]}; do
      echo "$sql_file"
      mysql --defaults-file=.my.cnf -D ${DB} < "schemas/ispyb/updates/${sql_file}"
    done
  else
    echo "No new schemas/ispyb/updates/*.sql files."
  fi

  # Generate table and sproc documentation
  if ! hash pandoc 2>/dev/null; then
    echo "'pandoc' was not found in PATH"
  elif [ -d "bin" ]; then
    cd bin
    ./db_procs_to_rst.sh $DB > /tmp/list_of_procs.rst
    pandoc -o /tmp/list_of_procs.html /tmp/list_of_procs.rst
    ./db_tables_to_rst.sh $DB > /tmp/list_of_tables_and_columns.rst
    pandoc -o /tmp/list_of_tables_and_columns.html /tmp/list_of_tables_and_columns.rst
    echo "HTML documentation written to files in /tmp/"
    cd ..
  fi

fi
