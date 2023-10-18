INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_18_MotionCorrectionDrift_drop.sql', 'ONGOING');

DROP PROCEDURE IF EXISTS upsert_motion_correction_drift;

DROP TABLE IF EXISTS MotionCorrectionDrift;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_18_MotionCorrectionDrift_drop.sql';
