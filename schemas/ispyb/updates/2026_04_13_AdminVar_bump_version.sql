INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_10_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '4.13.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_10_AdminVar_bump_version.sql';
