INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200822_diffractionplan_aps.sql', 'ONGOING');

ALTER TABLE `DiffractionPlan`
	ADD `collectionMode` ENUM('automated', 'manual') NULL COMMENT 'The requested collection mode, possible values are automated, manual',
	ADD `priority` INT(4) NULL COMMENT 'The priority of this sample relative to others in the container';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200822_diffractionplan_aps.sql';
