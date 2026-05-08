-- To undo:
-- drop table MillingStep;
-- drop table MillingStepName;
-- delete from SchemaStatus where scriptName = '2026_05_08_MillingStep_table.sql';


INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_05_08_MillingStep_table.sql', 'ONGOING');

CREATE TABLE MillingStepName (
    millingStepNameId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    step varchar(45) NOT NULL,
    recipe varchar(45) NOT NULL
) COMMENT "Milling step names and recipes";

INSERT INTO MillingStepName (step, recipe) VALUES
    ("Eucentric Tilt", "Preparation"),
    ("Artificial Features", "Preparation"),
    ("Milling Angle", "Preparation"),
    ("Image Acquisition", "Preparation"),
    ("Lamella Placement", "Preparation"),
    ("Milling", "Preparation"),
    ("Delay", "Milling"),
    ("Reference Definition", "Milling"),
    ("Electron Reference Definition", "Milling"),
    ("Stress Relief Cuts", "Milling"),
    ("Reference Redefinition 1", "Milling"),
    ("Rough Milling", "Milling"),
    ("Rough Milling - Electron Image", "Milling"),
    ("Reference Redefinition 2", "Milling"),
    ("Medium Milling", "Milling"),
    ("Medium Milling - Electron Image", "Milling"),
    ("Fine Milling", "Milling"),
    ("Fine Milling - Electron Image", "Milling"),
    ("Finer Milling", "Milling"),
    ("Finer Milling - Electron Image", "Milling"),
    ("Thinning", "Milling"),
    ("Delay", "Thinning"),
    ("Polishing 1", "Thinning"),
    ("Polishing 1 - Electron Image", "Thinning"),
    ("Polishing 2", "Thinning"),
    ("Polishing 2 - Ion Image", "Thinning"),
    ("Polishing 2 - Electron Image", "Thinning");

CREATE TABLE MillingStep (
    millingStepId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    millingStepNameId int(11) unsigned,
    isEnabled tinyint(1) DEFAULT 0 COMMENT "This marks whether the milling step is enabled and queued up; when the FIB starts this step, it will be set to False",
    status enum("Finished", "Failed", "Aborted") COMMENT "Describes the status of the milling step",
    executionTime float COMMENT "The time in seconds the step took to complete",
    stageX float COMMENT "Stage position in metres",
    stageY float COMMENT "Stage position in metres",
    stageZ float COMMENT "Stage position in metres",
    rotation float COMMENT "Rotation of stage in xy plane in degrees",
    alphaTilt float COMMENT "Unit: degrees",
    beamType enum("Electron", "Ion") COMMENT "Type of beam used",
    beamVoltage float COMMENT "Unit: volts",
    beamCurrent float COMMENT "Unit: amperes",
    millingAngle float COMMENT "The angle the stage is tilted to for milling, in degrees",
    depthCorrection float,
    lamellaOffset float COMMENT "Unit: metres",
    trenchHeightFront float COMMENT "Unit: metres",
    trenchHeightRear float COMMENT "Unit: metres",
    widthOverlapFrontLeft float COMMENT "Unit: metres",
    widthOverlapFrontRight float COMMENT "Unit: metres",
    widthOverlapRearLeft float COMMENT "Unit: metres",
    widthOverlapRearRight float COMMENT "Unit: metres",
    gridSquareId int(11) unsigned NOT NULL,
    CONSTRAINT MillingStep_fk_gridSquareId
      FOREIGN KEY (gridSquareId)
        REFERENCES GridSquare (gridSquareId)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
    CONSTRAINT MillingStep_fk_millingStepNameId
      FOREIGN KEY (millingStepNameId)
        REFERENCES MillingStepName (millingStepNameId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = "FIB Milling Step";

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_05_08_MillingStep_table.sql';
