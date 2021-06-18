INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_06_18_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType 
  SET capacity = 192, wellPerRow = 12, dropPerWellX = 2, dropPerWellY = 1, dropHeight = 0.5, dropWidth = 1, dropOffsetX = 0, dropOffsetY = 0, wellDrop = -1 
  WHERE containerTypeId = 2;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_06_18_ContainerType_update.sql';
