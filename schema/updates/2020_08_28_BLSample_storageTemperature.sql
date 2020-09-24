INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_BLSample_storageTemperature.sql', 'ONGOING');
  
ALTER TABLE BLSample
  ADD `storageTemperature` float DEFAULT NULL COMMENT 'NULL=ambient';

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_BLSample_storageTemperature.sql';