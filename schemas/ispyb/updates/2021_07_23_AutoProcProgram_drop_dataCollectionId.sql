INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_23_AutoProcProgram_drop_dataCollectionId.sql', 'ONGOING');

ALTER TABLE AutoProcProgram
  DROP FOREIGN KEY AutoProcProgram_fk3,
  DROP dataCollectionId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_23_AutoProcProgram_drop_dataCollectionId.sql';