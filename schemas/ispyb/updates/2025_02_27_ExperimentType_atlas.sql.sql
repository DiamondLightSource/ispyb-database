INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_02_27_ExperimentType_atlas.sql', 'ONGOING');

INSERT INTO ExperimentType (
  experimentTypeId, name, proposalType, active
) VALUES (
  44, 'Atlas', 'em', 1
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_02_27_ExperimentType_atlas.sql';
