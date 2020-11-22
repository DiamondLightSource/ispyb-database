--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

-- Drop ES + child tables:

DROP TABLE BLSample_has_EnergyScan;
DROP TABLE Project_has_EnergyScan;
DROP TABLE EnergyScan;

-- Drop XFEFS + child tables:

DROP TABLE Project_has_XFEFSpectrum;
DROP TABLE XFEFluorescenceSpectrum;
