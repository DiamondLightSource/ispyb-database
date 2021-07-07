INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_07_AdminVar_bump_version_v2.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.23.1' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_07_AdminVar_bump_version_v2.sql';
