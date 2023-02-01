INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_02_01_PDB_contents_compressed.sql', 'ONGOING');

ALTER TABLE PDB MODIFY contents mediumtext /*!100301 COMPRESSED*/ CHARACTER SET utf8mb3 DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_02_01_PDB_contents_compressed.sql';
