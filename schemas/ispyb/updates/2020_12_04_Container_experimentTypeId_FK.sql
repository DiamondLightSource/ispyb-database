INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_12_04_Container_experimentTypeId_FK.sql', 'ONGOING');

ALTER TABLE Container
  ADD experimentTypeId int unsigned,
  ADD CONSTRAINT `Container_fk_experimentTypeId` FOREIGN KEY (`experimentTypeId`)
    REFERENCES `ExperimentType` (`experimentTypeId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_12_04_Container_experimentTypeId_FK.sql';