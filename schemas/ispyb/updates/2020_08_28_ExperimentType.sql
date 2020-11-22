INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_ExperimentType.sql', 'ONGOING');

CREATE TABLE ExperimentType (
  experimentTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
)
COMMENT 'A lookup table for different types of experients';

ALTER TABLE DataCollectionGroup
  ADD experimentTypeId int unsigned,
  ADD CONSTRAINT `DataCollectionGroup_ibfk_4`
    FOREIGN KEY (`experimentTypeId`)
      REFERENCES `ExperimentType` (`experimentTypeId`);

ALTER TABLE DiffractionPlan
  ADD experimentTypeId int unsigned,
  ADD CONSTRAINT `DiffractionPlan_ibfk3` 
    FOREIGN KEY (`experimentTypeId`)
      REFERENCES `ExperimentType` (`experimentTypeId`);

INSERT INTO ExperimentType (experimentTypeId, name, proposalType)
  VALUES
    (1, 'Default', NULL),
    (2, 'MXPressE', 'mx'),
    (3, 'MXPressO', 'mx'),
    (4, 'MXPressE_SAD', 'mx'),
    (5, 'MXScore', 'mx'),
    (6, 'MXPressM', 'mx'),
    (7, 'MAD', 'mx'),
    (8, 'SAD', 'mx'),
    (9, 'Fixed', 'mx'),
    (10, 'Ligand binding', 'mx'),
    (11, 'Refinement', 'mx'),
    (12, 'OSC', 'MX'),
    (13, 'MAD - Inverse Beam', 'mx'),
    (14, 'SAD - Inverse Beam', 'mx'),
    (15, 'MESH', 'mx'),
    (16, 'XFE', 'mx'),
    (17, 'Stepped transmission', 'mx'),
    (18, 'XChem High Symmetry', 'mx'),
    (19, 'XChem Low Symmetry', 'mx'),
    (20, 'Commissioning', 'mx'),
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

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_ExperimentType.sql';