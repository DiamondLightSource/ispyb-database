INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_09_ProposalHasPerson_role_enum.sql', 'ONGOING');

ALTER TABLE ProposalHasPerson MODIFY `role` enum('Co-Investigator','Principal Investigator','Alternate Contact', 'ERA Admin', 'Associate') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_09_ProposalHasPerson_role_enum.sql';
