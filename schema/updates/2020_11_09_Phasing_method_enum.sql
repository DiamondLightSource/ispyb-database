INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_09_Phasing_method_enum.sql', 'ONGOING');

ALTER TABLE Phasing MODIFY `method` enum('solvent flattening','solvent flipping', 'shelxe') DEFAULT NULL COMMENT 'phasing method';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_09_Phasing_method_enum.sql';
