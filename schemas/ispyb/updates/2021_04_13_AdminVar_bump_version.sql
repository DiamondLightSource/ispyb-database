INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_04_13_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.20.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_04_13_AdminVar_bump_version.sql';
