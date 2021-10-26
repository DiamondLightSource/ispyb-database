-- Add instrumentId + indexes to relevant tables

ALTER TABLE BLSession
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE BLSession bs 
  JOIN Instrument i ON i.name = bs.beamlineName 
  SET bs.instrumentId = i.instrumentId;

ALTER TABLE BLSession
  ADD INDEX BLSession_instrumentId (instrumentId);


INSERT INTO Proposal_has_Instrument (instrumentId, proposalId)
  SELECT DISTINCT instrumentId, proposalId FROM BLSession WHERE instrumentId IS NOT NULL;


ALTER TABLE DataCollectionGroup
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE DataCollectionGroup dcg
  JOIN BLSession bs ON bs.sessionId = dcg.sessionId
  SET dcg.instrumentId = bs.instrumentId;

ALTER TABLE DataCollectionGroup
  ADD INDEX DataCollectionGroup_instrumentId (instrumentId);


ALTER TABLE DataCollection
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE DataCollection dc
  JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId = dc.dataCollectionGroupId
  SET dc.instrumentId = dcg.instrumentId;

ALTER TABLE DataCollection
  ADD INDEX DataCollection_instrumentId (instrumentId);


ALTER TABLE EnergyScan
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE EnergyScan es
  JOIN BLSession bs ON bs.sessionId = es.sessionId
  SET es.instrumentId = bs.instrumentId;

ALTER TABLE EnergyScan
  ADD INDEX EnergyScan_instrumentId (instrumentId);


ALTER TABLE XFEFluorescenceSpectrum
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE XFEFluorescenceSpectrum xs
  JOIN BLSession bs ON bs.sessionId = xs.sessionId
  SET xs.instrumentId = bs.instrumentId;

ALTER TABLE XFEFluorescenceSpectrum
  ADD INDEX XFEFluorescenceSpectrum_instrumentId (instrumentId);


ALTER TABLE RobotAction
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE RobotAction ra
  JOIN BLSession bs ON bs.sessionId = ra.blsessionId
  SET ra.instrumentId = bs.instrumentId;

ALTER TABLE RobotAction
  ADD INDEX RobotAction_instrumentId (instrumentId);


ALTER TABLE AutoProcIntegration
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProcIntegration api
  JOIN DataCollection dc ON dc.dataCollectionId = api.dataCollectionId
  SET api.instrumentId = dc.instrumentId;

ALTER TABLE AutoProcIntegration
  ADD INDEX AutoProcIntegration_instrumentId (instrumentId);


ALTER TABLE AutoProcProgram
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProcProgram app
  JOIN AutoProcIntegration api ON api.autoProcProgramId = app.autoProcProgramId
  SET app.instrumentId = api.instrumentId;

ALTER TABLE AutoProcProgram
  ADD INDEX AutoProcProgram_instrumentId (instrumentId);


ALTER TABLE AutoProcScaling_has_Int
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProcScaling_has_Int apshi
  JOIN AutoProcIntegration api ON api.autoProcIntegrationId = apshi.autoProcIntegrationId
  SET apshi.instrumentId = api.instrumentId;

ALTER TABLE AutoProcScaling_has_Int
  ADD INDEX AutoProcScaling_has_Int_instrumentId (instrumentId);


ALTER TABLE AutoProcScaling
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProcScaling aps
  JOIN AutoProcScaling_has_Int apshi ON apshi.autoProcScalingId = aps.autoProcScalingId
  SET aps.instrumentId = apshi.instrumentId;

ALTER TABLE AutoProcScaling
  ADD INDEX AutoProcScaling_instrumentId (instrumentId);


ALTER TABLE AutoProcScalingStatistics
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProcScalingStatistics apss
  JOIN AutoProcScaling aps ON aps.autoProcScalingId = apss.autoProcScalingId
  SET apss.instrumentId = aps.instrumentId;

ALTER TABLE AutoProcScalingStatistics
  ADD INDEX AutoProcScaling_instrumentId (instrumentId);


ALTER TABLE AutoProc
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE AutoProc ap
  JOIN AutoProcScaling aps ON aps.autoProcId = ap.autoProcId
  SET ap.instrumentId = aps.instrumentId;

ALTER TABLE AutoProc
  ADD INDEX AutoProc_instrumentId (instrumentId);
