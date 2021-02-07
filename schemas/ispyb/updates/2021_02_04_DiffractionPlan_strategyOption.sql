INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2021_02_04_DiffractionPlan_strategyOption.sql', 'ONGOING');

ALTER TABLE DiffractionPlan
  MODIFY `strategyOption` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`strategyOption`));

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2021_02_04_DiffractionPlan_strategyOption.sql';