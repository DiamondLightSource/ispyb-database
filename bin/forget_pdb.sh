#!/usr/bin/env bash

# This script removes information for a particular PDB.
#
# Usage:
# ./forget_pdb.sh <.cnf file> <db_name> <proteinId>
#
# Usage example:
# ./forget_pdb.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-05-13

HOST=localhost
MYCNF=$1
DB=$2
PDBID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE PDB SET name=pdbId, contents=NULL, code=NULL WHERE pdbId=${PDBID};"
