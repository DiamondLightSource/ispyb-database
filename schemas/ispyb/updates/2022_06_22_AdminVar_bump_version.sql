INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_06_22_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.30.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_06_22_AdminVar_bump_version.sql';
