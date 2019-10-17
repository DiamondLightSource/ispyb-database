--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

CREATE TABLE MCAProcessing
  mcaprocessingid
  autoprocprogramid
  annotatedSpectrum
  fittedDataFileFullPath
  peakListFullPath
)
COMMENT 'Element analysis';

CREATE TABLE MCAProcessingPeaks (
  mcaprocessingpeakid
  mcaprocessingid
  name
  energy
  intensity
)
COMMENT '(this will allow me to construct the annotated spectrum in synchweb from the datacollection scanfile + mcapeak list)';
