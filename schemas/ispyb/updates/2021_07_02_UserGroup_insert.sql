INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_02_UserGroup_insert.sql', 'ONGOING');

INSERT INTO UserGroup (userGroupId, name) 
  VALUES 
    (45, 'detector_admin'),
    (47, 'prop_admin'),
    (50, 'goods_handling'),
    (53, 'imaging_admin'),
    (56, 'spectroscopy_admin'),
    (59, 'mm_admin');

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_02_UserGroup_insert.sql';
