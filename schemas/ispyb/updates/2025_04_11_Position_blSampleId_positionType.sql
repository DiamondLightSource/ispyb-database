INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_04_11_Position_blSampleId_positionType.sql', 'ONGOING');

ALTER TABLE Position
  ADD positionType varchar(45) COMMENT 'Action (type) that originated this position',
  ADD blSampleId int(11) unsigned COMMENT 'FK, references parent sample',
  ADD CONSTRAINT `Position_fk_blSampleId`
    FOREIGN KEY (`blSampleId`)
      REFERENCES `BLSample` (`blSampleId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_04_11_Position_blSampleId_positionType.sql';
