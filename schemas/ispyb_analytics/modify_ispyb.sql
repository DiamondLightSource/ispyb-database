-- Add instrumentId + indexes to relevant tables

ALTER TABLE BLSession
  ADD instrumentId SMALLINT UNSIGNED INVISIBLE;

UPDATE BLSession bs 
  JOIN Instrument i ON i.name = bs.beamlineName 
  SET bs.instrumentId = i.instrumentId;

ALTER TABLE BLSession
  ADD INDEX BLSession_instrumentId (instrumentId);

INSERT INTO Proposal_has_Instrument (instrumentId, proposalId)
  SELECT DISTINCT instrumentId, proposalId FROM BLSession;


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
