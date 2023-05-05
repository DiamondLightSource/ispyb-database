INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_05_05_ParticleClassificationGroup_selected.sql', 'ONGOING');

ALTER TABLE ParticleClassificationGroup
  ADD selected boolean COMMENT 'Indicates whether the group is selected for processing or not.';

-- Undo:
-- ALTER TABLE ParticleClassificationGroup
--  DROP IF EXISTS selected;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_05_05_ParticleClassificationGroup_selected.sql';
