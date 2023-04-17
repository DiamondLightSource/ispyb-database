INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_04_14_XrayCentring.sql', 'ONGOING');

-- Add back columns that were removed - only needed so as not to break current version of SynchWeb
ALTER TABLE XrayCentringResult
  ADD status enum('success','failure','pending') COMMENT 'to be removed',
  ADD gridInfoId int(11) unsigned COMMENT 'to be removed';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_04_14_XrayCentring.sql';
