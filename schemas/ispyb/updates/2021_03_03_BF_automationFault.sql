INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_03_BF_automationFault.sql', 'ONGOING');

CREATE TABLE `BF_automationFault` (
  `automationFaultId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `automationErrorId` int(10) unsigned DEFAULT NULL,
  `containerId` int(10) unsigned DEFAULT NULL,
  `severity` enum('1','2','3') DEFAULT NULL,
  `stacktrace` text DEFAULT NULL,
  `resolved` tinyint(1) DEFAULT NULL,
  `faultTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`automationFaultId`),
  KEY `BF_automationFault_ibfk1` (`automationErrorId`),
  KEY `BF_automationFault_ibfk2` (`containerId`),
  CONSTRAINT `BF_automationFault_ibfk1` FOREIGN KEY (`automationErrorId`) REFERENCES `BF_automationError` (`automationErrorId`),
  CONSTRAINT `BF_automationFault_ibfk2` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`)
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_03_BF_automationFault.sql';
