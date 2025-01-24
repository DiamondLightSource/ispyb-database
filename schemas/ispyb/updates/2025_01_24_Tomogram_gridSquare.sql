INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_01_24_Tomogram_gridSquare.sql', 'ONGOING');

ALTER TABLE Tomogram
  ADD gridSquareId int(11) unsigned COMMENT 'FK, references medium mag map in GridSquare', 
  ADD CONSTRAINT `Tomogram_fk_gridSquareId`
    FOREIGN KEY (`gridSquareId`)
      REFERENCES `GridSquare` (`gridSquareId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_01_24_Tomogram_gridSquare.sql';
