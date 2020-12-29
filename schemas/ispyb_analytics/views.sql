--
-- For a detailed discussion of using views for row-based access control, see:
-- https://vettabase.com/blog/mariadb-mysql-using-views-to-grant-or-deny-row-level-privileges/
--

-- Recreate database

CREATE OR REPLACE SQL SECURITY INVOKER VIEW BLSession AS
  SELECT * 
  FROM $ispyb.BLSession bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollectionGroup AS
  SELECT * 
  FROM $ispyb.DataCollectionGroup bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW DataCollection AS
  SELECT * 
  FROM $ispyb.DataCollection bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW EnergyScan AS
  SELECT * 
  FROM $ispyb.EnergyScan bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );

CREATE OR REPLACE SQL SECURITY INVOKER VIEW XFEFluorescenceSpectrum AS
  SELECT * 
  FROM $ispyb.XFEFluorescenceSpectrum bs
  WHERE instrumentId IN (
    SELECT instrumentId 
    FROM $ispyb.Instrument_has_Username ihu
    WHERE ihu.username = current_user()
  );






