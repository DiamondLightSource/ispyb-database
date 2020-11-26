INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20201122_blsample_staff_comments.sql', 'ONGOING');

ALTER TABLE `BLSample`
	ADD `staffComments` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Any staff comments on the sample';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20201122_blsample_staff_comments.sql';
