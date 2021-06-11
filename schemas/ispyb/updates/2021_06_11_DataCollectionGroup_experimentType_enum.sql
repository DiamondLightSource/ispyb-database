INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_06_11_DataCollectionGroup_experimentType_enum.sql', 'ONGOING');

ALTER TABLE `DataCollectionGroup`
	MODIFY `experimentType` enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh','Burn','MAD - Inverse Beam','Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg','single particle','Serial Fixed','Serial Jet','Standard','Time Resolved','Diamond Anvil High Pressure','Custom','XRF map','Energy scan','XRF spectrum','XRF map xas','Mesh3D', 'Screening') DEFAULT NULL COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';

INSERT INTO ExperimentType (experimentTypeId, name, proposalType, active) VALUES (35, 'Screening', 'sm', 1);
  
UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2021_06_11_DataCollectionGroup_experimentType_enum.sql';
