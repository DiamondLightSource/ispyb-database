INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_05_12_ParticleClassification_rotationAccuracy.sql', 'ONGOING');

ALTER TABLE `ParticleClassification`
  MODIFY rotationAccuracy float COMMENT '???';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2021_05_12_ParticleClassification_rotationAccuracy.sql';
