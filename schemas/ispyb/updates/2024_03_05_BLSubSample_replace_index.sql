INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_05_BLSubSample_replace_index.sql', 'ONGOING');

CREATE INDEX IF NOT EXISTS BLSubSample_blSampleId_source ON BLSubSample(blSampleId, source);
DROP INDEX IF EXISTS BLSubSample_FKIndex1 ON BLSubSample;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_05_BLSubSample_replace_index.sql';
