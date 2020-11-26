INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200731_extend_dcg_type_enum.sql', 'ONGOING');

ALTER TABLE `DataCollectionGroup`
	CHANGE `experimentType` `experimentType` enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh','Burn','MAD - Inverse Beam','Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg','single particle','Serial Fixed','Serial Jet','Standard','Time Resolved','Diamond Anvil High Pressure','Custom','XRF map','Energy scan','XRF spectrum','XRF map xas') DEFAULT NULL COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';
  
UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200731_extend_dcg_type_enum.sql';
