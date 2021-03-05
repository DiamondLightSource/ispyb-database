INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_05_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType 
  SET capacity = 9, wellPerRow = 9, dropPerWellX = 1, dropPerWellY = 1, dropHeight = 1, dropWidth = 1, dropOffsetX = 0, dropOffsetY = 0, wellDrop = -1 
  WHERE containerTypeId = 1;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_05_ContainerType_update.sql';
