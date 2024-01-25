#!/usr/bin/env bash

db=$1

file=$(mktemp /tmp/tsv.XXXXXX)

mariadb --defaults-file=../.my.cnf -D $db --skip-column-names --batch --raw < sql/db_tables_to_tsv.sql > ${file}
sed -i 's/\t/,/g' ${file}

echo ".. csv-table:: Tables, columns and comments"
echo '   :header: "Name", "Type", "Comment"'
echo "   :widths: 20, 10, 50"
echo ""

while read p; do
  echo "   $p"
done <${file}

rm ${file}
