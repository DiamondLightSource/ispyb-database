INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_07_17_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '4.8.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_07_17_AdminVar_bump_version.sql';
