INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_06_27_undo_ParticleClassification_set_Tomogram_pixelLocation.sql', 'ONGOING');

ALTER TABLE ParticleClassification DROP COLUMN IF EXISTS pixelLocationX;
ALTER TABLE ParticleClassification DROP COLUMN IF EXISTS pixelLocationY;

ALTER TABLE Tomogram ADD pixelLocationX int COMMENT 'pixel location of tomogram centre on search map image (x)', ALGORITHM=INSTANT;
ALTER TABLE Tomogram ADD pixelLocationY int COMMENT 'pixel location of tomogram centre on search map image (y)', ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_06_27_undo_ParticleClassification_set_Tomogram_pixelLocation.sql';
