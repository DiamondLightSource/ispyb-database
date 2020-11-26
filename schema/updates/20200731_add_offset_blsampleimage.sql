INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200731_add_offset_blsampleimage.sql', 'ONGOING');

ALTER TABLE `BLSampleImage`
	ADD `offsetX` INT NOT NULL DEFAULT 0 COMMENT 'The x offset of the image relative to the canvas',
	ADD `offsetY` INT NOT NULL DEFAULT 0 COMMENT 'The y offset of the image relative to the canvas';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200731_add_offset_blsampleimage.sql';
