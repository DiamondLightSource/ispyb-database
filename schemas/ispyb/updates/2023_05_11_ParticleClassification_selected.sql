INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_05_11_ParticleClassification_selected.sql', 'ONGOING');

-- The column was previously by mistake added to ParticleClassificationGroup.
-- Let's simply drop it from there:
ALTER TABLE ParticleClassificationGroup
  DROP IF EXISTS selected;

ALTER TABLE ParticleClassification
  ADD selected boolean DEFAULT False COMMENT 'Indicates whether the class is selected for further processing or not';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_05_11_ParticleClassification_selected.sql';
