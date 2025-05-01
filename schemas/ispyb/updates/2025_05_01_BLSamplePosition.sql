INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_01_BLSamplePosition.sql', 'ONGOING');

CREATE TABLE `BLSamplePosition` (
  `positionId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `blSampleId` int(11) unsigned NOT NULL COMMENT 'FK, references parent sample',
  `posX` double DEFAULT NULL,
  `posY` double DEFAULT NULL,
  `posZ` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `positionType` enum('dispensing') COMMENT 'Type of marked position (e.g.: dispensing location)',
  PRIMARY KEY (`positionId`),
  CONSTRAINT `BLSamplePosition_fk_blSampleId` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`)
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_01_BLSamplePosition.sql';
