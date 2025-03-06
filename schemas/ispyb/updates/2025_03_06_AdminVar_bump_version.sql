INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_03_06_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '4.6.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_03_06_AdminVar_bump_version.sql';
