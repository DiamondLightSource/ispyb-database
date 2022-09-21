INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_09_21_ExperimentType_add_em_types.sql', 'ONGOING');

INSERT INTO ExperimentType (experimentTypeId, name, proposalType, active) 
  VALUES (36, 'Tomography', 'em', 1), (37, 'Single Particle', 'em', 1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_09_21_ExperimentType_add_em_types.sql';
