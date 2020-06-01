INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_06_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql','ONGOING');

ALTER TABLE DewarRegistry
  DROP PRIMARY KEY,
  ADD dewarRegistryId int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
  ADD UNIQUE KEY (`facilityCode`);

CREATE TABLE `DewarRegistry_has_Proposal` (
  `dewarRegistryHasProposalId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dewarRegistryId` int(11) unsigned DEFAULT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL COMMENT 'Person registering the dewar',
  `recordTimestamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`dewarRegistryHasProposalId`),
  UNIQUE KEY `dewarRegistryId` (`dewarRegistryId`,`proposalId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk1` FOREIGN KEY (`dewarRegistryId`) REFERENCES `DewarRegistry` (`dewarRegistryId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk3` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`)
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_06_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql';
