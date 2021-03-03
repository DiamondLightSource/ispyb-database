INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_03_BF_automationError.sql', 'ONGOING');

CREATE TABLE `BF_automationError` (
  `automationErrorId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `errorType` varchar(40) NOT NULL,
  `solution` text DEFAULT NULL,
  PRIMARY KEY (`automationErrorId`)
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_03_BF_automationError.sql';
