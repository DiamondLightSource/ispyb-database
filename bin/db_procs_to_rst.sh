#!/bin/bash

db=$1
mysql --defaults-file=../.my.cnf -D $db --skip-column-names --batch --raw < sql/db_procs_to_tsv.sql > /tmp/tmp2.tsv
sed -i 's/\t/,/g' /tmp/tmp2.tsv

echo ".. csv-table:: Procedure signatures with comments"
echo '   :header: "Name", "Params", "Comment", "Modified"'
echo "   :widths: 20, 30, 50, 20"
echo ""

while read p; do
  echo "   $p"
done </tmp/tmp2.tsv
