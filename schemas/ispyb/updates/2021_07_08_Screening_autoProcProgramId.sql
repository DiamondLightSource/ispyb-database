INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_08_Screening_autoProcProgramId.sql', 'ONGOING');

ALTER TABLE Screening
  ADD autoProcProgramId int(10) unsigned,
  ADD CONSTRAINT Screening_fk_autoProcProgramId
    FOREIGN KEY (`autoProcProgramId`) 
      REFERENCES `AutoProcProgram` (`autoProcProgramId`) 
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_08_Screening_autoProcProgramId.sql';
