#!/bin/sh

# This script removes details about laboratories on a particular proposal
# and session.
# Usage:
# pii_forget_labs_on_proposal_and_session.sh <.cnf file> <db_name> <proposalCode><proposalNumber> <session number>
# Usage example:
# pii_forget_labs_on_proposal_and_session.sh ~/.my.cnf ispyb cm12345 2
# Author: Karl Levik
# Date: 2020-03-04

HOST=localhost
MYCNF=$1
DB=$2
PROPOSAL=$3
SESSNUM=$4

PID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`
SID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`
PERSID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT personId FROM Proposal WHERE proposalId=${PID};"`
LABID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT laboratoryId FROM Person WHERE personId=${PERSID};"`

LABIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "SELECT laboratoryId FROM Laboratory WHERE laboratoryId=${LABID}   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN LabContact lc USING(personId) WHERE lc.proposalId=${PID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN Session_has_Person shp USING(personId) WHERE shp.sessionId=${SID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN ProposalHasPerson php USING(personId) WHERE php.proposalId=${PID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId WHERE c.sessionId=${SID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   laboratoryId IN (SELECT pe.laboratoryId FROM Person pe INNER JOIN Container c ON c.ownerId=pe.personId INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR  laboratoryId IN (SELECT pe.laboratoryId FROM Person pe INNER JOIN Shipping s ON pe.personId=s.deliveryAgent_flightCodePersonId WHERE s.proposalId=${PID})"`

while read -r LABID; do
  `./pii_forget_lab.sh ${MYCNF} ${DB} ${LABID}`
done <<< "${LABIDS}"
