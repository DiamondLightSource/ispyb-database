--
-- For a detailed discussion of using views for row-based access control, see:
-- https://vettabase.com/blog/mariadb-mysql-using-views-to-grant-or-deny-row-level-privileges/
--

-- Recreate database

CREATE OR REPLACE SQL SECURITY INVOKER VIEW BLSession AS
  SELECT *
  FROM $ispyb.BLSession
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollectionGroup AS
  SELECT *
  FROM $ispyb.DataCollectionGroup
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollection AS
  SELECT *
  FROM $ispyb.DataCollection
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW EnergyScan AS
  SELECT *
  FROM $ispyb.EnergyScan
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW XFEFluorescenceSpectrum AS
  SELECT *
  FROM $ispyb.XFEFluorescenceSpectrum
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcIntegration AS
  SELECT *
  FROM $ispyb.AutoProcIntegration
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcProgram AS
  SELECT *
  FROM $ispyb.AutoProcProgram
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcProgramAttachment AS
  SELECT appa.*
  FROM $ispyb.AutoProcProgramAttachment appa
    JOIN $ispyb.AutoProcProgram app ON app.autoProcProgramId = appa.autoProcProgramId
  WHERE app.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcProgramMessage AS
  SELECT appm.*
  FROM $ispyb.AutoProcProgramMessage appm
    JOIN $ispyb.AutoProcProgram app ON app.autoProcProgramId = appm.autoProcProgramId
  WHERE app.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcScaling_has_Int AS
  SELECT *
  FROM $ispyb.AutoProcScaling_has_Int
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcScaling AS
  SELECT *
  FROM $ispyb.AutoProcScaling
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProcScalingStatistics AS
  SELECT *
  FROM $ispyb.AutoProcScalingStatistics
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW AutoProc AS
  SELECT *
  FROM $ispyb.AutoProc
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = user()
  );

