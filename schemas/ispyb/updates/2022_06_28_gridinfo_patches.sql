INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_06_28_gridinfo_patches.sql', 'ONGOING');

ALTER TABLE GridInfo
    ADD patches_x int(10) DEFAULT 1 COMMENT 'Number of patches the grid is made up of in the X direction',
    ADD patches_y int(10) DEFAULT 1 COMMENT 'Number of patches the grid is made up of in the Y direction';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_06_28_gridinfo_patches.sql';
