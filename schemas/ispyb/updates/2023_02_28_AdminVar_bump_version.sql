INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_02_28_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '1.35.0' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_02_28_AdminVar_bump_version.sql';
