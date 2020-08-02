INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_03_mail-in_service.sql', 'ONGOING');

ALTER TABLE Dewar
  MODIFY `type` enum('Dewar','Toolbox', 'Parcel') NOT NULL DEFAULT 'Dewar';

INSERT INTO ComponentSubType (componentSubTypeId, name, hasPh) 
  VALUES 
    (4, 'Cell', 0), 
    (5, 'Matrix', 0), 
    (6, 'Powder', 0), 
    (7, 'Solution', 1);

INSERT INTO ConcentrationType (concentrationTypeId, name, symbol) 
  VALUES 
    (6, 'Microlitre', 'uL'), 
    (7, 'Millilitre / Milligrams', 'ml/mg'), 
    (8, 'Millilitre', 'ml');


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
  proposalType varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
);

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
    (10, 'Ligand binding', 'MX'),
    (11, 'Refinement', NULL),
    (12, 'OSC', 'MX'),
    (13, 'MAD - Inverse Beam', 'MX'),
    (14, 'SAD - Inverse Beam', 'MX'),
    (15, 'MESH', 'MX'),
    (16, 'XFE', 'MX'),
    (17, 'Stepped transmission', 'MX'),
    (18, 'XChem High Symmetry', NULL),
    (19, 'XChem Low Symmetry', NULL),
    (20, 'Commissioning', NULL),
    (21, 'HPLC', 'SCM'),
    (22, 'Robot', 'SCM'),
    (23, 'Rack', 'SCM'),
    (24, 'Grid', 'SCM'),
    (25, 'Solids', 'SCM'),
    (26, 'Powder', 'SCM'),
    (27, 'Peltier', 'SCM'),
    (28, 'Spectroscopy', 'SCM'),
    (29, 'CD Spectroscopy', 'SCM'),
    (30, 'Microscopy', 'SCM'),
    (31, 'Imaging', 'SCM'),
    (32, 'CD Thermal Melt', 'SCM'),
    (33, 'Fixed Energy At Ambient With Robot', 'SCM');
--

-- 'Column' is a reserved word, so we should probably try to find a different 
-- name for this table.
CREATE TABLE `Column` (
  columnId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
) COMMENT 'Experimental conditions lookup table for BioSAXS';

INSERT INTO `Column` (columnId, name) 
  VALUES 
    (1, 's75'),
    (2, 's200'),
    (3, 'superose6'),
    (4, 'kw402.5'),
    (5, 'kw403'),
    (6, 'kw404'),
    (7, 'kw405'),
    (8, 'user supplied');

ALTER TABLE DiffractionPlan 
  ADD columnId int unsigned,
  ADD experimentTypeId int unsigned,
  ADD robotPlateTemperature float COMMENT 'units: ',
  ADD exposureTemperature float COMMENT 'units: ',  
  ADD qMin float COMMENT 'minimum in qRange', 
  ADD qMax float COMMENT 'maximum in qRange',
  ADD reductionParametersAveraging enum('All', 'Fastest Dimension', '1D') COMMENT '',
  ADD CONSTRAINT `DiffractionPlan_ibfk2` FOREIGN KEY (`columnId`) REFERENCES `Column` (`columnId`),
  ADD CONSTRAINT `DiffractionPlan_ibfk3` FOREIGN KEY (`experimentTypeId`) REFERENCES `ExperimentType` (`experimentTypeId`);

ALTER TABLE BLSample
  ADD isotropy enum('isotropic', 'anisotropic') DEFAULT NULL;

CREATE TABLE ContainerType (
  containerTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive',
  capacity int,
  dropPerWellX smallint, 
  dropPerWellY smallint,
  dropHeight float,
  dropWidth float,
  dropOffsetX float,
  dropOffsetY float,
  wellDrop smallint
);

INSERT INTO ContainerType (containerTypeId, name, proposalType)
  VALUES
    (1, 'B21_8+1', ''),
    (2, 'B21_96', ''),
    (3, 'B21_1tube', ''),
    (4, 'I22_Capillary_Rack_20', ''),
    (5, 'I22_Grid_100', ''),
    (6, 'I22_Grid_45', ''),
    (7, 'P38_Capillary_Rack_27', ''),
    (8, 'P38_Solids', ''),
    (9, 'P38_Powder', ''),
    (10, 'B22_6', ''),
    (11, 'I11_Capillary_Rack_6', '');

ALTER TABLE Container
  MODIFY `storageTemperature` float DEFAULT NULL COMMENT 'NULL=ambient',
  ADD containerTypeId int unsigned,
  ADD CONSTRAINT `Container_ibfk10` FOREIGN KEY (`containerTypeId`) REFERENCES `ContainerType` (`containerTypeId`);

-- Alternative 1: 

ALTER TABLE BLSampleGroup_has_BLSample
  MODIFY `type` enum('background','container','sample','calibrant', 'buffer') DEFAULT NULL;
  
--
-- Alternative 2:
/*
CREATE TABLE BLSampleGroupType (
  blSampleGroupTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
);

INSERT INTO BLSampleGroupType (blSampleGroupTypeId, name)
  VALUES
    (1, 'background'),
    (2, 'container'),
    (3, 'sample'),
    (4, 'calibrant'),
    (5, 'buffer');

ALTER TABLE BLSampleGroup_has_BLSample
  ADD blSampleGroupTypeId int unsigned,
  ADD CONSTRAINT `BLSampleGroup_has_BLSample_ibfk3` FOREIGN KEY (`blSampleGroupTypeId`) REFERENCES `BLSampleGroupType` (`blSampleGroupTypeId`);
--
*/

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_08_03_mail-in_service.sql';
