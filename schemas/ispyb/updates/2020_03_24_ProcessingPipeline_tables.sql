INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_03_24_ProcessingPipeline_tables.sql', 'ONGOING');

CREATE TABLE ProcessingPipelineCategory (
  processingPipelineCategoryId int(11) unsigned auto_increment PRIMARY KEY,
  name varchar(20) NOT NULL
)
COMMENT 'A lookup table for the category of processing pipeline';

CREATE TABLE ProcessingPipeline (
  processingPipelineId int(11) unsigned auto_increment PRIMARY KEY,
  processingPipelineCategoryId int(11) unsigned,
  name varchar(20) NOT NULL,
  discipline varchar(10) NOT NULL,
  pipelineStatus enum('automatic','optional','deprecated') DEFAULT NULL COMMENT 'Is the pipeline in operation or available',
  reprocessing boolean DEFAULT 1 COMMENT 'Pipeline is available for re-processing',
  CONSTRAINT ProcessingPipeline_fk1 FOREIGN KEY(processingPipelineCategoryId)
    REFERENCES ProcessingPipelineCategory (processingPipelineCategoryId)
)
COMMENT 'A lookup table for different processing pipelines and their categories';

ALTER TABLE Container
  ADD priorityPipeline int(11) unsigned NULL DEFAULT NULL,
  ADD CONSTRAINT Container_ibfk9 FOREIGN KEY(priorityPipeline) REFERENCES ProcessingPipeline(processingPipelineId);

INSERT INTO ProcessingPipelineCategory (processingPipelineCategoryId, name)
  VALUES (1, 'screening'), (2, 'processing'), (3, 'post processing');

INSERT INTO ProcessingPipeline (processingPipelineId, name, discipline, processingPipelineCategoryId, pipelineStatus, reprocessing)
  VALUES
  (1, 'Mosflm', 'MX', 1, 'automatic', 0),
  (2, 'EDNA', 'MX', 1, 'automatic', 0),
  (3, 'Fast DP', 'MX', 2, 'automatic', 1),
  (4, 'xia2/3dii', 'MX', 2, 'deprecated', 0),
  (5, 'xia2/Multiplex', 'MX', 2, 'automatic', 1),
  (6, 'xia2/DIALS', 'MX', 2, 'optional', 1),
  (7, 'xia2/XDS', 'MX', 2, 'optional', 1),
  (8, 'autoPROC', 'MX', 2, 'optional', 1),
  (9, 'Fast EP', 'MX', 3, 'automatic', 0),
  (10, 'Dimple', 'MX', 3, 'automatic', 0),
  (11, 'MrBUMP', 'MX', 3, 'automatic', 0),
  (12, 'Big EP/XDS', 'MX', 3, 'automatic', 0),
  (13, 'Big EP/DIALS', 'MX', 3, 'automatic', 0);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_03_24_ProcessingPipeline_tables.sql';
