INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_03_18_ExperimentType_sxt.sql', 'ONGOING');

INSERT INTO ExperimentType (
  experimentTypeId, name, proposalType, active
) VALUES (47, 'Soft X-Ray Tomography', 'em', 1), (48, 'CryoSIM', 'em', 1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_03_18_ExperimentType_sxt.sql';
