INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_02_22_AdminVar_bump_version_v2.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.18.1' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_02_22_AdminVar_bump_version_v2.sql';
