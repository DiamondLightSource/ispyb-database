#!/bin/bash

# This script removes Personally Identifiable Information (PII) for a particular person.
#
# Usage:
# ./forget_person.sh <.cnf file> <db_name> <personId>
#
# Usage example:
# ./forget_person.sh ~/.my.cnf ispyb 21414
#
# Author: Karl Levik
# Date: 2020-03-04

HOST=localhost
MYCNF=$1
DB=$2
PERSONID=$3

mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE Person SET familyName='Doe', givenName='John', title=NULL, emailAddress='hello@example.com', phoneNumber=NULL, login='john-${PERSONID}', faxNumber=NULL, cache=NULL, externalId=NULL WHERE personId='${PERSONID}';"
mysql --defaults-file=${MYCNF} -s -D ${DB} -e "UPDATE LabContact SET cardName=concat('Doe', labContactId), defaultCourrierCompany='Doe', courierAccount='12345', billingReference=NULL, dewarAvgCustomsValue=0, dewarAvgTransportValue=0 WHERE personId='${PERSONID}';"
