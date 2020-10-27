INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_10_22_GridInfo_dcId.sql', 'ONGOING');

ALTER TABLE GridInfo
  ADD dataCollectionId int(11) unsigned, 
  ADD CONSTRAINT `GridInfo_fk_dataCollectionId`
    FOREIGN KEY (`dataCollectionId`)
      REFERENCES `DataCollection` (`dataCollectionId`)
        ON DELETE CASCADE ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_10_22_GridInfo_dcId.sql';
