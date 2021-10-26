--
-- For a detailed discussion of using views for row-based access control, see:
-- https://vettabase.com/blog/mariadb-mysql-using-views-to-grant-or-deny-row-level-privileges/
--

-- Recreate views

CREATE OR REPLACE SQL SECURITY DEFINER VIEW Proposal AS
  SELECT DISTINCT p.*
  FROM $ispyb.Proposal p
    JOIN $ispyb.BLSession bs ON bs.proposalId = p.proposalId
  WHERE bs.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW Protein AS
  SELECT DISTINCT pr.*
  FROM $ispyb.Protein pr
    JOIN $ispyb.Proposal p ON p.proposalId = pr.proposalId
    JOIN $ispyb.BLSession bs ON bs.proposalId = p.proposalId
  WHERE bs.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW BLSession AS
  SELECT *
  FROM $ispyb.BLSession
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW DataCollectionGroup AS
  SELECT *
  FROM $ispyb.DataCollectionGroup
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW DataCollection AS
  SELECT *
  FROM $ispyb.DataCollection
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW EnergyScan AS
  SELECT *
  FROM $ispyb.EnergyScan
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW XFEFluorescenceSpectrum AS
  SELECT *
  FROM $ispyb.XFEFluorescenceSpectrum
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW RobotAction AS
  SELECT *
  FROM $ispyb.RobotAction
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW ProcessingJob AS
  SELECT pj.*
  FROM $ispyb.ProcessingJob pj
    JOIN $ispyb.DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
  WHERE dc.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW ProcessingJobParameter AS
  SELECT pjp.*
  FROM $ispyb.ProcessingJobParameter pjp
    JOIN $ispyb.ProcessingJob pj ON pj.processingJobId = pjp.processingJobId
    JOIN $ispyb.DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
  WHERE dc.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW ProcessingJobImageSweep AS
  SELECT pjis.*
  FROM $ispyb.ProcessingJobImageSweep pjis
    JOIN $ispyb.ProcessingJob pj ON pj.processingJobId = pjis.processingJobId
    JOIN $ispyb.DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
  WHERE dc.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcIntegration AS
  SELECT *
  FROM $ispyb.AutoProcIntegration
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcProgram AS
  SELECT *
  FROM $ispyb.AutoProcProgram
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcProgramAttachment AS
  SELECT appa.*
  FROM $ispyb.AutoProcProgramAttachment appa
    JOIN $ispyb.AutoProcProgram app ON app.autoProcProgramId = appa.autoProcProgramId
  WHERE app.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcProgramMessage AS
  SELECT appm.*
  FROM $ispyb.AutoProcProgramMessage appm
    JOIN $ispyb.AutoProcProgram app ON app.autoProcProgramId = appm.autoProcProgramId
  WHERE app.instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcScaling_has_Int AS
  SELECT *
  FROM $ispyb.AutoProcScaling_has_Int
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcScaling AS
  SELECT *
  FROM $ispyb.AutoProcScaling
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProcScalingStatistics AS
  SELECT *
  FROM $ispyb.AutoProcScalingStatistics
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

CREATE OR REPLACE SQL SECURITY DEFINER VIEW AutoProc AS
  SELECT *
  FROM $ispyb.AutoProc
  WHERE instrumentId IN (
    SELECT ihu.instrumentId
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = substring_index(user(),'@',1)
  );

