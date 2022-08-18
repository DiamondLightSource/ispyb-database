INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_06_28_detector_rois.sql', 'ONGOING');

DROP TABLE IF EXISTS `DetectorROI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DetectorROI` (
  `detectorROIId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `detectorId` int(11) NOT NULL,
  `blSampleId` int(10) unsigned NOT NULL,
  `type` varchar(50) NOT NULL COMMENT 'The ROI type rectangle, arc, q range, etc', 
  `name` varchar(50) NOT NULL COMMENT 'A short name for this ROI',
  `blTimestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `definition` text NOT NULL COMMENT 'The ROI definition in json format' CHECK (json_valid(`definition`)),
  PRIMARY KEY (`detectorROIId`),
  KEY `detectorROI_fk1` (`detectorId`),
  KEY `detectorROI_fk2` (`blSampleId`),
  CONSTRAINT `detectorROI_fk1` FOREIGN KEY (`detectorId`) REFERENCES `Detector` (`detectorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detectorROI_fk2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT COMMENT='Store an ROI for a 2d detector against a particular sample';
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `XRFFluorescenceMapping`
  CHANGE `xrfFluorescenceMappingROIId` `xrfFluorescenceMappingROIId` int(11) unsigned NULL,
  ADD `detectorROIId` int(11) unsigned NULL,
  ADD CONSTRAINT `XRFFluorescenceMapping_ibfk4`
    FOREIGN KEY (`detectorROIId`)
      REFERENCES `DetectorROI`(`detectorROIId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_06_28_detector_rois.sql';
