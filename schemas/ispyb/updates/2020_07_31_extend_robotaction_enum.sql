INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_07_31_extend_robotaction_enum.sql', 'ONGOING');

ALTER TABLE `RobotAction`
	CHANGE `actionType` `actionType` ENUM('LOAD','UNLOAD','DISPOSE','STORE','WASH','ANNEAL','MOSAIC') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2020_07_31_extend_robotaction_enum.sql';
