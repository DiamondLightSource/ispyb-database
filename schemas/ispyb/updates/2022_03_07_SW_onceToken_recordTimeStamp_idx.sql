INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_03_07_SW_onceToken_recordTimeStamp_idx.sql', 'ONGOING');

ALTER TABLE SW_onceToken
  ADD INDEX SW_onceToken_recordTimeStamp_idx (recordTimeStamp);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_03_07_SW_onceToken_recordTimeStamp_idx.sql';
