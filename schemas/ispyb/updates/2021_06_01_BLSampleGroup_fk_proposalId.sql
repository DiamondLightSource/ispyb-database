INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_06_01_BLSampleGroup_fk_proposalId.sql', 'ONGOING');

ALTER TABLE BLSampleGroup
  ADD proposalId int(10) unsigned,
  ADD CONSTRAINT BLSampleGroup_fk_proposalId
    FOREIGN KEY (`proposalId`) 
      REFERENCES `Proposal` (`proposalId`) 
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE BLSampleGroup sg
  JOIN BLSampleGroup_has_BLSample sghs ON sghs.blSampleGroupId = sg.blSampleGroupId
  JOIN BLSample s ON s.blSampleId = sghs.blSampleId
  JOIN Crystal c ON c.crystalId = s.crystalId
  JOIN Protein p ON p.proteinId = c.proteinId
SET sg.proposalId = p.proposalId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_06_01_BLSampleGroup_fk_proposalId.sql';
