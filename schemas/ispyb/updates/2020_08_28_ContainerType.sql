INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_ContainerType.sql', 'ONGOING');
  
CREATE TABLE ContainerType (
  containerTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive',
  capacity int,
  wellPerRow smallint,
  dropPerWellX smallint, 
  dropPerWellY smallint,
  dropHeight float,
  dropWidth float,
  dropOffsetX float,
  dropOffsetY float,
  wellDrop smallint
)
COMMENT 'A lookup table for different types of containers';

INSERT INTO ContainerType (containerTypeId, name, proposalType)
  VALUES
    (1, 'B21_8+1', 'scm'),
    (2, 'B21_96', 'scm'),
    (3, 'B21_1tube', 'scm'),
    (4, 'I22_Capillary_Rack_20', 'scm'),
    (5, 'I22_Grid_100', 'scm'),
    (6, 'I22_Grid_45', 'scm'),
    (7, 'P38_Capillary_Rack_27', 'scm'),
    (8, 'P38_Solids', 'scm'),
    (9, 'P38_Powder', 'scm'),
    (10, 'B22_6', 'scm'),
    (11, 'I11_Capillary_Rack_6', 'scm');

INSERT INTO ContainerType (containerTypeId, name, capacity, proposalType)
  VALUES
    (12, 'Puck', 16, 'mx');

INSERT INTO ContainerType (containerTypeId, name, wellPerRow, dropPerWellX, dropPerWellY, dropHeight, dropWidth, dropOffsetX, dropOffsetY, wellDrop, capacity, proposalType)
  VALUES
    (13, 'ReferencePlate',        2, 1, 1,   1,   1, 0,   0, -1,   16,   'mx'),
    (14, 'CrystalQuickX',        12, 2, 1, 0.5,   1, 0,   0, -1, 96*2,   'mx'),
    (15, 'MitegenInSitu',        12, 2, 1, 0.5,   1, 0,   0, -1, 96*2,   'mx'),
    (16, 'FilmBatch',            12, 1, 1,   1,   1, 0,   0, -1,   96,   'mx'),
    (17, 'MitegenInSitu_3_Drop', 12, 3, 1, 0.5,   1, 0,   0, -1, 96*3,   'mx'),
    (18, 'Greiner 3 Drop',       12, 3, 1, 0.5,   1, 0,   0, -1, 96*3,   'mx'),
    (19, 'MRC Maxi',              6, 1, 1,   1, 0.5, 0,   0, -1,   48,   'mx'),
    (20, 'MRC 2 Drop',           12, 1, 2,   1, 0.5, 0.5, 0, -1, 96*2,   'mx'),
    (21, 'Griener 1536',         12, 4, 4,   1,   1, 0,   0, -1, 96*4*4, 'mx'),
    (22, '3 Drop Square',        12, 2, 2,   1,   1, 0,   0,  3, 96*3,   'mx'),
    (23, 'SWISSCI 3 Drop',       12, 2, 2,   1,   1, 0,   0,  1, 96*3,   'mx'),
    (24, '1 drop',               12, 1, 1, 0.5, 0.5, 0,   0, -1,   96,   'mx'),
    (25, 'LCP Glass',            12, 1, 1,   1,   1, 0,   0, -1,   96,   'mx'),
    (26, 'PCRStrip',              9, 1, 1,   1,   1, 0,   0, -1,    9,  'scm');

ALTER TABLE Container
  MODIFY `storageTemperature` float DEFAULT NULL COMMENT 'NULL=ambient',
  ADD containerTypeId int unsigned,
  ADD CONSTRAINT `Container_ibfk10` FOREIGN KEY (`containerTypeId`) REFERENCES `ContainerType` (`containerTypeId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_ContainerType.sql';