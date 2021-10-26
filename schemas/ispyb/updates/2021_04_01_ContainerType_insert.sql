INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_04_01_ContainerType_insert.sql', 'ONGOING');

INSERT INTO ContainerType (containerTypeId, name, capacity, proposalType, active) 
  VALUES 
    (27, 'Basket', NULL, 'mx', 0),   -- capacity varies, used by i24 most recently in 2016
    (28, 'Cane', NULL, 'mx', 0),     -- capacity varies, assumed mx, used most recently in 2013
    (29, 'Terasaki72', 72, 'mx', 0), -- used by i24 most recently in 2017
    (30, 'Puck-16', 16, 'mx', 1),    -- used by i24 most recently in 2020
    (31, 'Block-4', 16, 'mx', 1),    -- used by i23 most recently in 2021, all have capacity 16
    (32, 'Box', 25, 'xpdf', 1), 
    (33, 'Puck', 22, 'xpdf', 1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_04_01_ContainerType_insert.sql';
