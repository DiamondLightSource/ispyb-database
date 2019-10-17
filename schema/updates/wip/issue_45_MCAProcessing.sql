--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

CREATE TABLE MCAProcessing (
  mcaProcessingId int(11) unsigned auto_increment PRIMARY KEY,
  autoProcProgramId int(10) unsigned NOT NULL,
  annotatedSpectrum varchar(255),
  fittedDataFileFullPath varchar(255),
  peakListFullPath varchar(255),
  CONSTRAINT MCAProcessing_fk1 FOREIGN KEY (autoProcProgramId) REFERENCES AutoProcProgram(autoProcProgramId) ON DELETE NO ACTION ON UPDATE CASCADE
)
COMMENT 'Element analysis';

CREATE TABLE MCAProcessingPeaks (
  mcaProcessingPeakId int(11) unsigned auto_increment PRIMARY KEY,
  mcaProcessingId int(11) unsigned,
  name varchar(6),
  energy float,
  intensity float,
  CONSTRAINT MCAProcessingPeaks_fk1 FOREIGN KEY (mcaProcessingId) REFERENCES MCAProcessing(mcaProcessingId) ON DELETE CASCADE ON UPDATE CASCADE
)
COMMENT 'This enables us to construct the annotated spectrum from the DataCollection scanfile + mcapeak list';
