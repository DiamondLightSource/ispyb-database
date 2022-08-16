INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_06_28_diffractionplan_scanparameters.sql', 'ONGOING');

ALTER TABLE DiffractionPlan
    ADD `scanParameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`scanParameters`)) COMMENT 'JSON serialised scan parameters, useful for parameters without designated columns';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_06_28_diffractionplan_scanparameters.sql';
