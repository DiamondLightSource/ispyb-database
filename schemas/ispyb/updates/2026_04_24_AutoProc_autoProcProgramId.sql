INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_24_AutoProc_autoProcProgramId.sql', 'ONGOING');

ALTER TABLE AutoProc
ADD CONSTRAINT AutoProc_fk_autoProcProgramId
FOREIGN KEY (autoProcProgramId)
    REFERENCES AutoProc (autoProcProgramId);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_24_AutoProc_autoProcProgramId.sql';
