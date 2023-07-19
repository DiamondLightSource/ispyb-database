INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_07_19_Container_parentContainerId.sql', 'ONGOING');

ALTER TABLE Container
  ADD parentContainerId int(10) unsigned NULL DEFAULT NULL,
  ADD CONSTRAINT `Container_fk_parentContainerId` FOREIGN KEY (`parentContainerId`) REFERENCES `Container` (`containerId`);

-- Undo:
-- ALTER TABLE Container
--    DROP CONSTRAINT Container_fk_parentContainerId,
--    DROP parentContainerId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_07_19_Container_parentContainerId.sql';
