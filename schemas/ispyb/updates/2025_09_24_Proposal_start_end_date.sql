INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_09_24_Proposal_start_end_date.sql', 'ONGOING');

ALTER TABLE Proposal
  ADD startDate datetime
    COMMENT 'Start of the allocation period',
  ADD endDate datetime
    COMMENT 'End of the allocation period',
  ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_09_24_Proposal_start_end_date.sql';
