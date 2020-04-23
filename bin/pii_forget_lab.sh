#!/bin/sh

# This script removes details about a particular laboratory.
# Usage:
# pii_forget_lab.sh <.cnf file> <db_name> <laboratoryId>
# Usage example:
# pii_forget_lab.sh ~/.my.cnf ispyb 21414
# Author: Karl Levik
# Date: 2020-03-12

HOST=localhost
MYCNF=$1
DB=$2
LABID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE Laboratory SET name='lab-${LABID}', laboratoryUUID=NULL, city=NULL, address=NULL, country=NULL, url=NULL, organization=NULL, laboratoryPk=NULL, postcode=NULL WHERE laboratoryId=${LABID};"
