INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_24_AutoProc_autoProcProgramId.sql', 'ONGOING');

/* 
 * Run SELECT * FROM AutoProc ap LEFT JOIN AutoProcProgram app ON ap.autoProcProgramId = app.autoProcProgramId WHERE app.autoProcProgramId is NULL;
 * to list entries which don't match the constraint
 */

ALTER TABLE AutoProc
ADD CONSTRAINT AutoProc_fk_autoProcProgramId
FOREIGN KEY (autoProcProgramId)
    REFERENCES AutoProcProgram (autoProcProgramId);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_24_AutoProc_autoProcProgramId.sql';
