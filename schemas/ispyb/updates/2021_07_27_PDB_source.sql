INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_27_PDB_source.sql', 'ONGOING');

ALTER TABLE PDB 
  ADD `source` varchar(30) DEFAULT NULL COMMENT 'Could be e.g. AlphaFold or RoseTTAFold';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_27_PDB_source.sql';
