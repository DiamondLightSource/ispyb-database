INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_01_27_AutoProcProgram_parentAutoProcProgramId.sql', 'ONGOING');

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE AutoProcProgram
  ADD parentAutoProcProgramId int(10) unsigned NULL DEFAULT NULL,
  ADD CONSTRAINT `AutoProcProgram_fk_parentAutoProcProgramId` FOREIGN KEY (`parentAutoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`),
ALGORITHM=INPLACE;

SET FOREIGN_KEY_CHECKS=1;

-- Undo:
-- ALTER TABLE AutoProcProgram
--    DROP CONSTRAINT AutoProcProgram_fk_parentAutoProcProgramId,
--    DROP parentAutoProcProgramId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_01_27_AutoProcProgram_parentAutoProcProgramId.sql';
