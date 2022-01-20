INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_01_20_Container_priorityPipelineId_default.sql', 'ONGOING');

ALTER TABLE Container
  MODIFY priorityPipelineId int(11) unsigned DEFAULT 6 COMMENT 'Processing pipeline to prioritise, defaults to 6 which is xia2/DIALS';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_01_20_Container_priorityPipelineId_default.sql';
