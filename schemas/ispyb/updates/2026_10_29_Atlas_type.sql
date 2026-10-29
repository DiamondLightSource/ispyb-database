INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_10_29_Atlas_type.sql', 'ONGOING');

ALTER TABLE Atlas ADD atlasType ENUM('ROI', 'Tilescan') NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_10_29_Atlas_type.sql';
