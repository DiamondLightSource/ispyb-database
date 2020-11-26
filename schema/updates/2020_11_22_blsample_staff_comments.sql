INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_22_blsample_staff_comments.sql', 'ONGOING');

ALTER TABLE `BLSample`
	ADD `staffComments` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Any staff comments on the sample';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2020_11_22_blsample_staff_comments.sql';
