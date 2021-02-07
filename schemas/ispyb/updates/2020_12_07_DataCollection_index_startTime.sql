INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_12_07_DataCollection_index_startTime.sql', 'ONGOING');

CREATE INDEX DataCollection_dataCollectionGroupId_startTime ON DataCollection (dataCollectionGroupId, startTime);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_12_07_DataCollection_index_startTime.sql';