INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_06_18_ContainerType_update.sql', 'ONGOING');

UPDATE ContainerType 
  SET capacity = 192, wellPerRow = 12, dropPerWellX = 2, dropPerWellY = 1, dropHeight = 0.5, dropWidth = 1, dropOffsetX = 0, dropOffsetY = 0, wellDrop = -1 
  WHERE containerTypeId = 2;

UPDATE ContainerType
  SET active = 0
  WHERE containerTypeId IN (4, 5, 6);

INSERT INTO ContainerType (containerTypeId, name, proposalType, active,
  capacity, wellPerRow, dropPerWellX, dropPerWellY, dropHeight, dropWidth, 
  dropOffsetX, dropOffsetY, wellDrop)
  VALUES (34, 'I22_Grid_81', 'saxs', 1, 81, 9, 1, 1, 1, 1, 0, 0, -1);

INSERT INTO ContainerType (containerTypeId, name, proposalType, active,
  capacity, wellPerRow, dropPerWellX, dropPerWellY, dropHeight, dropWidth, 
  dropOffsetX, dropOffsetY, wellDrop)
  VALUES (35, 'I22_Capillary_Rack_25', 'saxs', 1, 25, 25, 1, 1, 1, 1, 0, 0, -1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_06_18_ContainerType_update.sql';
