INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_02_14_BLSession_purgedProcessedData.sql', 'ONGOING');

ALTER TABLE BLSession
  ADD purgedProcessedData boolean DEFAULT 0
    COMMENT 'Flag to indicate whether the processed folder in the associated visit directory has been purged',
  ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_02_14_BLSession_purgedProcessedData.sql';
