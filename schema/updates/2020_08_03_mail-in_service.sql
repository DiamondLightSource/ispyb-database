INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_03_mail-in_service.sql', 'ONGOING');

ALTER TABLE Dewar
  MODIFY `type` enum('Dewar','Toolbox', 'Parcel') NOT NULL DEFAULT 'Dewar';

ALTER TABLE ComponentSubType
  ADD proposalType varchar(10),
  ADD active boolean DEFAULT 1 COMMENT '1=active, 0=inactive';

INSERT INTO ComponentSubType (componentSubTypeId, name, hasPh, proposalType)
  VALUES 
    (4, 'Cell', 0, 'scm'),
    (5, 'Matrix', 0, 'scm'),
    (6, 'Powder', 0, 'scm'),
    (7, 'Solution', 1, 'scm'),
    (8, 'Powder', 0, 'i11');

ALTER TABLE ConcentrationType
  ADD proposalType varchar(10),
  ADD active boolean DEFAULT 1 COMMENT '1=active, 0=inactive';

INSERT INTO ConcentrationType (concentrationTypeId, name, symbol, proposalType)
  VALUES 
    (6, 'Microlitre', 'uL', 'scm'),
    (7, 'Millilitre', 'ml', 'scm');
--    (8, 'Millilitre / Milligrams', 'ml/mg', 'scm'); -- probably meant mg/ml


-- Alternative 1: Add even more to the experimentKind enum:
/*
ALTER TABLE DiffractionPlan
  MODIFY `experimentKind` enum('Default','MXPressE','MXPressO','MXPressE_SAD','MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement','OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE','Stepped transmission','XChem High Symmetry','XChem Low Symmetry','Commissioning',
  -- New enum options - needs review: 
  'HPLC', 'Robot', 'Rack', 'Grid', 'Solids', 'Powder', 'Peltier', 'Spectroscopy', 'CD Spectroscopy', 'Microscopy', 'Imaging', 'CD Thermal Melt', 'Fixed Energy At Ambient With Robot') DEFAULT NULL,
*/
--
-- Alternative 2: Create an ExperimentKind lookup table. 
-- This can be added now, and then we can worry about migrating the
-- DiffractionPlan.experimentKind enum to the new lookup table later, thereby
-- avoiding to break software that depends on the experimentKind enum

CREATE TABLE ExperimentType (
  experimentTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
)
COMMENT 'A lookup table for different types of experients';

INSERT INTO ExperimentType (experimentTypeId, name, proposalType)
  VALUES
    (1, 'Default', NULL),
    (2, 'MXPressE', NULL),
    (3, 'MXPressO', NULL),
    (4, 'MXPressE_SAD', NULL),
    (5, 'MXScore', NULL),
    (6, 'MXPressM', NULL),
    (7, 'MAD', 'MX'),
    (8, 'SAD', 'MX'),
    (9, 'Fixed', NULL),
    (10, 'Ligand binding', 'mx'),
    (11, 'Refinement', NULL),
    (12, 'OSC', 'MX'),
    (13, 'MAD - Inverse Beam', 'mx'),
    (14, 'SAD - Inverse Beam', 'mx'),
    (15, 'MESH', 'mx'),
    (16, 'XFE', 'mx'),
    (17, 'Stepped transmission', 'mx'),
    (18, 'XChem High Symmetry', NULL),
    (19, 'XChem Low Symmetry', NULL),
    (20, 'Commissioning', NULL),
    (21, 'HPLC', 'scm'),
    (22, 'Robot', 'scm'),
    (23, 'Rack', 'scm'),
    (24, 'Grid', 'scm'),
    (25, 'Solids', 'scm'),
    (26, 'Powder', 'scm'),
    (27, 'Peltier', 'scm'),
    (28, 'Spectroscopy', 'scm'),
    (29, 'CD Spectroscopy', 'scm'),
    (30, 'Microscopy', 'scm'),
    (31, 'Imaging', 'scm'),
    (32, 'CD Thermal Melt', 'scm'),
    (33, 'Fixed Energy At Ambient With Robot', 'scm');
--

-- 'Column' is a reserved word, so we should probably try to find a different 
-- name for this table.
CREATE TABLE PurificationColumn (
  purificationColumnId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
)
COMMENT 'Size exclusion chromotography (SEC) lookup table for BioSAXS';

INSERT INTO PurificationColumn (purificationColumnId, name)
  VALUES
    (1, 'user supplied'),
    (2, 's75'),
    (3, 's200'),
    (4, 'superose6'),
    (5, 'kw402.5'),
    (6, 'kw403'),
    (7, 'kw404'),
    (8, 'kw405');

ALTER TABLE DiffractionPlan
  ADD purificationColumnId int unsigned,
  ADD experimentTypeId int unsigned,
  ADD robotPlateTemperature float COMMENT 'units: ',
  ADD exposureTemperature float COMMENT 'units: ',
  ADD qMin float COMMENT 'minimum in qRange',
  ADD qMax float COMMENT 'maximum in qRange',
  ADD reductionParametersAveraging enum('All', 'Fastest Dimension', '1D') COMMENT '',
  ADD CONSTRAINT `DiffractionPlan_ibfk2` FOREIGN KEY (`purificationColumnId`)
    REFERENCES `PurificationColumn` (`purificationColumnId`),
  ADD CONSTRAINT `DiffractionPlan_ibfk3` FOREIGN KEY (`experimentTypeId`)
    REFERENCES `ExperimentType` (`experimentTypeId`);

ALTER TABLE DataCollectionGroup
  ADD experimentTypeId int unsigned,
  ADD CONSTRAINT `DataCollectionGroup_ibfk_4`
    FOREIGN KEY (`experimentTypeId`)
      REFERENCES `ExperimentType` (`experimentTypeId`);

ALTER TABLE BLSample
  ADD isotropy enum('isotropic', 'anisotropic') DEFAULT NULL;

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

-- Alternative 1: 

/*
ALTER TABLE BLSampleGroup_has_BLSample
  MODIFY `type` enum('background','container','sample','calibrant', 'buffer') DEFAULT NULL;
*/

-- Alternative 2:

CREATE TABLE BLSampleGroupType (
  blSampleGroupTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
);

INSERT INTO BLSampleGroupType (blSampleGroupTypeId, name, proposalType)
  VALUES
    (1, 'background', 'xpdf'),
    (2, 'container', 'xpdf'),
    (3, 'sample', 'xpdf'),
    (4, 'calibrant', 'xpdf'),
    (5, 'buffer', 'scm'),
    (6, 'sample', 'scm'),
    (7, 'sample', 'mx');

ALTER TABLE BLSampleGroup_has_BLSample
  ADD blSampleGroupTypeId int unsigned,
  ADD CONSTRAINT `BLSampleGroup_has_BLSample_ibfk3` FOREIGN KEY (`blSampleGroupTypeId`) REFERENCES `BLSampleGroupType` (`blSampleGroupTypeId`);
--

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_08_03_mail-in_service.sql';
