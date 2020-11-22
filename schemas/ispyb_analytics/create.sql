--
-- For a detailed discussion of using views for row-based access control, see:
-- https://vettabase.com/blog/mariadb-mysql-using-views-to-grant-or-deny-row-level-privileges/
--

USE ispyb_build;

CREATE TABLE Instrument (
  instrumentId SMALLINT UNSIGNED PRIMARY KEY,
  name VARCHAR(10)
);

INSERT INTO Instrument (instrumentId, name) VALUES 
  (1, 'i02'),
  (2, 'i02-1'),
  (3, 'i02-2'),
  (4, 'i03'),
  (5, 'i04'),
  (6, 'i04-1'),
  (7, 'i15-1'),
  (8, 'b21'),
  (9, 'i22'),
  (10, 'i23'),
  (11, 'i24');

-- Create and populate permissions tables
-- (We don't care about foreign keys in analytics)

CREATE TABLE Instrument_has_Username (
  instrumentId SMALLINT UNSIGNED,
  username VARCHAR(45),
  PRIMARY KEY(instrumentId, username)
);

INSERT INTO Instrument_has_Username (instrumentId, username) VALUES
  (3, 'karll@localhost'),
  (4, 'root@localhost');


CREATE TABLE Proposal_has_Instrument (
  instrumentId SMALLINT UNSIGNED,
  proposalId INT(10) UNSIGNED,
  PRIMARY KEY(proposalId, instrumentId)
);

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

-- Recreate database

DROP DATABASE IF EXISTS ispyb_analytics;
CREATE DATABASE IF NOT EXISTS ispyb_analytics;

-- Create views

USE ispyb_analytics;

CREATE OR REPLACE SQL SECURITY INVOKER VIEW BLSession AS
  SELECT * 
  FROM ispyb_build.BLSession bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM ispyb_build.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollectionGroup AS
  SELECT * 
  FROM ispyb_build.DataCollectionGroup bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM ispyb_build.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollection AS
  SELECT * 
  FROM ispyb_build.DataCollection bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM ispyb_build.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW EnergyScan AS
  SELECT * 
  FROM ispyb_build.EnergyScan bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM ispyb_build.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW XFEFluorescenceSpectrum AS
  SELECT * 
  FROM ispyb_build.XFEFluorescenceSpectrum bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM ispyb_build.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );






