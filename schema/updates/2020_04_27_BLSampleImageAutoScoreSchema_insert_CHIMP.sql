INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_04_27_BLSampleImageAutoScoreSchema_insert_CHIMP.sql','ONGOING');

INSERT INTO BLSampleImageAutoScoreSchema (blSampleImageAutoScoreSchemaId, schemaName, enabled)
  VALUES (2, 'CHIMP', 1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_04_27_BLSampleImageAutoScoreSchema_insert_CHIMP.sql';
