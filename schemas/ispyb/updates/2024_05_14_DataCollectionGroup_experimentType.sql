INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_05_14_DataCollectionGroup_experimentType.sql', 'ONGOING');

ALTER TABLE DataCollectionGroup
  MODIFY experimentType enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh',
    'Burn','MAD - Inverse Beam','Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg',
    'single particle','Serial Fixed','Serial Jet','Standard','Time Resolved','Diamond Anvil High Pressure','Custom','XRF map',
    'Energy scan','XRF spectrum','XRF map xas','Mesh3D','Screening','Still','SSX-Chip','SSX-Jet', 'Metal ID')
    DEFAULT NULL
    COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';

INSERT INTO ExperimentType (
  experimentTypeId, name, proposalType, active
) VALUES (
  43, 'Metal ID', 'mx', 1
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_05_14_DataCollectionGroup_experimentType.sql';
