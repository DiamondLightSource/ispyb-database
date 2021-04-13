#!/usr/bin/env bash

# This script removes information for a particular sample (BLSample).
#
# Usage:
# ./forget_sample.sh <.cnf file> <db_name> <blSampleId>
#
# Usage example:
# ./forget_sample.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-04-30

HOST=localhost
MYCNF=$1
DB=$2
BLSAMPLEID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE BLSample SET name='s-${BLSAMPLEID}', code='c-${BLSAMPLEID}', comments=NULL WHERE blSampleId='${BLSAMPLEID}';"
