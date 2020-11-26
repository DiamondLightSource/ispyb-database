INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200731_extend_dcg_type_enum.sql', 'ONGOING');

ALTER TABLE `RobotAction`
	CHANGE `actionType` `actionType` ENUM('LOAD','UNLOAD','DISPOSE','STORE','WASH','ANNEAL','MOSAIC') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200731_extend_dcg_type_enum.sql';
