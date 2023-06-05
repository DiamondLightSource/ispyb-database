INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_06_05_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '2.1.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_06_05_AdminVar_bump_version.sql';
