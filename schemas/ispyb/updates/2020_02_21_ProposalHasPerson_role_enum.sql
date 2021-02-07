INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_02_21_ProposalHasPerson_role_enum.sql', 'ONGOING');

ALTER TABLE ProposalHasPerson MODIFY `role` enum('Co-Investigator','Principal Investigator','Alternate Contact', 'ERA Admin') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_02_21_ProposalHasPerson_role_enum.sql';
