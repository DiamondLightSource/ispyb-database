INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_28_BLSession_icatId.sql', 'ONGOING');

ALTER TABLE BLSession
  ADD icatId int(11) unsigned COMMENT 'The internal ICAT ID for this BLSession';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_28_BLSession_icatId.sql';
