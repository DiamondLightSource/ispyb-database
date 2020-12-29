INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_12_10_BLSubSample_source.sql', 'ONGOING');

ALTER TABLE BLSubSample
  ADD source enum('manual', 'auto') DEFAULT 'manual';

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_12_10_BLSubSample_source.sql';