INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_03_16_ProcessingPipeline_new_pipelines.sql  ', 'ONGOING');

INSERT INTO
	ProcessingPipeline (processingPipelineCategoryId,
	name,
	discipline,
	pipelineStatus,
	reprocessing)
VALUES (2,'autoPROC+STARANISO','MX','automatic',0),
       (2,'xia2/DIALS (multi)','MX','automatic',0),
       (2,'xia2/3dii (multi)','MX','automatic',0);

UPDATE ProcessingPipeline SET name = "xia2/XDS" WHERE processingPipelineId = 4;
UPDATE ProcessingPipeline SET name = "xia2/3dii" WHERE processingPipelineId = 7;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_03_16_ProcessingPipeline_new_pipelines.sql  ';
