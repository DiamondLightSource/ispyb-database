INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_22_diffractionplan_priority_and_mode.sql', 'ONGOING');

ALTER TABLE `DiffractionPlan`
	ADD `collectionMode` ENUM('auto', 'manual') NULL COMMENT 'The requested collection mode, possible values are auto, manual',
	ADD `priority` INT(4) NULL COMMENT 'The priority of this sample relative to others in the shipment';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2020_11_22_diffractionplan_priority_and_mode.sql';
