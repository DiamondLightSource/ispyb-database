INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_13_Dewar_facilityCode.sql', 'ONGOING');

ALTER TABLE Dewar CHANGE `FACILITYCODE` `facilityCode` varchar(20) DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_13_Dewar_facilityCode.sql';
