INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_11_12_BLSampleImage_fullImagePath_idx.sql', 'ONGOING');

CREATE UNIQUE INDEX BLSampleImage_imageFullPath ON BLSampleImage(imageFullPath);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_11_12_BLSampleImage_fullImagePath_idx.sql';
