INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_DiffractionPlan_new_cols.sql', 'ONGOING');

ALTER TABLE DiffractionPlan
  ADD qMin float COMMENT 'minimum in qRange, unit: nm^-1, needed for SAXS',
  ADD qMax float COMMENT 'maximum in qRange, unit: nm^-1, needed for SAXS',
  ADD reductionParametersAveraging enum('All', 'Fastest Dimension', '1D') COMMENT 'Post processing params for SAXS';

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_DiffractionPlan_new_cols.sql';