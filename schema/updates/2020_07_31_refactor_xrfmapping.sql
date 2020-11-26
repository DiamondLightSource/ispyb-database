INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_07_31_refactor_xrfmapping.sql', 'ONGOING');


DROP TABLE IF EXISTS `XRFFluorescenceMapping`;
CREATE TABLE `XRFFluorescenceMapping` (
  `xrfFluorescenceMappingId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `xrfFluorescenceMappingROIId` int(11) unsigned NOT NULL,
  `gridInfoId` int(11) unsigned NOT NULL,
  `dataFormat` varchar(15) NOT NULL COMMENT 'Description of format and any compression, i.e. json+gzip for gzipped json',
  `data` LONGBLOB NOT NULL COMMENT 'The actual data',
  `points` int(11) UNSIGNED DEFAULT NULL COMMENT 'The number of points available, for realtime feedback',
  `opacity` FLOAT NOT NULL DEFAULT '1' COMMENT 'Display opacity',
  `colourMap` VARCHAR(20) DEFAULT NULL COMMENT 'Colour map for displaying the data',
  `min` INT(3) DEFAULT NULL COMMENT 'Min value in the data for histogramming',
  `max` INT(3) DEFAULT NULL COMMENT 'Max value in the data for histogramming',
  PRIMARY KEY (`xrfFluorescenceMappingId`),
  CONSTRAINT `XRFFluorescenceMapping_ibfk1`
      FOREIGN KEY (`xrfFluorescenceMappingROIId`)
          REFERENCES `XRFFluorescenceMappingROI` (`xrfFluorescenceMappingROIId`)
              ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `XRFFluorescenceMapping_ibfk2`
      FOREIGN KEY (`gridInfoId`)
          REFERENCES `GridInfo` (`gridInfoId`)
              ON DELETE RESTRICT ON UPDATE RESTRICT
)
COMMENT 'An XRF map generated from an XRF Mapping ROI based on data from a gridscan of a sample'
ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `XRFFluorescenceMappingROI`
    ADD `blSampleId` INT UNSIGNED NULL COMMENT 'ROIs can be created within the context of a sample',
    ADD CONSTRAINT `XRFFluorescenceMappingROI_FKblSampleId`
      FOREIGN KEY (`blSampleId`)
          REFERENCES `BLSample`(`blSampleId`) 
              ON DELETE RESTRICT ON UPDATE RESTRICT,
    ADD `scalar` VARCHAR(50) NULL DEFAULT NULL COMMENT 'For ROIs that are not an element, i.e. could be a scan counter instead',
    CHANGE `edge` `edge` VARCHAR(15) NULL DEFAULT NULL COMMENT 'Edge type i.e. Ka1, could be a custom edge in case of overlap Ka1-noCa';


CREATE TABLE `XFEFluorescenceComposite` ( 
    `xfeFluorescenceCompositeId` INT UNSIGNED NOT NULL AUTO_INCREMENT , 
    `r` INT UNSIGNED NOT NULL COMMENT 'Red layer', 
    `g` INT UNSIGNED NOT NULL COMMENT 'Green layer', 
    `b` INT UNSIGNED NOT NULL COMMENT 'Blue layer', 
    `rOpacity` FLOAT NOT NULL DEFAULT '1' COMMENT 'Red layer opacity',
    `bOpacity` FLOAT NOT NULL DEFAULT '1' COMMENT 'Red layer opacity',
    `gOpacity` FLOAT NOT NULL DEFAULT '1' COMMENT 'Red layer opacity',
    `opacity` FLOAT NOT NULL DEFAULT '1' COMMENT 'Total map opacity',
    PRIMARY KEY (`xfeFluorescenceCompositeId`),
    CONSTRAINT `XFEFluorescenceComposite_ibfk1`
        FOREIGN KEY (`r`)
            REFERENCES `XRFFluorescenceMapping`(`xrfFluorescenceMappingId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `XFEFluorescenceComposite_ibfk2`
        FOREIGN KEY (`g`)
            REFERENCES `XRFFluorescenceMapping`(`xrfFluorescenceMappingId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `XFEFluorescenceComposite_ibfk3`
        FOREIGN KEY (`b`)
            REFERENCES `XRFFluorescenceMapping`(`xrfFluorescenceMappingId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT
    )
    COMMENT 'A composite XRF map composed of three XRFFluorescenceMapping entries creating r, g, b layers'
    ENGINE = InnoDB;


UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2020_07_31_refactor_xrfmapping.sql';
