INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_DiffractionPlan_new_temperature_cols.sql', 'ONGOING');

ALTER TABLE DiffractionPlan
  ADD robotPlateTemperature float COMMENT 'units: kelvin',
  ADD exposureTemperature float COMMENT 'units: kelvin';

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_DiffractionPlan_new_temperature_cols.sql';