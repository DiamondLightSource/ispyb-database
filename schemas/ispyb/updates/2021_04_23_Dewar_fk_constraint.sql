INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_04_23_Dewar_fk_constraint.sql', 'ONGOING');

ALTER TABLE Dewar
  DROP CONSTRAINT Dewar_ibfk_2;
ALTER TABLE Dewar
  ADD CONSTRAINT Dewar_fk_firstExperimentId
    FOREIGN KEY (`firstExperimentId`) 
      REFERENCES `BLSession` (`sessionId`) 
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_04_23_Dewar_fk_constraint.sql';
