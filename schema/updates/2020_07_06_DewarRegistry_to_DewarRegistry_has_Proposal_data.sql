INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_07_06_DewarRegistry_to_DewarRegistry_has_Proposal_data.sql', 'ONGOING');

INSERT INTO DewarRegistry_has_Proposal (dewarRegistryId, proposalId, labContactId, recordTimestamp) 
  SELECT dewarRegistryId, proposalId, labContactId, bltimestamp 
  FROM DewarRegistry
  ORDER BY dewarRegistryId ASC;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_07_06_DewarRegistry_to_DewarRegistry_has_Proposal_data.sql';
