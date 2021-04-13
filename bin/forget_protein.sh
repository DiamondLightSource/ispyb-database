#!/usr/bin/env bash

# This script removes information for a particular protein.
#
# Usage:
# ./forget_protein.sh <.cnf file> <db_name> <proteinId>
#
# Usage example:
# ./forget_protein.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-04-30

HOST=localhost
MYCNF=$1
DB=$2
PROTEINID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE Protein SET name='prot-${PROTEINID}', acronym='prot-${PROTEINID}', safetyLevel='GREEN', molecularMass=NULL, proteinType=NULL, sequence=NULL, componentTypeId=NULL, concentrationTypeId=NULL, externalId=NULL, density=NULL, abundance=NULL WHERE proteinId=${PROTEINID};"
