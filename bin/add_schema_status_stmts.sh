#!/usr/bin/env bash

fname=$(basename ${1})

sql=$(<${1})
echo "INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('${fname}', 'ONGOING');" > ${1}
echo >> ${1}
echo "${sql}" >> ${1}
echo >> ${1}
echo "UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '${fname}';" >> ${1}
