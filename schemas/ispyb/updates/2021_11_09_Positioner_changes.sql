INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_11_09_Positioner_changes.sql', 'ONGOING');

ALTER TABLE Positioner
  ADD beamlineName varchar(10) COMMENT 'The beamline this motor is on';

-- Write your own statement to populate beamlineName for existing positioners:
-- UPDATE Positioner SET beamlineName = ...

ALTER TABLE BLSample_has_Positioner
  ADD `value` float COMMENT 'The position of this positioner for this blsample',
  ADD recordTimeStamp datetime COMMENT 'Time that this position was added';

UPDATE BLSample_has_Positioner bhp
  SET bhp.`value` = (SELECT `value` FROM Positioner WHERE positionerId = bhp.positionerId);

ALTER TABLE Positioner
  DROP `value`;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_11_09_Positioner_changes.sql';
