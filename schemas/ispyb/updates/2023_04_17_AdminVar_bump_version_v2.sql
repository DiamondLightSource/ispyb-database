INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_04_17_AdminVar_bump_version_v2.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.36.1' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_04_17_AdminVar_bump_version_v2.sql';
