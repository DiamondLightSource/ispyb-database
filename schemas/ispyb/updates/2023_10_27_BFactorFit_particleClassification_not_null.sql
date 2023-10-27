INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_27_BFactorFit_particleClassification_not_null.sql', 'ONGOING');

ALTER TABLE BFactorFit
  MODIFY particleClassificationId int(11) unsigned NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_27_BFactorFit_particleClassification_not_null.sql';
