INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_03_27_GridInfo_micronsPerPixelXY.sql', 'ONGOING');

ALTER TABLE GridInfo
  ADD micronsPerPixelX float DEFAULT NULL,
  ADD micronsPerPixelY float DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_03_27_GridInfo_micronsPerPixelXY.sql';
