#!/bin/bash

sql=$(<${1})
echo "INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('${1}', 'ONGOING');" > ${1}
echo >> ${1}
echo ${sql} >> ${1}
echo >> ${1}
echo "UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '${1}';" >> ${1}
