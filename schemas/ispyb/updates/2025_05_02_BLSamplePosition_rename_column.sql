INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_02_BLSamplePosition_rename_column.sql', 'ONGOING');

ALTER TABLE BLSamplePosition
    RENAME COLUMN `positionId` TO `blSamplePositionId`;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_02_BLSamplePosition_rename_column.sql';
