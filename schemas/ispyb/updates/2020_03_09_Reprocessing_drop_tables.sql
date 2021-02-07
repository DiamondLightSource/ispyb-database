INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_03_09_Reprocessing_drop_tables.sql', 'ONGOING');

-- These tables are not used - they were instead created as ProcessingJob,
-- ProcessingJobParameter and ProcessingJobImageSweep.

DROP TABLE ReprocessingImageSweep;
DROP TABLE ReprocessingParameter;
DROP TABLE Reprocessing;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_03_09_Reprocessing_drop_tables.sql';
