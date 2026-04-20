INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_20_Ligand_name.sql', 'ONGOING');

ALTER TABLE Ligand MODIFY COLUMN name VARCHAR(255) NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_20_Ligand_name.sql';
