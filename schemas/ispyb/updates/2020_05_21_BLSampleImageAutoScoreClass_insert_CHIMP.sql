INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_05_21_BLSampleImageAutoScoreClass_insert_CHIMP.sql','ONGOING');

INSERT INTO BLSampleImageAutoScoreClass (
  blSampleImageAutoScoreClassId, blSampleImageAutoScoreSchemaId, scoreClass
)
  VALUES (5,2,'clear'), (6,2,'crystal'), (7,2,'precipitant'), (8,2,'other');

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_05_21_BLSampleImageAutoScoreClass_insert_CHIMP.sql';
