#!/usr/bin/env bash

# This script removes information for a particular sub-sample (BLSubSample).
#
# Usage:
# ./forget_subsample.sh <.cnf file> <db_name> <blSampleId>
#
# Usage example:
# ./forget_subsample.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-04-30

HOST=localhost
MYCNF=$1
DB=$2
BLSUBSAMPLEID=$3

mariadb --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE BLSubSample SET comments=NULL WHERE blSubSampleId='${BLSUBSAMPLEID}';"
