INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_04_13_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType SET name = 'Puck-22' WHERE proposalType = 'xpdf' AND name = 'Puck';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_04_13_ContainerType_update.sql';
