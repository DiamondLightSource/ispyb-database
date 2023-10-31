INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_31_BLSession_modify_beamlineOperator.sql', 'ONGOING');

ALTER TABLE BLSession
  MODIFY beamLineOperator varchar(255) DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_31_BLSession_modify_beamlineOperator.sql';
