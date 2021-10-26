INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_09_14_RelativeIceThickness.sql', 'ONGOING');

CREATE TABLE RelativeIceThickness (
   relativeIceThicknessId int(11) unsigned NOT NULL AUTO_INCREMENT,
   motionCorrectionId int(11) unsigned DEFAULT NULL,
   autoProcProgramId int(11) unsigned DEFAULT NULL,
   minimum float DEFAULT NULL COMMENT 'Minimum relative ice thickness, Unitless',
   q1 float DEFAULT NULL COMMENT 'Quartile 1, unitless',
   median float DEFAULT NULL COMMENT 'Median relative ice thickness, Unitless',
   q3 float DEFAULT NULL COMMENT 'Quartile 3, unitless',
   maximum float DEFAULT NULL COMMENT 'Minimum relative ice thickness, Unitless',
   PRIMARY KEY (relativeIceThicknessId),
   KEY `RelativeIceThickness_fk_programId` (autoProcProgramId),
   KEY `RelativeIceThickness_fk_motionCorrectionId` (motionCorrectionId),
   CONSTRAINT `RelativeIceThickness_fk_programId`
     FOREIGN KEY (`autoProcProgramId`)
       REFERENCES `AutoProcProgram` (`autoProcProgramId`)
         ON DELETE NO ACTION ON UPDATE CASCADE,
     CONSTRAINT `RelativeIceThickness_fk_motionCorrectionId`
       FOREIGN KEY (`MotionCorrectionId`)
         REFERENCES `MotionCorrection` (`motionCorrectionId`)
           ON DELETE NO ACTION ON UPDATE CASCADE
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_09_14_RelativeIceThickness.sql';
