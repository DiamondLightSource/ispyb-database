INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_07_31_add_type_blsubsample.sql', 'ONGOING');

ALTER TABLE `BLSubSample`
	ADD `type` VARCHAR(10) DEFAULT NULL COMMENT 'The type of subsample, i.e. roi (region), poi (point), loi (line)';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2020_07_31_add_type_blsubsample.sql';
