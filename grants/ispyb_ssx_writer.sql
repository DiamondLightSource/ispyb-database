CREATE ROLE ispyb_ssx_writer;

-- You also need to create a database user and grant this role to them, e.g.
-- CREATE USER ispyb_ssx_server@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_ssx_writer TO ispyb_ssx_server@'%';
-- SET DEFAULT ROLE ispyb_ssx_writer FOR ispyb_ssx_server@'%';

GRANT SELECT ON ExperimentType TO ispyb_ssx_writer;
GRANT SELECT ON ComponentType TO ispyb_ssx_writer;
GRANT SELECT ON ConcentrationType TO ispyb_ssx_writer;
GRANT SELECT ON EventType TO ispyb_ssx_writer;

GRANT EXECUTE ON upsert_dc_group_v3 TO ispyb_ssx_writer;
GRANT EXECUTE ON upsert_dc TO ispyb_ssx_writer;

GRANT SELECT, INSERT, UPDATE ON SSXDataCollection TO ispyb_ssx_writer;
GRANT SELECT, INSERT, UPDATE ON DataCollectionGroup TO ispyb_ssx_writer;
GRANT SELECT, INSERT, UPDATE ON DataCollection TO ispyb_ssx_writer;

GRANT SELECT, INSERT, UPDATE ON EventChain TO ispyb_ssx_writer;
GRANT SELECT, INSERT, UPDATE ON Event TO ispyb_ssx_writer;

GRANT SELECT, INSERT, UPDATE ON Component TO ispyb_ssx_writer;
GRANT SELECT, INSERT, UPDATE ON SampleComposition TO ispyb_ssx_writer;
GRANT SELECT, INSERT, UPDATE ON CrystalComposition TO ispyb_ssx_writer;
