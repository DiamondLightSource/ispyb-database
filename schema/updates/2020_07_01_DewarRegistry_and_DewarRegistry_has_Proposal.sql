INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_07_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql', 'ONGOING');

ALTER TABLE DewarRegistry
    MODIFY `proposalId` int(11) unsigned NULL,
    MODIFY `labContactId` int(11) unsigned NULL;

ALTER TABLE DewarRegistry_has_Proposal
    ADD labContactId int(11) unsigned NULL DEFAULT NULL COMMENT 'Owner of the dewar',
    ADD CONSTRAINT `DewarRegistry_has_Proposal_ibfk4` FOREIGN KEY (`labContactId`) REFERENCES `LabContact` (`labContactId`) ON DELETE NO ACTION ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_07_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql';
