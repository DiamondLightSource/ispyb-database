INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_07_08_BLSampleGroup_ownerId.sql', 'ONGOING');

ALTER TABLE BLSampleGroup
  ADD ownerId int(10) unsigned COMMENT 'Sample group owner',
  ADD CONSTRAINT BLSampleGroup_fk_ownerId
      FOREIGN KEY (ownerId)
        REFERENCES Person (personId)
          ON UPDATE CASCADE ON DELETE RESTRICT;

-- Undo:
-- ALTER TABLE BLSampleGroup DROP CONSTRAINT BLSampleGroup_fk_ownerId, DROP ownerId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_07_08_BLSampleGroup_ownerId.sql';
