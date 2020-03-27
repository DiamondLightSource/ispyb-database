INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_03_27_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.11.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_03_27_AdminVar_bump_version.sql';
