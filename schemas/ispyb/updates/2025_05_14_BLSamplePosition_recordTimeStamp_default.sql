INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_14_BLSamplePosition_recordTimeStamp_default.sql', 'ONGOING');

ALTER TABLE BLSamplePosition MODIFY COLUMN recordTimeStamp datetime DEFAULT current_timestamp;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_14_BLSamplePosition_recordTimeStamp_default.sql';
