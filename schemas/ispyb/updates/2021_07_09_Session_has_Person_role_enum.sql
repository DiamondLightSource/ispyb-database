INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_09_Session_has_Person_role_enum.sql', 'ONGOING');

ALTER TABLE Session_has_Person MODIFY `role` enum('Local Contact','Local Contact 2','Staff','Team Leader','Co-Investigator','Principal Investigator','Alternate Contact','Data Access','Team Member', 'ERA Admin', 'Associate') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_09_Session_has_Person_role_enum.sql';
