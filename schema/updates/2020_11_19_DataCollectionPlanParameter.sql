INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_19_DataCollectionPlanParameter.sql', 'ONGOING');

CREATE TABLE `DataCollectionPlanParameter` (
  `dataCollectionPlanParameterId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionPlanId` int(11) unsigned DEFAULT NULL,
  `parameterKey` varchar(80) DEFAULT NULL COMMENT 'E.g. qMin, qMax, ...',
  `parameterValue` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`dataCollectionPlanParameterId`),
  CONSTRAINT `DataCollectionPlanParameter_dataCollectionPlanId` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`)
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_19_DataCollectionPlanParameter.sql';
