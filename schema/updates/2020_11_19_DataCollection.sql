INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_19_DataCollection.sql', 'ONGOING');

ALTER TABLE `DataCollection`
  ADD `dataCollectionPlanId` INT UNSIGNED NULL DEFAULT NULL,
  ADD CONSTRAINT `DataCollection_ibfk9`
    FOREIGN KEY (`dataCollectionPlanId`)
      REFERENCES `DiffractionPlan`(`diffractionPlanId`)
        ON DELETE NO ACTION ON UPDATE NO ACTION;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_19_DataCollection.sql';
