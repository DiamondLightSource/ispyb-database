INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_09_28_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType SET capacity = 4 WHERE containerTypeId=31 AND capacity=16 AND name='Block-4';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_09_28_ContainerType_update.sql';
