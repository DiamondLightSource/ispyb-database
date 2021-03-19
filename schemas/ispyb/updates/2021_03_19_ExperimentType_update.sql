INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_19_ExperimentType_update.sql', 'ONGOING');

UPDATE ExperimentType SET proposalType = 'saxs' WHERE proposalType = 'scm';
UPDATE ExperimentType SET proposalType = 'mx' WHERE name = 'OSC';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_19_ExperimentType_update.sql';
