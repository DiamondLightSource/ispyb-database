INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_03_cryoEMv2_0_tables.sql', 'ONGOING');

CREATE TABLE ParticlePicker (
  particlePickerId int unsigned auto_increment PRIMARY KEY,
  particlePickerProgramId int unsigned,
  particleClassificationProgramId int unsigned,
  firstMotionCorrectionId int unsigned,
  particlePickingTemplate varchar(255) COMMENT 'Cryolo model',
  particleDiameter float COMMENT 'Unit: nm',
  numberOfParticles int unsigned,
  CONSTRAINT `ParticlePicker_fk_particlePickerProgramId`
    FOREIGN KEY (`particlePickerProgramId`)
      REFERENCES `AutoProcProgram` (`autoProcProgramId`)
        ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ParticlePicker_fk_particleClassificationProgramId`
    FOREIGN KEY (`particleClassificationProgramId`)
      REFERENCES `AutoProcProgram` (`autoProcProgramId`)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT `ParticlePicker_fk_motionCorrectionId`
      FOREIGN KEY (`firstMotionCorrectionId`)
        REFERENCES `MotionCorrection` (`motionCorrectionId`)
          ON DELETE NO ACTION ON UPDATE CASCADE
)
COMMENT 'An instance of a particle picker program that was run';

-- 2D and 3D particle classification fields are almost the same, so using
-- the same tables seems to make sense:
CREATE TABLE ParticleClassification (
  particleClassificationId int unsigned auto_increment PRIMARY KEY,
  particlePickerId int unsigned,
  type enum('2D', '3D') COMMENT 'Indicates the type of particle classification',
  batchNumber int unsigned COMMENT 'Corresponding to batch number',
  classNumber int unsigned COMMENT 'Identified of the class. A unique ID given by Relion',
  classImageFullPath varchar(255) COMMENT 'The PNG of the class',
  numberOfParticlesPerBatch int unsigned COMMENT 'total number of particles per batch (a large integer)',
  numberOfClassesPerBatch int unsigned,
  particlesPerClass int unsigned COMMENT 'Number of particles within the selected class, can then be used together with the total number above to calculate the percentage', -- is this just numberOfParticlesPerBatch * numberOfClassesPerBatch ? If so, this column is unnecessary.
  rotationAccuracy int unsigned COMMENT '???', -- or "accuracyRotations" as in spreadsheet? float?
  translationAccuracy float COMMENT 'Unit: Angstroms', 
  estimatedResolution float COMMENT '???, Unit: Angstroms',
  overallFourierCompleteness float,
  symmetry varchar(20),
  -- classRepresentativePreview ?,
  CONSTRAINT `ParticleClassification_fk_particlePickerId`
    FOREIGN KEY (`particlePickerId`)
      REFERENCES `ParticlePicker` (`particlePickerId`)
        ON DELETE CASCADE ON UPDATE CASCADE
)
COMMENT 'Results of 2D or 2D classification';

-- Are we creating a "final" model later? If so, should they 
-- go into the same table?
-- Also, the ispyb schema has a couple of other "model" tables, so this should
-- probably have some kind of prefix to make clear it's for EM.
CREATE TABLE CryoemInitialModel (
  cryoemInitialModelId int unsigned auto_increment PRIMARY KEY,
  resolution float COMMENT 'Unit: Angstroms',
  numberOfParticles int unsigned
)
COMMENT 'Initial cryo-EM model generation results';

-- n:m relationship between ParticleClassification and InitialModel:
CREATE TABLE ParticleClassification_has_CryoemInitialModel (
  particleClassificationId int unsigned,
  cryoemInitialModelId int unsigned,
  PRIMARY KEY (particleClassificationId, cryoemInitialModelId),
  CONSTRAINT `ParticleClassification_has_CryoemInitialModel_fk1`
    FOREIGN KEY (`particleClassificationId`)
      REFERENCES `ParticleClassification` (`particleClassificationId`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ParticleClassification_has_InitialModel_fk2`
    FOREIGN KEY (`cryoemInitialModelId`)
      REFERENCES `CryoemInitialModel` (`cryoemInitialModelId`)
        ON DELETE CASCADE ON UPDATE CASCADE
);


UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_03_cryoEMv2_0_tables.sql';
