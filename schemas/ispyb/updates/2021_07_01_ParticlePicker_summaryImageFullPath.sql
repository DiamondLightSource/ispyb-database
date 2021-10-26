INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_01_ParticlePicker_summaryImageFullPath.sql', 'ONGOING');

ALTER TABLE ParticlePicker
  ADD summaryImageFullPath varchar(255) NULL DEFAULT NULL COMMENT 'Generated summary micrograph image with highlighted particles';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_01_ParticlePicker_summaryImageFullPath.sql';
