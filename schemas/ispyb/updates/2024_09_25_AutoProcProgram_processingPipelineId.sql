INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_09_25_AutoProcProgram_processingPipelineId.sql', 'ONGOING');

ALTER TABLE AutoProcProgram ADD processingPipelineId int(11) unsigned DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_09_25_AutoProcProgram_processingPipelineId.sql';
