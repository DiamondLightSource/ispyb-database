INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_12_01_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.15.2' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_12_01_AdminVar_bump_version.sql';
