INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_08_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType SET proposalType = 'saxs' WHERE proposalType = 'scm';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_08_ContainerType_update.sql';
