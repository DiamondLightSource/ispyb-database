INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_01_08_ParticleClassificationGroup_binnedPixelSize.sql', 'ONGOING');

ALTER TABLE ParticleClassificationGroup ADD binnedPixelSize float COMMENT 'Binned pixel size. Unit: Angstroms', ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_01_08_ParticleClassificationGroup_binnedPixelSize.sql';
