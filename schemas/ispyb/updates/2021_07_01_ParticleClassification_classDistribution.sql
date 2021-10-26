INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_01_ParticleClassification_classDistribution.sql', 'ONGOING');

ALTER TABLE ParticleClassification
  ADD classDistribution float NULL DEFAULT NULL COMMENT 'Provides a figure of merit for the class, higher number is better';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_01_ParticleClassification_classDistribution.sql';
