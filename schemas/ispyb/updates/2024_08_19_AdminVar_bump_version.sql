INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_08_19_AdminVar_bump_version.sql', 'ONGOING');

UPDATE AdminVar SET `value` = '4.2.1' WHERE `name` = 'schemaVersion';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_08_19_AdminVar_bump_version.sql';
