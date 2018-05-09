#!/bin/bash

db=$1
mysql $db --skip-column-names --batch --raw < generate_tables_doc.sql > /tmp/tmp1.log
sed -i 's/\t/,/g' /tmp/tmp1.log

echo ".. csv-table:: Tables, columns and comments"
echo '   :header: "Name", "Type", "Comment"'
echo "   :widths: 20, 10, 50"
echo ""

while read p; do
  echo "   $p"
done </tmp/tmp1.log
