#!/usr/bin/env bash

# Usage:
# export_session.sh [-t|-s|-v] <proposalCode><proposalNumber> <session number> <output dir>
# -t: Process tomography tables
# -s: Process single particle analysis tables
# -v: Verbose output (prints all commands ran)
# Usage example:
# export_session.sh cm14451 2 /tmp/cm14451-2
# Author: Karl Levik
# Date: 2023-03-28

USE_TOMO=0
USE_SPA=0

while getopts 'tsv' OPTION; do
  case "$OPTION" in
    t)
      USE_TOMO=1
      ;;

    s)
      USE_SPA=1
      ;;

    v)
      set -x
      ;;
  esac
done

shift "$(($OPTIND -1))"

MYCNF=../.my.cnf
PROPOSAL=$1
SESSNUM=$2
OUT_DIR=$3

if [ -z "${DB}" ]
then
  DB="ispyb_build"
fi


GLOBALS_FILE=globals_data.sql
PROPOSAL_DIR=${OUT_DIR}/proposal
PROPOSAL_FILE=proposal_data.sql
SESSION_DIR=${OUT_DIR}/session
SESSION_FILE=session_data.sql

PID=`mariadb --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`

SID=`mariadb --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`

PERSID=`mariadb --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT personId FROM Proposal WHERE proposalId=${PID};"`

LABID=`mariadb --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT laboratoryId FROM Person WHERE personId=${PERSID};"`

if [ -d "${OUT_DIR}" ]
then
  rm -f -r -I -d ${OUT_DIR}
fi
mkdir -p ${OUT_DIR}/proposal
mkdir -p ${OUT_DIR}/session

OPTIONS="--defaults-file=${MYCNF} --add-drop-table --create-options --disable-keys --skip-add-locks --quick --set-charset --single-transaction --max_allowed_packet=1G --skip-triggers --no-create-info --complete-insert --default-character-set=utf8 ${DB}"

# Global level data

source lookup_tables.sh

mariadb-dump ${OPTIONS} ${LOOKUP_TABLES_STRING} v_run BeamLineSetup | grep 'INSERT INTO' > ${OUT_DIR}/${GLOBALS_FILE}

# Proposal level data

mariadb-dump ${OPTIONS} --where="diffractionPlanId IN (SELECT dataCollectionPlanId FROM ScanParametersModel)" DiffractionPlan > ${PROPOSAL_DIR}/DiffractionPlan0.sql

mariadb-dump ${OPTIONS} ScanParametersModel > ${PROPOSAL_DIR}/ScanParametersModel.sql

mariadb-dump ${OPTIONS} --where="laboratoryId=${LABID}   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN LabContact lc USING(personId) WHERE lc.proposalId=${PID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN Session_has_Person shp USING(personId) WHERE shp.sessionId=${SID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN ProposalHasPerson php USING(personId) WHERE php.proposalId=${PID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId WHERE c.sessionId=${SID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   laboratoryId IN (SELECT pe.laboratoryId FROM Person pe INNER JOIN Container c ON c.ownerId=pe.personId INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR  laboratoryId IN (SELECT pe.laboratoryId FROM Person pe INNER JOIN Shipping s ON pe.personId=s.deliveryAgent_flightCodePersonId WHERE s.proposalId=${PID}   UNION   SELECT pe.laboratoryId FROM Person pe JOIN LabContact lc USING(personId) WHERE lc.labContactId IN (SELECT  sendingLabContactId FROM Shipping WHERE proposalId=${PID}   UNION   SELECT returnLabContactId FROM Shipping WHERE proposalId=${PID}))" Laboratory > ${PROPOSAL_DIR}/Laboratory.sql

mariadb-dump ${OPTIONS} --where="personId=${PERSID}   OR   personId IN (SELECT personId FROM LabContact WHERE proposalId=${PID})   OR   personId IN (SELECT personId FROM Session_has_Person WHERE sessionId=${SID})   OR   personId IN (SELECT personId FROM ProposalHasPerson WHERE proposalId=${PID})   OR   personId IN (SELECT ownerId FROM Container WHERE sessionId=${SID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   personId IN (SELECT s.deliveryAgent_flightCodePersonId FROM Shipping s WHERE s.proposalId=${PID}   UNION   SELECT personId FROM LabContact WHERE labContactId IN (SELECT  sendingLabContactId FROM Shipping WHERE proposalId=${PID}   UNION   SELECT returnLabContactId FROM Shipping WHERE proposalId=${PID}))" Person > ${PROPOSAL_DIR}/Person.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID}" Proposal > ${PROPOSAL_DIR}/Proposal.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" BLSession > ${PROPOSAL_DIR}/BLSession.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID} OR labContactId IN (SELECT  sendingLabContactId FROM Shipping WHERE proposalId=${PID}   UNION   SELECT returnLabContactId FROM Shipping WHERE proposalId=${PID})" LabContact > ${PROPOSAL_DIR}/LabContact.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID}" Protein > ${PROPOSAL_DIR}/Protein.sql

mariadb-dump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" ComponentLattice > ${PROPOSAL_DIR}/ComponentLattice.sql

mariadb-dump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Component_has_SubType > ${PROPOSAL_DIR}/Component_has_SubType.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID} OR \`global\`>0" Screen > ${PROPOSAL_DIR}/Screen.sql

mariadb-dump ${OPTIONS} --where="proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Crystal > ${PROPOSAL_DIR}/Crystal.sql

mariadb-dump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}) AND blSampleTypeId IN (SELECT crystalId FROM Crystal c INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" BLSampleType_has_Component > ${PROPOSAL_DIR}/BLSampleType_has_Component.sql

mariadb-dump ${OPTIONS} --where="pdbId IN (SELECT pdbId FROM PDB INNER JOIN Protein_has_PDB php USING(pdbId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" PDB > ${PROPOSAL_DIR}/PDB.sql

mariadb-dump ${OPTIONS} --where="proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Protein_has_PDB > ${PROPOSAL_DIR}/Protein_has_PDB.sql

mariadb-dump ${OPTIONS} --where="screenId IN (SELECT s.screenId FROM Screen s WHERE s.proposalId=${PID} OR s.global>0)" ScreenComponentGroup > ${PROPOSAL_DIR}/ScreenComponentGroup.sql

mariadb-dump ${OPTIONS} --where="screenComponentGroupId IN (SELECT scg.screenComponentGroupId FROM ScreenComponentGroup scg INNER JOIN Screen s USING(screenId) WHERE s.proposalId=${PID} OR s.global>0) AND componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" ScreenComponent > ${PROPOSAL_DIR}/ScreenComponent.sql

mariadb-dump ${OPTIONS} --where="positionId IN (SELECT positionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" Position > ${PROPOSAL_DIR}/Position1.sql

# BLSubSample.positionId
mariadb-dump ${OPTIONS} --where="positionId IN (SELECT blss.positionId FROM BLSubSample blss INNER JOIN BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR bls.containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))" Position > ${PROPOSAL_DIR}/Position2.sql

# BLSubSample.position2Id
mariadb-dump ${OPTIONS} --where="positionId IN (SELECT blss.position2Id FROM BLSubSample blss INNER JOIN BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR bls.containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))" Position > ${PROPOSAL_DIR}/Position3.sql

mariadb-dump ${OPTIONS} --where="diffractionPlanId IN (SELECT c.diffractionPlanId FROM Crystal c INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})
OR diffractionPlanId IN (SELECT bls.diffractionPlanId FROM BLSample bls INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR diffractionPlanId IN (SELECT blss.diffractionPlanId FROM BLSubSample blss INNER JOIN BLSample USING(blSampleId) INNER JOIN Crystal c USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" DiffractionPlan > ${PROPOSAL_DIR}/DiffractionPlan1.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID}" ProposalHasPerson > ${PROPOSAL_DIR}/ProposalHasPerson.sql

mariadb-dump ${OPTIONS} --where="proposalId=${PID}" Shipping > ${PROPOSAL_DIR}/Shipping.sql

mariadb-dump ${OPTIONS} --where="shippingId IN (SELECT shippingId FROM Shipping WHERE proposalId=${PID})" Dewar > ${PROPOSAL_DIR}/Dewar.sql

mariadb-dump ${OPTIONS} --where="containerRegistryId IN (SELECT c.containerRegistryId FROM Container c INNER JOIN Dewar USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})" ContainerRegistry > ${PROPOSAL_DIR}/ContainerRegistry1.sql


# Proposal/Session level data

mariadb-dump ${OPTIONS} --where="sessionId=${SID}   OR   dewarId IN (SELECT d.dewarId FROM Dewar d INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   containerId IN (SELECT bls.containerId FROM BLSample bls INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   containerId IN (SELECT containerId FROM BLSample INNER JOIN EnergyScan es USING(blSampleId) WHERE es.sessionId=${SID} UNION ALL SELECT containerId FROM BLSample INNER JOIN XFEFluorescenceSpectrum xfs USING(blSampleId) WHERE xfs.sessionId=${SID})" Container > ${PROPOSAL_DIR}/Container.sql

mariadb-dump ${OPTIONS} --where="crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   blSampleId IN (SELECT blSampleId FROM XFEFluorescenceSpectrum WHERE sessionId=${SID} UNION ALL SELECT blSampleId FROM EnergyScan WHERE sessionId=${SID})" BLSample > ${PROPOSAL_DIR}/BLSample1.sql

mariadb-dump ${OPTIONS} --where="blSampleId IN (SELECT bls.blSampleId FROM BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))   OR   blSubSampleId IN (SELECT blSubSampleId FROM XFEFluorescenceSpectrum WHERE sessionId=${SID})" BLSubSample > ${PROPOSAL_DIR}/BLSubSample.sql


# Session level data

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" SessionType > ${SESSION_DIR}/SessionType.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" DataCollectionGroup > ${SESSION_DIR}/DataCollectionGroup.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" ShippingHasSession > ${SESSION_DIR}/ShippingHasSession.sql

mariadb-dump ${OPTIONS} --where="apertureId IN (SELECT dc.apertureId FROM DataCollection dc INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Aperture > ${SESSION_DIR}/Aperture.sql

mariadb-dump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})" DataCollection > ${SESSION_DIR}/DataCollection.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" GridImageMap > ${SESSION_DIR}/GridImageMap.sql

mariadb-dump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})" GridInfo > ${SESSION_DIR}/GridInfo.sql

mariadb-dump ${OPTIONS} --where="gridInfoId IN (SELECT gi.gridInfoId FROM GridInfo gi INNER JOIN DataCollectionGroup dcg USING(datacollectionGroupId) WHERE dcg.sessionId=${SID})" XrayCentringResult > ${SESSION_DIR}/XrayCentringResult.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" XFEFluorescenceSpectrum > ${SESSION_DIR}/XFEFluorescenceSpectrum.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" EnergyScan > ${SESSION_DIR}/EnergyScan.sql

mariadb-dump ${OPTIONS} --where="sessionId=${SID}" Session_has_Person > ${SESSION_DIR}/Session_has_Person.sql

mariadb-dump ${OPTIONS} --where="containerRegistryId IN (SELECT c.containerRegistryId FROM Container c WHERE c.sessionId=${SID})" ContainerRegistry > ${SESSION_DIR}/ContainerRegistry2.sql

mariadb-dump ${OPTIONS} --where="blsessionId=${SID}" RobotAction > ${SESSION_DIR}/RobotAction.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ImageQualityIndicators > ${SESSION_DIR}/ImageQualityIndicators.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" DataCollectionComment > ${SESSION_DIR}/DataCollectionComment.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" DataCollectionFileAttachment > ${SESSION_DIR}/DataCollectionFileAttachment.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Movie > ${SESSION_DIR}/Movie.sql

if [ USE_TOMO ]; then
  mariadb-dump ${OPTIONS} --where="tomogramId IN (SELECT t.tomogramId FROM Tomogram t INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" TiltImageAlignment > ${SESSION_DIR}/TiltImageAlignment.sql

  mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Tomogram > ${SESSION_DIR}/Tomogram.sql
fi

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${SESSION_DIR}/AutoProcProgram3.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramAttachment > ${SESSION_DIR}/AutoProcProgramAttachment3.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramMessage > ${SESSION_DIR}/AutoProcProgramMessage3.sql

if [ USE_SPA ]; then
  mariadb-dump ${OPTIONS} --where="programId IN (SELECT app.autoProcProgramId FROM AutoProcProgram app INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING (dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ParticlePicker > ${SESSION_DIR}/ParticlePicker.sql

  mariadb-dump ${OPTIONS} --where="particlePickerId IN (SELECT pp.particlePickerId FROM ParticlePicker pp INNER JOIN AutoProcProgram app ON pp.programId=app.autoProcProgramId INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ParticleClassificationGroup > ${SESSION_DIR}/ParticleClassificationGroup.sql

  mariadb-dump ${OPTIONS} --where="particleClassificationGroupId IN (SELECT pcg.particleClassificationGroupId FROM ParticleClassificationGroup pcg INNER JOIN ParticlePicker pp USING(particlePickerId) INNER JOIN AutoProcProgram app ON pp.programId=app.autoProcProgramId INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ParticleClassification > ${SESSION_DIR}/ParticleClassification.sql

  mariadb-dump ${OPTIONS} --where="particleClassificationId IN (SELECT pc.particleClassificationId FROM ParticleClassification pc INNER JOIN ParticleClassificationGroup pcg USING(particleClassificationGroupId) INNER JOIN ParticlePicker pp USING(particlePickerId) INNER JOIN AutoProcProgram app ON pp.programId=app.autoProcProgramId INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ParticleClassification_has_CryoemInitialModel > ${SESSION_DIR}/ParticleClassification_has_CryoemInitialModel.sql

  mariadb-dump ${OPTIONS} --where="cryoemInitialModelId IN (SELECT pchceim.cryoemInitialModelId FROM ParticleClassification_has_CryoemInitialModel pchceim INNER JOIN ParticleClassification pc USING(particleClassificationId) INNER JOIN ParticleClassificationGroup pcg USING(particleClassificationGroupId) INNER JOIN ParticlePicker pp USING(particlePickerId) INNER JOIN AutoProcProgram app ON pp.programId=app.autoProcProgramId INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" CryoemInitialModel > ${SESSION_DIR}/CryoemInitialModel.sql

  mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT app.autoProcProgramId FROM AutoProcProgram app INNER JOIN ProcessingJob pj USING(processingJobId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" RelativeIceThickness > ${SESSION_DIR}/RelativeIceThickness.sql
fi

mariadb-dump ${OPTIONS} --where="movieId IN (SELECT m.movieId FROM Movie m INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MotionCorrection > ${SESSION_DIR}/MotionCorrection.sql

mariadb-dump ${OPTIONS} --where="motionCorrectionId IN (SELECT mc.motionCorrectionId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MotionCorrectionDrift > ${SESSION_DIR}/MotionCorrectionDrift.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${SESSION_DIR}/AutoProcProgram4.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramAttachment > ${SESSION_DIR}/AutoProcProgramAttachment4.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramMessage > ${SESSION_DIR}/AutoProcProgramMessage4.sql

mariadb-dump ${OPTIONS} --where="motionCorrectionId IN (SELECT mc.motionCorrectionId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" CTF > ${SESSION_DIR}/CTF.sql


mariadb-dump ${OPTIONS} --where="containerId IN (SELECT containerId FROM Container WHERE sessionId=${SID})" ContainerInspection > ${SESSION_DIR}/ContainerInspection.sql

mariadb-dump ${OPTIONS} --where="containerId IN (SELECT containerId FROM Container WHERE sessionId=${SID})" ContainerQueue > ${SESSION_DIR}/ContainerQueue.sql

mariadb-dump ${OPTIONS} --where="containerQueueId IN (SELECT cq.containerQueueId FROM ContainerQueue cq INNER JOIN Container c USING(containerId) WHERE c.sessionId=${SID})" ContainerQueueSample > ${SESSION_DIR}/ContainerQueueSample.sql


# ProcessingJob* and AutoProc* tables:

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJob > ${SESSION_DIR}/ProcessingJob.sql

mariadb-dump ${OPTIONS} --where="processingJobId IN (SELECT pj.processingJobId FROM ProcessingJob pj INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJobParameter > ${SESSION_DIR}/ProcessingJobParameter.sql

mariadb-dump ${OPTIONS} --where="processingJobId IN (SELECT pj.processingJobId FROM ProcessingJob pj INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJobImageSweep > ${SESSION_DIR}/ProcessingJobImageSweep.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgram > ${SESSION_DIR}/AutoProcProgram1.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${SESSION_DIR}/AutoProcProgramAttachment1.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${SESSION_DIR}/AutoProcProgramMessage1.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${SESSION_DIR}/AutoProcProgram2.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${SESSION_DIR}/AutoProcProgramAttachment2.sql

mariadb-dump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${SESSION_DIR}/AutoProcProgramMessage2.sql

mariadb-dump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcIntegration > ${SESSION_DIR}/AutoProcIntegration.sql

mariadb-dump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcStatus > ${SESSION_DIR}/AutoProcStatus.sql

mariadb-dump ${OPTIONS} --where="autoProcId IN (SELECT autoProcId FROM AutoProcScaling WHERE autoProcScalingId IN (SELECT autoProcScalingId FROM AutoProcScaling_has_Int WHERE autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))))" AutoProc > ${SESSION_DIR}/AutoProc.sql

mariadb-dump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcScaling > ${SESSION_DIR}/AutoProcScaling.sql

mariadb-dump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcScaling_has_Int > ${SESSION_DIR}/AutoProcScaling_has_Int.sql

mariadb-dump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcScalingStatistics > ${SESSION_DIR}/AutoProcScalingStatistics.sql

mariadb-dump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MXMRRun > ${SESSION_DIR}/MXMRRun.sql

mariadb-dump ${OPTIONS} --where="mxMRRunId IN (SELECT mr.mxMRRunId FROM MXMRRun mr INNER JOIN AutoProcScaling_has_Int apshi USING(autoProcScalingId) INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MXMRRunBlob > ${SESSION_DIR}/MXMRRunBlob.sql


# Screening* tables:

mariadb-dump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}) OR dataCollectionId IN (SELECT dc.dataCollectionId FROM DataCollection dc INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Screening > ${SESSION_DIR}/Screening.sql

mariadb-dump ${OPTIONS} --where="screeningId IN (SELECT s.screeningId FROM Screening s INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningId IN (SELECT screeningId FROM Screening s INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningOutput > ${SESSION_DIR}/ScreeningOutput.sql

mariadb-dump ${OPTIONS} --where="screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningOutputLattice > ${SESSION_DIR}/ScreeningOutputLattice.sql

mariadb-dump ${OPTIONS} --where="screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategy > ${SESSION_DIR}/ScreeningStrategy.sql

mariadb-dump ${OPTIONS} --where="screeningStrategyId IN (SELECT screeningStrategyId FROM ScreeningStrategy ss INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningStrategyId IN (SELECT screeningStrategyId FROM ScreeningStrategy ss INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategyWedge > ${SESSION_DIR}/ScreeningStrategyWedge.sql

mariadb-dump ${OPTIONS} --where="screeningStrategyWedgeId IN (SELECT screeningStrategyWedgeId FROM ScreeningStrategyWedge ssw INNER JOIN ScreeningStrategy ss USING(screeningStrategyId) INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningStrategyWedgeId IN (SELECT screeningStrategyWedgeId FROM ScreeningStrategyWedge ssw INNER JOIN ScreeningStrategy ss USING(screeningStrategyId) INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategySubWedge > ${SESSION_DIR}/ScreeningStrategySubWedge.sql

# Phasing tables

mariadb-dump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Phasing_has_Scaling > ${SESSION_DIR}/Phasing_has_Scaling.sql

mariadb-dump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingAnalysis > ${SESSION_DIR}/PhasingAnalysis.sql

mariadb-dump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ModelBuilding > ${SESSION_DIR}/ModelBuilding.sql

mariadb-dump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" SubstructureDetermination > ${SESSION_DIR}/SubstructureDetermination.sql

mariadb-dump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PreparePhasingData > ${SESSION_DIR}/PreparePhasingData.sql

mariadb-dump ${OPTIONS} --where="phasingProgramRunId IN (SELECT p.phasingProgramRunId FROM Phasing p INNER JOIN Phasing_has_Scaling USING(phasingAnalysisId) INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingProgramRun > ${SESSION_DIR}/PhasingProgramRun.sql

mariadb-dump ${OPTIONS} --where="phasingProgramRunId IN (SELECT p.phasingProgramRunId FROM Phasing p INNER JOIN Phasing_has_Scaling USING(phasingAnalysisId) INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingProgramAttachment > ${SESSION_DIR}/PhasingProgramAttachment.sql

mariadb-dump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Phasing > ${SESSION_DIR}/Phasing.sql

mariadb-dump ${OPTIONS} --where="phasingStatisticsId IN (SELECT ps.phasingStatisticsId FROM PhasingStatistics ps INNER JOIN Phasing_has_Scaling phs ON ps.phasingHasScalingId1=phs.phasingHasScalingId OR ps.phasingHasScalingId2=phs.phasingHasScalingId INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingStatistics > ${SESSION_DIR}/PhasingStatistics.sql


# Combine INSERT statements in the PROPOSAL_DIR .sql files in the correct order.
# For the Position table, use non-strict sql_mode due to generated columns.
# For the DiffractionPlan table, convert empty experimentKind to NULL
# For the Dewar table, turn off FK constraint because of firstExperimentId
# For the Container table, turn off FK constraint because of sessionId
# For the Screen table, turn off FK constraint because of proposalId
# For the LabContact table, turn off FK constraint because of proposalId

all_sql_files=`cd ${PROPOSAL_DIR} && ls -tr *.sql && cd ~-`
arr=()
while read -r sql_file; do
  grep INSERT "${PROPOSAL_DIR}/${sql_file}" | sed 's/^INSERT INTO `Position`.*/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='\''NO_AUTO_VALUE_ON_ZERO'\'';\n\0\nSET @@SQL_MODE=@OLD_SQL_MODE;/' | sed 's/^INSERT INTO `DiffractionPlan`.*/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='\''EMPTY_STRING_IS_NULL'\'';\n\0\nSET @@SQL_MODE=@OLD_SQL_MODE;/' | sed 's/^INSERT INTO `Dewar`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' | sed 's/^INSERT INTO `Container`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' | sed 's/^INSERT INTO `Screen`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' | sed 's/^INSERT INTO `LabContact`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' >> ${OUT_DIR}/${PROPOSAL_FILE}
done <<< "$all_sql_files"

# Tidy up the import above - set FK vals to:
#  - NULL when they reference non-existing rows
#  - ${PID} when referencing a different proposalId

echo "UPDATE Screen SET proposalId = NULL WHERE proposalId NOT IN (SELECT proposalId FROM Proposal);" >> ${OUT_DIR}/${PROPOSAL_FILE}

echo "UPDATE LabContact SET proposalId = ${PID} WHERE proposalId <> ${PID};" >> ${OUT_DIR}/${PROPOSAL_FILE}

echo "UPDATE Dewar SET firstExperimentId = NULL WHERE firstExperimentId NOT IN (SELECT sessionId FROM BLSession);" >> ${OUT_DIR}/${PROPOSAL_FILE}

echo "UPDATE Container SET sessionId = NULL WHERE sessionId NOT IN (SELECT sessionId FROM BLSession);" >> ${OUT_DIR}/${PROPOSAL_FILE}

# Combine INSERT statements in the SESSION_DIR .sql files in the correct order.

all_sql_files=`cd ${SESSION_DIR} && ls -tr *.sql && cd ~-`
arr=()
while read -r sql_file; do
  cat "${SESSION_DIR}/${sql_file}" >> ${OUT_DIR}/${SESSION_FILE}
done <<< "$all_sql_files"
