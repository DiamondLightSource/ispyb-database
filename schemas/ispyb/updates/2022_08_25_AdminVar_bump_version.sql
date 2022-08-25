INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_08_25_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.32.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_08_25_AdminVar_bump_version.sql';
