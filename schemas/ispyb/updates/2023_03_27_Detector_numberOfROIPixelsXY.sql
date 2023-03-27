INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_03_27_Detector_numberOfROIPixelsXY.sql', 'ONGOING');

ALTER TABLE Detector
  ADD numberOfROIPixelsX mediumint DEFAULT NULL COMMENT 'Detector number of pixels in x in ROI mode',
  ADD numberOfROIPixelsY mediumint DEFAULT NULL COMMENT 'Detector number of pixels in y in ROI mode';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_03_27_Detector_numberOfROIPixelsXY.sql';
