INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_03_25_ProcessingPipeline_ren_col.sql', 'ONGOING');

ALTER TABLE Container
  CHANGE priorityPipeline priorityPipelineId int(11) unsigned DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_03_25_ProcessingPipeline_ren_col.sql';
