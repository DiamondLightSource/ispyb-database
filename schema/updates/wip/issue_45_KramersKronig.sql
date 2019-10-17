--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

CREATE TABLE KramersKronig (
  kramersKronigId
  autoProcProgramId
  edgeEnergy
  peakEnergy
  inflectionEnergy
  inflectionFDoublePrime
  inflectionFPrime
  peakFDoublePrime
  peakFPrime
  fitFileFullPath varchar(255) COMMENT 'Full path for e.g. Chooch file'
  jpegFitFileFullPath varchar(255) COMMENT 'Full path for e.g. Chooch jpeg file'
);
