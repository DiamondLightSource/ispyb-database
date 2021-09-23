INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_09_23_BLSampleGroup_update_proposalId.sql', 'ONGOING');

-- This is only needed if you have BLSampleGroup rows where proposalId IS NULL

CREATE TEMPORARY TABLE sgrows (
  blSampleGroupId int(11) unsigned PRIMARY KEY, 
  proposalId int(10) unsigned
);

INSERT INTO sgrows (blSampleGroupId, proposalId)
  SELECT DISTINCT sg.blSampleGroupId, p.proposalId 
  FROM BLSampleGroup sg 
    JOIN BLSampleGroup_has_BLSample sghs ON sghs.blSampleGroupId = sg.blSampleGroupId
    JOIN BLSample s ON s.blSampleId = sghs.blSampleId
    JOIN Crystal c ON c.crystalId = s.crystalId
    JOIN Protein p ON p.proteinId = c.proteinId
  WHERE sg.proposalId IS NULL;

UPDATE BLSampleGroup sg
  JOIN sgrows ON sgrows.blSampleGroupId = sg.blSampleGroupId
  SET sg.proposalId = sgrows.proposalId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_09_23_BLSampleGroup_update_proposalId.sql';
