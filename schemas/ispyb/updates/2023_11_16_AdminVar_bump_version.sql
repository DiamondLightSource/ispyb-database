INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_11_16_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '3.0.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_11_16_AdminVar_bump_version.sql';
