INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_01_04_BLSession_drop_cols.sql', 'ONGOING');

ALTER TABLE BLSession
  MODIFY `lastUpdate` timestamp NOT NULL DEFAULT current_timestamp COMMENT 'last update timestamp: by default the end of the session, the last collect...',
  DROP COLUMN IF EXISTS projectCode,
  DROP COLUMN IF EXISTS sessionTitle,
  DROP COLUMN IF EXISTS structureDeterminations,
  DROP COLUMN IF EXISTS dewarTransport,
  DROP COLUMN IF EXISTS databackupFrance,
  DROP COLUMN IF EXISTS databackupEurope,
  DROP COLUMN IF EXISTS expSessionPk,
  DROP COLUMN IF EXISTS operatorSiteNumber,
  DROP COLUMN IF EXISTS protectedData;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_01_04_BLSession_drop_cols.sql';
