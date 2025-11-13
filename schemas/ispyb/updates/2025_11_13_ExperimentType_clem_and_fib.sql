INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_11_13_ExperimentType_clem_and_fib.sql', 'ONGOING');

INSERT INTO ExperimentType (
  experimentTypeId, name, proposalType, active
) VALUES (
  45, 'CLEM', 'em', 1,
  46, 'FIB', 'em', 1
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_11_13_ExperimentType_clem_and_fib.sql';
