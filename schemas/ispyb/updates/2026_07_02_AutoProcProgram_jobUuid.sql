INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_07_02_AutoProcProgram_jobUuid.sql', 'ONGOING');

ALTER TABLE AutoProcProgram ADD jobUuid binary(16) NULL COMMENT 'External UUID for the job as described by the Zocalo service';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_07_02_AutoProcProgram_jobUuid.sql';
