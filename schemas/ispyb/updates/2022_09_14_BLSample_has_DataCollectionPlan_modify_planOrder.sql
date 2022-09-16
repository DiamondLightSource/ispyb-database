INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_09_14_BLSample_has_DataCollectionPlan_modify_planOrder.sql', 'ONGOING');

ALTER TABLE BLSample_has_DataCollectionPlan
  MODIFY planOrder smallint unsigned DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_09_14_BLSample_has_DataCollectionPlan_modify_planOrder.sql';
