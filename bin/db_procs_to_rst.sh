#!/usr/bin/env bash

db=$1

file=$(mktemp /tmp/tsv.XXXXXX)

# Execute the sql to generate the csv outfile
mariadb --defaults-file=../.my.cnf --skip-column-names --batch --raw -D $db < sql/db_procs_to_tsv.sql  > ${file}

# Construct rst file with csv table
echo ".. csv-table:: Procedure signatures with comments"
echo '   :header: "Name", "Params", "Users/roles", "Comment"'
echo "   :widths: 20, 30, 10, 40"
echo ""

while read p; do
  echo "   $p"
done <$file

rm ${file}
