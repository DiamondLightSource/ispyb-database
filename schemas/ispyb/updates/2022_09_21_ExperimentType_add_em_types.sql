INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_09_21_ExperimentType_add_em_types.sql', 'ONGOING');

INSERT INTO ExperimentType (experimentTypeId, name, proposalType, active) 
  VALUES (36, 'Tomography', 'em', 1), (37, 'Single Particle', 'em', 1);

ALTER TABLE DataCollectionGroup
  MODIFY experimentType enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh','Burn','MAD - Inverse Beam',
    'Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg','single particle','Serial Fixed','Serial Jet','Standard',
    'Time Resolved','Diamond Anvil High Pressure','Custom','XRF map','Energy scan','XRF spectrum','XRF map xas','Mesh3D','Screening') 
    DEFAULT NULL
    COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_09_21_ExperimentType_add_em_types.sql';
