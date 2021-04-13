#!/usr/bin/env bash

db=$1
mysql --defaults-file=../.my.cnf -D $db --skip-column-names --batch --raw < sql/db_tables_to_tsv.sql > /tmp/tmp1.tsv
sed -i 's/\t/,/g' /tmp/tmp1.tsv

echo ".. csv-table:: Tables, columns and comments"
echo '   :header: "Name", "Type", "Comment"'
echo "   :widths: 20, 10, 50"
echo ""

while read p; do
  echo "   $p"
done </tmp/tmp1.tsv
