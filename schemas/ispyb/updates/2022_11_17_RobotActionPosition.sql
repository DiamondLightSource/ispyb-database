INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_11_17_RobotActionPosition.sql', 'ONGOING');

CREATE TABLE `RobotActionPosition` (
  `robotActionPositionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `robotActionId` int(11) unsigned NOT NULL,
  `type` enum('reference', 'real'),
  `id` tinyint(3),
  `posX` double DEFAULT NULL,
  `posY` double DEFAULT NULL,
  `posZ` double DEFAULT NULL,
  PRIMARY KEY (`robotActionPositionId`),
  KEY `RobotAction_has_Position_fk1` (`robotActionId`),
  CONSTRAINT `RobotAction_has_Position_fk1` FOREIGN KEY (`robotActionId`) REFERENCES `RobotAction` (`robotActionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT 'Store a series of x,y(,z) positions along with a Robot(Sample)Action';

ALTER TABLE `RobotAction`
	CHANGE `actionType` `actionType` ENUM('LOAD','UNLOAD','DISPOSE','STORE','WASH','ANNEAL','MOSAIC','REFERENCE') DEFAULT NULL,
    ADD `resultFilePath` varchar(255) DEFAULT NULL;

ALTER TABLE `BLSubSample`
    CHANGE `source` `source` enum('manual','auto','reference') DEFAULT 'manual';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_11_17_RobotActionPosition.sql';
