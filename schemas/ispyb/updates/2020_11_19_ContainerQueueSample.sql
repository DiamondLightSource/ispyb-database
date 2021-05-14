INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_19_ContainerQueueSample.sql', 'ONGOING');

ALTER TABLE `ContainerQueueSample` 
  ADD `status` VARCHAR(20) NULL DEFAULT NULL COMMENT 'The status of the queued item, i.e. skipped, reinspect. Completed / failed should be inferred from related DataCollection',
  ADD `startTime` datetime DEFAULT NULL COMMENT 'Start time of processing the queue item',
  ADD `endTime` datetime DEFAULT NULL COMMENT 'End time of processing the queue item',
  ADD `dataCollectionPlanId` INT UNSIGNED NULL DEFAULT NULL,
  ADD CONSTRAINT `ContainerQueueSample_dataCollectionPlanId`
    FOREIGN KEY (`dataCollectionPlanId`)
      REFERENCES `DiffractionPlan`(`diffractionPlanId`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD `blSampleId` INT(10) UNSIGNED NULL DEFAULT NULL,
  ADD CONSTRAINT `ContainerQueueSample_blSampleId`
    FOREIGN KEY (`blSampleId`)
      REFERENCES `BLSample`(`blSampleId`)
        ON DELETE NO ACTION ON UPDATE NO ACTION;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_19_ContainerQueueSample.sql';
