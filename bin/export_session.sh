#!/bin/sh

# Usage:
# export_session <db_name> <proposalCode><proposalNumber> <session number> <output dir>
# Usage example:
# export_proposal.sh ispyb cm14451 2 /tmp/cm14451
# Author: Karl Levik
# Date: 20200214


HOST=localhost
DB=$1
PROPOSAL=$2
SESSNUM=$3
OUT_DIR=$4

rm -f -r -d ${OUT_DIR}
mkdir -p ${OUT_DIR}

OPTIONS="--defaults-file=../.my.cnf --add-drop-table --create-options --disable-keys --extended-insert --skip-add-locks --quick --set-charset --single-transaction --max_allowed_packet=1G --skip-triggers --no-create-info --complete-insert --host=${HOST} --port=3306 --default-character-set=utf8 ${DB}"

# Global level data

mysqldump ${OPTIONS} Detector Imager ComponentType ComponentSubType InspectionType SpaceGroup v_run UserGroup Permission UserGroup_has_Permission Schedule ScheduleComponent ScanParametersService ScanParametersModel > ${OUT_DIR}/${DB}_global.sql


# Proposal level data

PID=`mysql -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`

PERSID=`mysql -s -D ${DB} -e "SELECT personId FROM Proposal WHERE proposalId=${PID};"`

LABID=`mysql -s -D ${DB} -e "SELECT laboratoryId FROM Person WHERE personId=${PERSID};"`

mysqldump ${OPTIONS} --where="laboratoryId=${LABID}" Laboratory > ${OUT_DIR}/${DB}_Laboratory.sql

mysqldump ${OPTIONS} --where="personId=${PERSID}" Person > ${OUT_DIR}/${DB}_Person.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Proposal > ${OUT_DIR}/${DB}_Proposal.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Protein > ${OUT_DIR}/${DB}_Protein.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Screen > ${OUT_DIR}/${DB}_Screen.sql

mysqldump ${OPTIONS} --where="proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Crystal > ${OUT_DIR}/${DB}_Crystal.sql

mysqldump ${OPTIONS} --where="crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}))" BLSample > ${OUT_DIR}/${DB}_BLSample.sql

mysqldump ${OPTIONS} --where="blSampleId IN (SELECT blSampleId FROM BLSample WHERE crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})))" BLSubSample > ${OUT_DIR}/${DB}_BLSubSample.sql

# BLSubSample.positionId
mysqldump ${OPTIONS} --where="positionId IN (SELECT positionId FROM BLSubSample WHERE blSampleId IN (SELECT blSampleId FROM BLSample WHERE crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}))))" Position > ${OUT_DIR}/${DB}_Position1.sql

# BLSubSample.position2Id
mysqldump ${OPTIONS} --where="positionId IN (SELECT position2Id Id FROM BLSubSample WHERE blSampleId IN (SELECT blSampleId FROM BLSample WHERE crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}))))" Position > ${OUT_DIR}/${DB}_Position1.sql

mysqldump ${OPTIONS} --where="diffractionPlanId IN (SELECT diffractionPlanId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}))" DiffractionPlan > ${OUT_DIR}/${DB}_DiffractionPlan1.sql

mysqldump ${OPTIONS} --where="diffractionPlanId IN (SELECT diffractionPlanId FROM BLSample WHERE crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})))" DiffractionPlan > ${OUT_DIR}/${DB}_DiffractionPlan2.sql

mysqldump ${OPTIONS} --where="diffractionPlanId IN (SELECT diffractionPlanId FROM BLSubSample WHERE blSampleId IN (SELECT blSampleId FROM BLSample WHERE crystalId IN (SELECT crystalId FROM Crystal WHERE proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}))))" DiffractionPlan > ${OUT_DIR}/${DB}_DiffractionPlan3.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" ProposalHasPerson > ${OUT_DIR}/${DB}_ProposalHasPerson.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Shipping > ${OUT_DIR}/${DB}_Shipping.sql

mysqldump ${OPTIONS} --where="shippingId IN (SELECT shippingId FROM Shipping WHERE proposalId=${PID})" Dewar > ${OUT_DIR}/${DB}_Dewar.sql

mysqldump ${OPTIONS} --where="dewarId IN (SELECT dewarId FROM Dewar WHERE shippingId IN (SELECT shippingId FROM Shipping WHERE proposalId=${PID}))" Container > ${OUT_DIR}/${DB}_Container1.sql


# Session level data

SID=`mysql -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`

mysqldump ${OPTIONS} --where="sessionId=${SID}" BLSession > ${OUT_DIR}/${DB}_BLSession.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" SessionType > ${OUT_DIR}/${DB}_SessionType.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" DataCollectionGroup > ${OUT_DIR}/${DB}_DataCollectionGroup.sql

mysqldump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})" DataCollection > ${OUT_DIR}/${DB}_DataCollection.sql

mysqldump ${OPTIONS} --where="positionId IN (SELECT positionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" Position > ${OUT_DIR}/${DB}_Position3.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" XFEFluorescenceSpectrum > ${OUT_DIR}/${DB}_XFEFluorescenceSpectrum.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" EnergyScan > ${OUT_DIR}/${DB}_EnergyScan.sql

mysqldump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}) OR dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" Screening > ${OUT_DIR}/${DB}_Screening.sql

mysqldump ${OPTIONS} --where="personId IN (SELECT personId FROM Session_has_Person WHERE sessionId=${SID})" Person > ${OUT_DIR}/${DB}_Person2.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" Session_has_Person > ${OUT_DIR}/${DB}_Session_has_Person.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" Container > ${OUT_DIR}/${DB}_Container2.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" ImageQualityIndicators > ${OUT_DIR}/${DB}_ImageQualityIndicators.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" DataCollectionComment > ${OUT_DIR}/${DB}_DataCollectionComment.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" DataCollectionFileAttachment > ${OUT_DIR}/${DB}_DataCollectionFileAttachment.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" AutoProcIntegration > ${OUT_DIR}/${DB}_AutoProcIntegration.sql

mysqldump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcStatus > ${OUT_DIR}/${DB}_AutoProcStatus.sql

mysqldump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcScaling_has_Int > ${OUT_DIR}/${DB}_AutoProcScaling_has_Int.sql

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT autoProcScalingId FROM AutoProcScaling_has_Int WHERE autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))))" AutoProcScaling > ${OUT_DIR}/${DB}_AutoProcScaling.sql

mysqldump ${OPTIONS} --where="autoProcId IN (SELECT autoProcId FROM AutoProcScaling WHERE autoProcScalingId IN (SELECT autoProcScalingId FROM AutoProcScaling_has_Int WHERE autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))))" AutoProc > ${OUT_DIR}/${DB}_AutoProc.sql

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT autoProcScalingId FROM AutoProcScaling_has_Int WHERE autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))))" AutoProcScalingStatistics > ${OUT_DIR}/${DB}_AutoProcScalingStatistics.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram1.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment1.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage1.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram2.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment2.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage2.sql


# TODO:
# Screening tables
# Phasing tables
# MXMRRun tables
