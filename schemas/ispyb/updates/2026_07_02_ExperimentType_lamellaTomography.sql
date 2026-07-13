INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_07_02_ExperimentType_lamellaTomography.sql', 'ONGOING');

INSERT INTO ExperimentType (experimentTypeId, name, proposalType, active) VALUES(48, 'Lamella Tomography', 'em', 1);
INSERT INTO ExperimentType (experimentTypeId, name,proposalType,active) VALUES (49, 'Characterisation','mx',1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_07_02_ExperimentType_lamellaTomography.sql';


