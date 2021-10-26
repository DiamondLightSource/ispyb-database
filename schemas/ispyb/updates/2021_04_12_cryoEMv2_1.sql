INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_04_12_cryoEMv2_1.sql', 'ONGOING');

CREATE TABLE `ParticleClassificationGroup` (
  particleClassificationGroupId int unsigned auto_increment PRIMARY KEY,
  particlePickerId int unsigned,
  programId int unsigned,
  type enum('2D', '3D') COMMENT 'Indicates the type of particle classification',
  batchNumber int unsigned COMMENT 'Corresponding to batch number',
  numberOfParticlesPerBatch int unsigned COMMENT 'total number of particles per batch (a large integer)',
  numberOfClassesPerBatch int unsigned,
  symmetry varchar(20),
  CONSTRAINT `ParticleClassificationGroup_fk_particlePickerId`
    FOREIGN KEY (`particlePickerId`)
      REFERENCES `ParticlePicker` (`particlePickerId`)
        ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ParticleClassificationGroup_fk_programId`
    FOREIGN KEY (`programId`)
      REFERENCES `AutoProcProgram` (`autoProcProgramId`)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

ALTER TABLE `ParticlePicker`
  DROP CONSTRAINT `ParticlePicker_fk_particleClassificationProgramId`,
  DROP particleClassificationProgramId,
  CHANGE `particlePickerProgramId` `programId` int(10) unsigned DEFAULT NULL,
  DROP CONSTRAINT `ParticlePicker_fk_particlePickerProgramId`;

ALTER TABLE ParticlePicker
  ADD CONSTRAINT `ParticlePicker_fk_programId` 
    FOREIGN KEY (`programId`)
      REFERENCES `AutoProcProgram` (`autoProcProgramId`)
        ON DELETE NO ACTION ON UPDATE CASCADE;


ALTER TABLE `ParticleClassification`
  ADD particleClassificationGroupId int unsigned,
  DROP CONSTRAINT `ParticleClassification_fk_particlePickerId`,
  DROP particlePickerId,
  DROP `type`,
  DROP batchNumber,
  DROP numberOfParticlesPerBatch,
  DROP numberOfClassesPerBatch,
  DROP symmetry;

ALTER TABLE `ParticleClassification`
  ADD CONSTRAINT `ParticleClassification_fk_particleClassificationGroupId`
      FOREIGN KEY (`particleClassificationGroupId`)
        REFERENCES `ParticleClassificationGroup` (`particleClassificationGroupId`)
          ON DELETE CASCADE ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2021_04_12_cryoEMv2_1.sql';
