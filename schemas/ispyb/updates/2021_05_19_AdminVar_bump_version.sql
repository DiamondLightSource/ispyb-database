INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_05_19_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.21.1' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_05_19_AdminVar_bump_version.sql';
