INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_02_25_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '4.5.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_02_25_AdminVar_bump_version.sql';
