#!/bin/sh

# This script removes information for a particular shipping.
#
# Usage:
# ./forget_shipping.sh <.cnf file> <db_name> <shippingId>
#
# Usage example:
# ./forget_shipping.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-04-30

HOST=localhost
MYCNF=$1
DB=$2
SHIPPINGID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE Shipping SET shippingName='s-${SHIPPINGID}', comments=NULL, SAFETYLEVEL=NULL, deliveryAgent_agentCode=NULL, deliveryAgent_flightCode=NULL, deliveryAgent_label=NULL, deliveryAgent_productcode=NULL WHERE shippingId='${SHIPPINGID}';"
