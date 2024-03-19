INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_19_ContainerQueue_containerId_not_null.sql', 'ONGOING');

ALTER TABLE ContainerQueue
  DROP CONSTRAINT IF EXISTS ContainerQueue_ibfk1,
  DROP INDEX IF EXISTS ContainerQueue_idx1,
  MODIFY containerId int(10) unsigned NOT NULL;

ALTER TABLE ContainerQueue
  ADD INDEX ContainerQueue_idx1 (containerId, completedTimeStamp),
  ADD CONSTRAINT `ContainerQueue_ibfk1`
    FOREIGN KEY ContainerQueue_idx1 (`containerId`)
      REFERENCES `Container` (`containerId`)
        ON DELETE CASCADE ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_19_ContainerQueue_containerId_not_null.sql';
