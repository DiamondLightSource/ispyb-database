#!/bin/bash

db=$1

# find the highest number, increase by one, use that
file=/tmp/procs-001.csv
if [ -f ${file} ]; then
  LAST=`exec ls /tmp/procs-*.csv | sed 's/\/tmp\/procs-\([0-9]\+\)\.csv/\1/g' | sort -n | tail -1`
  file=$(printf "/tmp/procs-%03d" `expr 1 + $LAST`).csv
fi

# Substitute $file with its value in the sql file
sql=$(env file=${file} envsubst < sql/db_procs_to_tsv.sql)

# Execute the sql to generate the csv outfile
mysql --defaults-file=../.my.cnf --skip-column-names --batch --raw -D $db -e "${sql}" > ${file}

# Construct rst file with csv table
echo ".. csv-table:: Procedure signatures with comments"
echo '   :header: "Name", "Params", "Comment"'
echo "   :widths: 20, 30, 50"
echo ""

while read p; do
  echo "   $p"
done <$file
