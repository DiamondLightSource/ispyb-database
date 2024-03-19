INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_19_ProcessingJobParameter_index.sql', 'ONGOING');

CREATE INDEX ProcessingJobParameter_idx_paramKey_procJobId ON ProcessingJobParameter(parameterKey, processingJobId);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_19_ProcessingJobParameter_index.sql';
