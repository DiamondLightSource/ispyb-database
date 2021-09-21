INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_09_21_Proposal_add_hours.sql', 'ONGOING');

ALTER TABLE Proposal
  ADD allocatedHours decimal(10, 2),
  ADD scheduledHours decimal(10, 2),
  ADD usedHours decimal(10, 2);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_09_21_Proposal_add_hours.sql';
