INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_11_05_RobotAction_new_type.sql', 'ONGOING');

ALTER TABLE RobotAction MODIFY COLUMN actionType ENUM('LOAD', 'UNLOAD', 'DISPOSE', 'STORE', 'WASH', 'ANNEAL', 'MOSAIC', 'LASER');

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_11_05_RobotAction_new_type.sql';
