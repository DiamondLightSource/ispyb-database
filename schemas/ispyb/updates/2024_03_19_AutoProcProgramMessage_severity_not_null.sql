INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_19_AutoProcProgramMessage_severity_not_null.sql', 'ONGOING');

ALTER TABLE AutoProcProgramMessage
  MODIFY severity enum('ERROR','WARNING','INFO') NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_19_AutoProcProgramMessage_severity_not_null.sql';
