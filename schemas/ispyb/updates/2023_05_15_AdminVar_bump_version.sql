INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_05_15_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '2.0.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_05_15_AdminVar_bump_version.sql';
