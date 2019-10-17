--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

CREATE TABLE KramersKronig (
  kramersKronigId int(11) unsigned auto_increment PRIMARY KEY,
  autoProcProgramId int(11) unsigned,
  edgeEnergy varchar(3),
  peakEnergy float,
  inflectionEnergy float,
  inflectionFDoublePrime float,
  inflectionFPrime float,
  peakFDoublePrime float,
  peakFPrime float,
  fitFileFullPath varchar(255) COMMENT 'Full path for e.g. Chooch file',
  jpegFitFileFullPath varchar(255) COMMENT 'Full path for e.g. Chooch jpeg file',
  CONSTRAINT KramersKronig_fk1 FOREIGN KEY (autoProcProgramId) REFERENCES AutoProcProgram(autoProcProgramId) ON DELETE NO ACTION ON UPDATE CASCADE
);
