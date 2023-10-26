INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_26_BFactorFit_and_new_cols.sql', 'ONGOING');

-- To undo:
-- ALTER TABLE Tomogram DROP globalAlignmentQuality;
-- DROP TABLE BFactorFit;
-- ALTER TABLE ParticleClassification DROP bFactorFitIntercept, DROP bFactorFitLinear, DROP bFactorFitQuadratic;

ALTER TABLE Tomogram
  ADD globalAlignmentQuality float COMMENT 'Quality of fit metric for the alignment of the tilt series corresponding to this tomogram';

CREATE TABLE BFactorFit (
  bFactorFitId int(11) unsigned auto_increment PRIMARY KEY,
  particleClassificationId int(11) unsigned,
  resolution float COMMENT 'Resolution of a refined map using a given number of particles',
  numberOfParticles int unsigned COMMENT 'Number of particles used in refinement',
  particleBatchSize int unsigned COMMENT 'Number of particles in the batch that the B-factor analysis was performed on',
  CONSTRAINT BFactorFit_fk_particleClassificationId
    FOREIGN KEY (`particleClassificationId`)
      REFERENCES `ParticleClassification` (`particleClassificationId`)
)
COMMENT 'CryoEM reconstruction resolution as a function of the number of particles for the creation of a Rosenthal-Henderson plot and the calculation of B-factors';

ALTER TABLE ParticleClassification
  ADD bFactorFitIntercept float COMMENT 'Intercept of quadratic fit to refinement resolution against the logarithm of the number of particles',
  ADD bFactorFitLinear float COMMENT 'Linear coefficient of quadratic fit to refinement resolution against the logarithm of the number of particles, equal to half of the B factor',
  ADD bFactorFitQuadratic float COMMENT 'Quadratic coefficient of quadratic fit to refinement resolution against the logarithm of the number of particles';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_26_BFactorFit_and_new_cols.sql';
