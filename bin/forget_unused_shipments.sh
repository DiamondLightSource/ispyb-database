#!/bin/sh

# This script removes all descriptive information related to shipments for
# a particular proposal, except that related to samples on which data was
# collected in a given session. This includes information for proteins, PDBs,
# samples and so on.
#
# Usage:
# ./forget_unused_shipment.sh <.cnf file> <db_name> <proposalCode><prposalNumber> <session number>
#
# Usage example:
# ./forget_unused_shipment.sh ~/.my.cnf ispyb cm12345 2
#
# Author: Karl Levik
# Date: 2020-04-30

HOST=localhost
MYCNF=$1
DB=$2
PROPOSAL=$3
SESSNUM=$4

# Get the proposal PID:

PID=`mysql --defaults-file=${MYCNF} -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`

SID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`

# Query to find all shippingIds of all used samples and sub-samples
# on the session. Beware of NULLs!

SHIPPINGID_USED_SELECT="-- SHIPPINGID_USED_SELECT
SELECT DISTINCT ifnull(d.shippingId, 0)
FROM Dewar d
  JOIN Container USING(dewarId)
  JOIN BLSample bls USING(containerId)
WHERE bls.blSampleId IN (
  SELECT ifnull(blSampleId, 0) FROM DataCollectionGroup WHERE sessionId=${SID}   UNION   SELECT ifnull(blSampleId, 0) FROM EnergyScan WHERE sessionId=${SID}   UNION   SELECT ifnull(blSampleId, 0) FROM XFEFluorescenceSpectrum WHERE sessionId=${SID}
)
UNION
SELECT DISTINCT ifnull(d.shippingId, 0)
FROM Dewar d
  JOIN Container USING(dewarId)
  JOIN BLSample bls USING(containerId)
  JOIN BLSubSample blss USING(blSampleId)
WHERE blss.blSubSampleId IN (
  SELECT ifnull(blSubSampleId, 0) FROM DataCollection JOIN DataCollectionGroup dcg USING(dataCollectionGroupId)  WHERE dcg.sessionId=${SID}   UNION   SELECT ifnull(blSubSampleId, 0) FROM EnergyScan WHERE sessionId=${SID}   UNION   SELECT ifnull(blSubSampleId, 0) FROM XFEFluorescenceSpectrum WHERE sessionId=${SID}
)
-- -- --
"

# Query to find all unused shippings on the proposal

SHIPPINGID_UNUSED_SELECT="SELECT DISTINCT s.shippingId
FROM Shipping s
  LEFT JOIN Dewar USING(shippingId)
  LEFT JOIN Container USING(dewarId)
  LEFT JOIN BLSample bls USING(containerId)
WHERE s.proposalId=${PID} AND bls.blSampleId IS NULL
UNION
SELECT DISTINCT s.shippingId
FROM Shipping s
  JOIN Dewar USING(shippingId)
  JOIN Container USING(dewarId)
  JOIN BLSample bls USING(containerId)
  LEFT JOIN BLSubSample blss USING(blSampleId)
WHERE s.proposalId=${PID}
  AND s.shippingId NOT IN (
    ${SHIPPINGID_USED_SELECT}
  )"

SHIPPINGIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "${SHIPPINGID_UNUSED_SELECT};"`

# Iterate over shippings and forget:

while read -r SHIPPINGID; do
  `./forget_shipping.sh ${MYCNF} ${DB} ${SHIPPINGID}`
done <<< "${SHIPPINGIDS}"

# Query to find all unused samples on the proposal

BLSAMPLE_UNUSED_SELECT="SELECT q1.blSampleId
FROM (
  SELECT bls.blSampleId, count(dcg.blSampleId) cnt1, count(es.blSampleId) cnt2, count(xfefs.blSampleId) cnt3
  FROM BLSample bls
    JOIN Crystal USING(crystalId)
    JOIN Protein p USING(proteinId)
    LEFT JOIN DataCollectionGroup dcg USING(blSampleId)
    LEFT JOIN EnergyScan es USING(blSampleId)
    LEFT JOIN XFEFluorescenceSpectrum xfefs USING(blSampleId)
  WHERE p.proposalId=${PID}
  GROUP BY bls.blSampleId) q1
WHERE q1.cnt1=0 AND q1.cnt2=0 AND q1.cnt3=0"

BLSAMPLEIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "${BLSAMPLE_UNUSED_SELECT};"`

# Iterate over samples and forget:

while read -r BLSAMPLEID; do
  `./forget_sample.sh ${MYCNF} ${DB} ${BLSAMPLEID}`
done <<< "${BLSAMPLEIDS}"

# Query to find all unused sub-samples on the proposal

BLSUBSAMPLE_UNUSED_SELECT="SELECT q2.blSubSampleId
FROM (
  SELECT blss.blSubSampleId, count(dc.blSubSampleId) cnt1, count(es.blSubSampleId) cnt2, count(xfefs.blSubSampleId) cnt3
  FROM BLSubSample blss
  JOIN BLSample USING(blSampleId)
  JOIN Crystal USING(crystalId)
  JOIN Protein p USING(proteinId)
  LEFT JOIN DataCollection dc ON dc.blSubSampleId=blss.blSubSampleId
  LEFT JOIN EnergyScan es ON es.blSubSampleId=blss.blSubSampleId
  LEFT JOIN XFEFluorescenceSpectrum xfefs ON xfefs.blSubSampleId=blss.blSubSampleId
  WHERE p.proposalId=${PID}
  GROUP BY blss.blSubSampleId) q2
WHERE q2.cnt1=0 AND q2.cnt2=0 AND q2.cnt3=0"

BLSUBSAMPLEIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "${BLSUBSAMPLE_UNUSED_SELECT};"`

# Iterate over sub-samples and forget:

while read -r BLSUBSAMPLEID; do
  `./forget_subsample.sh ${MYCNF} ${DB} ${BLSUBSAMPLEID}`
done <<< "${BLSUBSAMPLEIDS}"

# Query to find all unused proteins on the proposal

PROTEINIDS=`mysql --defaults-file=${MYCNF} -D ${DB} --skip-column-names --silent --raw -e "SELECT p.proteinId
FROM Protein p
  LEFT JOIN Crystal c USING(proteinId)
  LEFT JOIN BLSample bls USING(crystalId)
  LEFT JOIN BLSubSample blss USING(blSampleId)
  WHERE p.proposalId=${PID} AND (
    bls.blSampleId IS NULL OR bls.blSampleId IN (${BLSAMPLE_UNUSED_SELECT})
  ) AND (
    blss.blSubSampleId IS NULL OR
    blss.blSubSampleId IN (${BLSUBSAMPLE_UNUSED_SELECT})
  );"`

# Iterate over proteins and forget:

while read -r PROTEINID; do
  `./forget_protein.sh ${MYCNF} ${DB} ${PROTEINID}`
done <<< "${PROTEINIDS}"
