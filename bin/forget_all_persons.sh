#!/usr/bin/env bash

# Caution: This script attempts to remove all Personally Identifiable
# Information (PII) in the given ispyb database for the given proposal
# and session.
#
# Usage:
# forget_all_persons.sh <.cnf file> <db_name> <proposalCode><proposalNumber> <session number>
#
# Usage example:
# ./forget_all_persons.sh ~/.my.cnf ispyb cm12345 2
#
# Author: Karl Levik
# Date: 2020-03-09

HOST=localhost
MYCNF=$1
DB=$2
PROPOSAL=$3
SESSNUM=$4

# Get the proposal PID and the session SID:

PID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`
SID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`

# Get all personIds related to the PID and SID
PERSIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "SELECT personId FROM Proposal WHERE proposalId=${PID} UNION SELECT personId FROM Person WHERE personId IN (SELECT personId FROM LabContact WHERE proposalId=${PID})   OR   personId IN (SELECT personId FROM Session_has_Person WHERE sessionId=${SID})   OR   personId IN (SELECT personId FROM ProposalHasPerson WHERE proposalId=${PID})   OR   personId IN (SELECT ownerId FROM Container WHERE sessionId=${SID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   personId IN (SELECT s.deliveryAgent_flightCodePersonId FROM Shipping s WHERE s.proposalId=${PID});"`

# iterate over and forget:

while read -r PERSID; do
  `./forget_person.sh ${MYCNF} ${DB} ${PERSID}`
done <<< "${PERSIDS}"
