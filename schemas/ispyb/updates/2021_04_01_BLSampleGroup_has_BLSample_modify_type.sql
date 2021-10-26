INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2021_04_01_BLSampleGroup_has_BLSample_modify_type.sql', 'ONGOING');

ALTER TABLE BLSampleGroup_has_BLSample
  MODIFY type enum('background','container','sample','calibrant','capillary') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2021_04_01_BLSampleGroup_has_BLSample_modify_type.sql';