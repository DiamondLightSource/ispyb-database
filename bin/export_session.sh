#!/bin/sh

# Usage:
# export_session <db_name> <proposalCode><proposalNumber> <session number> <output dir>
# Usage example:
# export_proposal.sh ispyb cm14451 2 /tmp/cm14451
# Author: Karl Levik
# Date: 2020-02-14


HOST=localhost
MYCNF=$1
DB=$2
PROPOSAL=$3
SESSNUM=$4
OUT_DIR=$5

PID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT proposalId FROM Proposal WHERE concat(proposalCode, proposalNumber)='${PROPOSAL}';"`

SID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT sessionId FROM BLSession WHERE proposalId='${PID}' AND visit_number=${SESSNUM};"`

PERSID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT personId FROM Proposal WHERE proposalId=${PID};"`

LABID=`mysql --defaults-extra-file=${MYCNF} -s -D ${DB} -e "SELECT laboratoryId FROM Person WHERE personId=${PERSID};"`

if [ -d "${OUT_DIR}" ]
then
  rm -f -r -I -d ${OUT_DIR}
fi
mkdir -p ${OUT_DIR}

OPTIONS="--defaults-file=${MYCNF} --add-drop-table --create-options --disable-keys --skip-add-locks --quick --set-charset --single-transaction --max_allowed_packet=1G --skip-triggers --no-create-info --complete-insert --host=${HOST} --port=3306 --default-character-set=utf8 ${DB}"

# Global level data

mysqldump ${OPTIONS} Detector Imager ComponentType ComponentSubType InspectionType SpaceGroup v_run UserGroup Permission UserGroup_has_Permission Schedule ScheduleComponent ScanParametersService > ${OUT_DIR}/${DB}_global.sql

mysqldump ${OPTIONS} --where="diffractionPlanId IN (SELECT dataCollectionPlanId FROM ScanParametersModel)" DiffractionPlan > ${OUT_DIR}/${DB}_DiffractionPlan0.sql

mysqldump ${OPTIONS} ScanParametersModel > ${OUT_DIR}/${DB}_ScanParametersModel.sql

# Proposal level data

mysqldump ${OPTIONS} --where="laboratoryId=${LABID}   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN LabContact lc USING(personId) WHERE lc.proposalId=${PID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN Session_has_Person shp USING(personId) WHERE shp.sessionId=${SID})   OR   laboratoryId IN (SELECT laboratoryId FROM Person p INNER JOIN ProposalHasPerson php WHERE php.proposalId=${PID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId WHERE c.sessionId=${SID})   OR   laboratoryId IN (SELECT p.laboratoryId FROM Person p INNER JOIN Container c ON c.ownerId=p.personId INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   laboratoryId IN (SELECT pe.laboratoryId FROM Person pe INNER JOIN Container c ON c.ownerId=pe.personId INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" Laboratory > ${OUT_DIR}/${DB}_Laboratory.sql

mysqldump ${OPTIONS} --where="personId=${PERSID}   OR   personId IN (SELECT personId FROM LabContact WHERE proposalId=${PID})   OR   personId IN (SELECT personId FROM Session_has_Person WHERE sessionId=${SID})   OR   personId IN (SELECT personId FROM ProposalHasPerson WHERE proposalId=${PID})   OR   personId IN (SELECT ownerId FROM Container WHERE sessionId=${SID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN Dewar d USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   personId IN (SELECT c.ownerId FROM Container c INNER JOIN BLSample bls USING(containerId) INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" Person > ${OUT_DIR}/${DB}_Person.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Proposal > ${OUT_DIR}/${DB}_Proposal.sql

mysqldump ${OPTIONS} --where="beamLineSetupId IN (SELECT beamLineSetupId FROM BLSession WHERE sessionId=${SID})" BeamLineSetup > ${OUT_DIR}/${DB}_BeamLineSetup.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" BLSession > ${OUT_DIR}/${DB}_BLSession.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" LabContact > ${OUT_DIR}/${DB}_LabContact.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Protein > ${OUT_DIR}/${DB}_Protein.sql

mysqldump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" ComponentLattice > ${OUT_DIR}/${DB}_ComponentLattice.sql

mysqldump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Component_has_SubType > ${OUT_DIR}/${DB}_Component_has_SubType.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Screen > ${OUT_DIR}/${DB}_Screen.sql

mysqldump ${OPTIONS} --where="proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Crystal > ${OUT_DIR}/${DB}_Crystal.sql

mysqldump ${OPTIONS} --where="componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID}) AND blSampleTypeId IN (SELECT crystalId FROM Crystal c INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" BLSampleType_has_Component > ${OUT_DIR}/${DB}_BLSampleType_has_Component.sql

mysqldump ${OPTIONS} --where="pdbId IN (SELECT pdbId FROM PDB INNER JOIN Protein_has_PDB php USING(pdbId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" PDB > ${OUT_DIR}/${DB}_PDB.sql

mysqldump ${OPTIONS} --where="proteinId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" Protein_has_PDB > ${OUT_DIR}/${DB}_Protein_has_PDB.sql

mysqldump ${OPTIONS} --where="screenId IN (SELECT s.screenId FROM Screen s WHERE s.proposalId=${PID} OR s.global>0)" ScreenComponentGroup > ${OUT_DIR}/${DB}_ScreenComponentGroup.sql

mysqldump ${OPTIONS} --where="screenComponentGroupId IN (SELECT scg.screenComponentGroupId FROM ScreenComponentGroup scg INNER JOIN Screen s USING(screenId) WHERE s.proposalId=${PID} OR s.global>0) AND componentId IN (SELECT proteinId FROM Protein WHERE proposalId=${PID})" ScreenComponent > ${OUT_DIR}/${DB}_ScreenComponent.sql

mysqldump ${OPTIONS} --where="positionId IN (SELECT positionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}))" Position > ${OUT_DIR}/${DB}_Position1.sql

# BLSubSample.positionId
mysqldump ${OPTIONS} --where="positionId IN (SELECT blss.positionId FROM BLSubSample blss INNER JOIN BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR bls.containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))" Position > ${OUT_DIR}/${DB}_Position2.sql

# BLSubSample.position2Id
mysqldump ${OPTIONS} --where="positionId IN (SELECT blss.position2Id FROM BLSubSample blss INNER JOIN BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR bls.containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))" Position > ${OUT_DIR}/${DB}_Position3.sql

mysqldump ${OPTIONS} --where="diffractionPlanId IN (SELECT c.diffractionPlanId FROM Crystal c INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})
OR diffractionPlanId IN (SELECT bls.diffractionPlanId FROM BLSample bls INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR diffractionPlanId IN (SELECT blss.diffractionPlanId FROM BLSubSample blss INNER JOIN BLSample USING(blSampleId) INNER JOIN Crystal c USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})" DiffractionPlan > ${OUT_DIR}/${DB}_DiffractionPlan1.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" ProposalHasPerson > ${OUT_DIR}/${DB}_ProposalHasPerson.sql

mysqldump ${OPTIONS} --where="proposalId=${PID}" Shipping > ${OUT_DIR}/${DB}_Shipping.sql

mysqldump ${OPTIONS} --where="shippingId IN (SELECT shippingId FROM Shipping WHERE proposalId=${PID})" Dewar > ${OUT_DIR}/${DB}_Dewar.sql

mysqldump ${OPTIONS} --where="containerRegistryId IN (SELECT c.containerRegistryId FROM Container c INNER JOIN Dewar USING(dewarId) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})" ContainerRegistry > ${OUT_DIR}/${DB}_ContainerRegistry1.sql


# Proposal/Session level data

mysqldump ${OPTIONS} --where="sessionId=${SID}   OR   dewarId IN (SELECT d.dewarId FROM Dewar d INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   containerId IN (SELECT bls.containerId FROM BLSample bls INNER JOIN Crystal USING(crystalId) INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   containerId IN (SELECT containerId FROM BLSample INNER JOIN EnergyScan es USING(blSampleId) WHERE es.sessionId=${SID} UNION ALL SELECT containerId FROM BLSample INNER JOIN XFEFluorescenceSpectrum xfs USING(blSampleId) WHERE xfs.sessionId=${SID})" Container > ${OUT_DIR}/${DB}_Container.sql

mysqldump ${OPTIONS} --where="crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID})   OR   containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID})   OR   blSampleId IN (SELECT blSampleId FROM XFEFluorescenceSpectrum WHERE sessionId=${SID} UNION ALL SELECT blSampleId FROM EnergyScan WHERE sessionId=${SID})" BLSample > ${OUT_DIR}/${DB}_BLSample1.sql

mysqldump ${OPTIONS} --where="blSampleId IN (SELECT bls.blSampleId FROM BLSample bls WHERE bls.crystalId IN (SELECT cr.crystalId FROM Crystal cr INNER JOIN Protein p USING(proteinId) WHERE p.proposalId=${PID}) OR containerId IN (SELECT c.containerId FROM Container c INNER JOIN Dewar USING(dewarID) INNER JOIN Shipping s USING(shippingId) WHERE s.proposalId=${PID} AND (c.sessionId IS NULL OR c.sessionId=${SID})))   OR   blSubSampleId IN (SELECT blSubSampleId FROM XFEFluorescenceSpectrum WHERE sessionId=${SID})" BLSubSample > ${OUT_DIR}/${DB}_BLSubSample.sql


# Session level data

mysqldump ${OPTIONS} --where="sessionId=${SID}" SessionType > ${OUT_DIR}/${DB}_SessionType.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" DataCollectionGroup > ${OUT_DIR}/${DB}_DataCollectionGroup.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" ShippingHasSession > ${OUT_DIR}/${DB}_ShippingHasSession.sql

mysqldump ${OPTIONS} --where="apertureId IN (SELECT dc.apertureId FROM DataCollection dc INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Aperture > ${OUT_DIR}/${DB}_Aperture.sql

mysqldump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})" DataCollection > ${OUT_DIR}/${DB}_DataCollection.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" GridImageMap > ${OUT_DIR}/${DB}_GridImageMap.sql

mysqldump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})" GridInfo > ${OUT_DIR}/${DB}_GridInfo.sql

mysqldump ${OPTIONS} --where="gridInfoId IN (SELECT gi.gridInfoId FROM GridInfo gi INNER JOIN DataCollectionGroup dcg USING(datacollectionGroupId) WHERE dcg.sessionId=${SID})" XrayCentringResult > ${OUT_DIR}/${DB}_XrayCentringResult.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" XFEFluorescenceSpectrum > ${OUT_DIR}/${DB}_XFEFluorescenceSpectrum.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" EnergyScan > ${OUT_DIR}/${DB}_EnergyScan.sql

mysqldump ${OPTIONS} --where="sessionId=${SID}" Session_has_Person > ${OUT_DIR}/${DB}_Session_has_Person.sql

mysqldump ${OPTIONS} --where="containerRegistryId IN (SELECT c.containerRegistryId FROM Container c WHERE c.sessionId=${SID})" ContainerRegistry > ${OUT_DIR}/${DB}_ContainerRegistry2.sql

mysqldump ${OPTIONS} --where="blsessionId=${SID}" RobotAction > ${OUT_DIR}/${DB}_RobotAction.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ImageQualityIndicators > ${OUT_DIR}/${DB}_ImageQualityIndicators.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" DataCollectionComment > ${OUT_DIR}/${DB}_DataCollectionComment.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" DataCollectionFileAttachment > ${OUT_DIR}/${DB}_DataCollectionFileAttachment.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Movie > ${OUT_DIR}/${DB}_Movie.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram3.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment3.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT mc.autoProcProgramId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage3.sql

mysqldump ${OPTIONS} --where="movieId IN (SELECT m.movieId FROM Movie m INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MotionCorrection > ${OUT_DIR}/${DB}_MotionCorrection.sql

mysqldump ${OPTIONS} --where="motionCorrectionId IN (SELECT mc.motionCorrectionId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MotionCorrectionDrift > ${OUT_DIR}/${DB}_MotionCorrectionDrift.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram4.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment4.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT ctf.autoProcProgramId FROM CTF ctf INNER JOIN MotionCorrection USING(motionCorrectionId) INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage4.sql

mysqldump ${OPTIONS} --where="motionCorrectionId IN (SELECT mc.motionCorrectionId FROM MotionCorrection mc INNER JOIN Movie m USING(movieId) INNER JOIN DataCollection dc ON dc.dataCollectionId=m.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" CTF > ${OUT_DIR}/${DB}_CTF.sql


mysqldump ${OPTIONS} --where="containerId IN (SELECT containerId FROM Container WHERE sessionId=${SID})" ContainerInspection > ${OUT_DIR}/${DB}_ContainerInspection.sql

mysqldump ${OPTIONS} --where="containerId IN (SELECT containerId FROM Container WHERE sessionId=${SID})" ContainerQueue > ${OUT_DIR}/${DB}_ContainerQueue.sql

mysqldump ${OPTIONS} --where="containerQueueId IN (SELECT cq.containerQueueId FROM ContainerQueue cq INNER JOIN Container c USING(containerId) WHERE c.sessionId=${SID})" ContainerQueueSample > ${OUT_DIR}/${DB}_ContainerQueueSample.sql


# ProcessingJob* and AutoProc* tables:

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJob > ${OUT_DIR}/${DB}_ProcessingJob.sql

mysqldump ${OPTIONS} --where="processingJobId IN (SELECT pj.processingJobId FROM ProcessingJob pj INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJobParameter > ${OUT_DIR}/${DB}_ProcessingJobParameter.sql

mysqldump ${OPTIONS} --where="processingJobId IN (SELECT pj.processingJobId FROM ProcessingJob pj INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})   OR   processingJobId IN (SELECT processingJobId FROM AutoProcProgram INNER JOIN AutoProcIntegration api USING(autoProcProgramId) INNER JOIN DataCollection dc ON api.dataCollectionId=dc.dataCollectionId INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ProcessingJobImageSweep > ${OUT_DIR}/${DB}_ProcessingJobImageSweep.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram1.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment1.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage1.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcProgram > ${OUT_DIR}/${DB}_AutoProcProgram2.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramAttachment > ${OUT_DIR}/${DB}_AutoProcProgramAttachment2.sql

mysqldump ${OPTIONS} --where="autoProcProgramId IN (SELECT autoProcProgramId FROM AutoProcProgram WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcProgramMessage > ${OUT_DIR}/${DB}_AutoProcProgramMessage2.sql

mysqldump ${OPTIONS} --where="dataCollectionId IN (SELECT dataCollectionId FROM DataCollection INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcIntegration > ${OUT_DIR}/${DB}_AutoProcIntegration.sql

mysqldump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcStatus > ${OUT_DIR}/${DB}_AutoProcStatus.sql

mysqldump ${OPTIONS} --where="autoProcId IN (SELECT autoProcId FROM AutoProcScaling WHERE autoProcScalingId IN (SELECT autoProcScalingId FROM AutoProcScaling_has_Int WHERE autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))))" AutoProc > ${OUT_DIR}/${DB}_AutoProc.sql

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcScaling > ${OUT_DIR}/${DB}_AutoProcScaling.sql

mysqldump ${OPTIONS} --where="autoProcIntegrationId IN (SELECT autoProcIntegrationId FROM AutoProcIntegration WHERE dataCollectionId IN (SELECT dataCollectionId FROM DataCollection WHERE dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID})))" AutoProcScaling_has_Int > ${OUT_DIR}/${DB}_AutoProcScaling_has_Int.sql

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" AutoProcScalingStatistics > ${OUT_DIR}/${DB}_AutoProcScalingStatistics.sql

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MXMRRun > ${OUT_DIR}/${DB}_MXMRRun.sql

mysqldump ${OPTIONS} --where="mxMRRunId IN (SELECT mr.mxMRRunId FROM MXMRRun mr INNER JOIN AutoProcScaling_has_Int apshi USING(autoProcScalingId) INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" MXMRRunBlob > ${OUT_DIR}/${DB}_MXMRRunBlob.sql


# Screening* tables:

mysqldump ${OPTIONS} --where="dataCollectionGroupId IN (SELECT dataCollectionGroupId FROM DataCollectionGroup WHERE sessionId=${SID}) OR dataCollectionId IN (SELECT dc.dataCollectionId FROM DataCollection dc INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Screening > ${OUT_DIR}/${DB}_Screening.sql

mysqldump ${OPTIONS} --where="screeningId IN (SELECT s.screeningId FROM Screening s INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningId IN (SELECT screeningId FROM Screening s INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningOutput > ${OUT_DIR}/${DB}_ScreeningOutput.sql

mysqldump ${OPTIONS} --where="screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningOutputLattice > ${OUT_DIR}/${DB}_ScreeningOutputLattice.sql

mysqldump ${OPTIONS} --where="screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningOutputId IN (SELECT screeningOutputId FROM ScreeningOutput so INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategy > ${OUT_DIR}/${DB}_ScreeningStrategy.sql

mysqldump ${OPTIONS} --where="screeningStrategyId IN (SELECT screeningStrategyId FROM ScreeningStrategy ss INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningStrategyId IN (SELECT screeningStrategyId FROM ScreeningStrategy ss INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategyWedge > ${OUT_DIR}/${DB}_ScreeningStrategyWedge.sql

mysqldump ${OPTIONS} --where="screeningStrategyWedgeId IN (SELECT screeningStrategyWedgeId FROM ScreeningStrategyWedge ssw INNER JOIN ScreeningStrategy ss USING(screeningStrategyId) INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID}) OR screeningStrategyWedgeId IN (SELECT screeningStrategyWedgeId FROM ScreeningStrategyWedge ssw INNER JOIN ScreeningStrategy ss USING(screeningStrategyId) INNER JOIN ScreeningOutput so USING(screeningOutputId) INNER JOIN Screening s USING(screeningId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId=dc.dataCollectionGroupId WHERE dcg.sessionId=${SID})" ScreeningStrategySubWedge > ${OUT_DIR}/${DB}_ScreeningStrategySubWedge.sql

# Phasing tables

mysqldump ${OPTIONS} --where="autoProcScalingId IN (SELECT apshi.autoProcScalingId FROM AutoProcScaling_has_Int apshi INNER JOIN AutoProcIntegration api USING(autoProcIntegrationId) INNER JOIN DataCollection dc USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Phasing_has_Scaling > ${OUT_DIR}/${DB}_Phasing_has_Scaling.sql

mysqldump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingAnalysis > ${OUT_DIR}/${DB}_PhasingAnalysis.sql

mysqldump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" ModelBuilding > ${OUT_DIR}/${DB}_ModelBuilding.sql

mysqldump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" SubstructureDetermination > ${OUT_DIR}/${DB}_SubstructureDetermination.sql

mysqldump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PreparePhasingData > ${OUT_DIR}/${DB}_PreparePhasingData.sql

mysqldump ${OPTIONS} --where="phasingProgramRunId IN (SELECT p.phasingProgramRunId FROM Phasing p INNER JOIN Phasing_has_Scaling USING(phasingAnalysisId) INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingProgramRun > ${OUT_DIR}/${DB}_PhasingProgramRun.sql

mysqldump ${OPTIONS} --where="phasingProgramRunId IN (SELECT p.phasingProgramRunId FROM Phasing p INNER JOIN Phasing_has_Scaling USING(phasingAnalysisId) INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingProgramAttachment > ${OUT_DIR}/${DB}_PhasingProgramAttachment.sql

mysqldump ${OPTIONS} --where="phasingAnalysisId IN (SELECT phs.phasingAnalysisId FROM Phasing_has_Scaling phs INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" Phasing > ${OUT_DIR}/${DB}_Phasing.sql

mysqldump ${OPTIONS} --where="phasingStatisticsId IN (SELECT ps.phasingStatisticsId FROM PhasingStatistics ps INNER JOIN Phasing_has_Scaling phs ON ps.phasingHasScalingId1=phs.phasingHasScalingId OR ps.phasingHasScalingId2=phs.phasingHasScalingId INNER JOIN  AutoProcScaling_has_Int USING(autoProcScalingId) INNER JOIN AutoProcIntegration USING(autoProcIntegrationId) INNER JOIN DataCollection USING(dataCollectionId) INNER JOIN DataCollectionGroup dcg USING(dataCollectionGroupId) WHERE dcg.sessionId=${SID})" PhasingStatistics > ${OUT_DIR}/${DB}_PhasingStatistics.sql


# Combine INSERT statements in the .sql files in the (hopefully) correct order.
# For the Position table, use non-strict sql_mode due to generated columns.
# For the DiffractionPlan table, convert empty experimentKind to NULL
# For the Dewar table, turn off key constraint because of firstExperimentId
# For the Container table, turn off key constraint because of sessionId

all_sql_files=`cd ${OUT_DIR} && ls -tr ${DB}_*.sql && cd ~-`
arr=()
while read -r sql_file; do
  grep INSERT "${OUT_DIR}/${sql_file}" | sed 's/^INSERT INTO `Position`.*/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='\''NO_AUTO_VALUE_ON_ZERO'\'';\n\0\nSET @@SQL_MODE=@OLD_SQL_MODE;/' | sed 's/^INSERT INTO `DiffractionPlan`.*/SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='\''EMPTY_STRING_IS_NULL'\'';\n\0\nSET @@SQL_MODE=@OLD_SQL_MODE;/' | sed 's/^INSERT INTO `Dewar`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' | sed 's/^INSERT INTO `Container`.*/SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;\n\0\nSET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;/' >> ${OUT_DIR}/summary.sql
done <<< "$all_sql_files"
