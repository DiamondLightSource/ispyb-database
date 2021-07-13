INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_08_AutoProcScalingStatistics_resIOverSigI2.sql', 'ONGOING');

ALTER TABLE AutoProcScalingStatistics
  ADD resIOverSigI2 float COMMENT 'Resolution where I/Sigma(I) equals 2';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_08_AutoProcScalingStatistics_resIOverSigI2.sql';

