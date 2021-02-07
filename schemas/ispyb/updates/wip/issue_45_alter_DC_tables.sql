--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

ALTER TABLE DataCollectionFileAttachment
  MODIFY fileType enum('snapshot','log','xy','recip','pia','warning', 'scanFile', 'jpegScanFile', 'mcaFile', 'bestWilsonPlot') DEFAULT NULL,
  ADD `fileOrder` tinyint unsigned COMMENT 'For the particular dataCollectionId indicate the order of the attachment. 1 is the first, higher numbers are more later';

ALTER TABLE DataCollectionGroup
  MODIFY experimentType enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh','Burn','MAD - Inverse Beam','Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg','single particle','Serial Fixed','Serial Jet','Standard','Time Resolved','Diamond Anvil High Pressure','Custom', 'Energy scan', 'XRF spectrum') DEFAULT NULL COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';
