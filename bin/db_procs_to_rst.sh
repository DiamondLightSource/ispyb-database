#!/usr/bin/env bash

db=$1

file=$(mktemp /tmp/tsv.XXXXXX)

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

rm ${file}
