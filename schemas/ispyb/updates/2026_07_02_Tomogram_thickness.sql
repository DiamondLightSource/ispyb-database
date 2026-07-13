INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_07_02_Tomogram_thickness.sql', 'ONGOING');

ALTER TABLE Tomogram ADD thickness float NULL COMMENT 'Unit: nm';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_07_02_Tomogram_thickness.sql';
