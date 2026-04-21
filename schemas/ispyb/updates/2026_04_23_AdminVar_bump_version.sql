INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_23_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '5.0.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_23_AdminVar_bump_version.sql';
