-- To undo:
-- ALTER TABLE AutoProcProgramAttachment DROP deleted, ALGORITHM=INSTANT;

INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_12_04_AutoProcProgramAttachment_deleted.sql', 'ONGOING');

ALTER TABLE AutoProcProgramAttachment ADD deleted boolean DEFAULT FALSE COMMENT '1/TRUE if the file has been deleted', ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_12_04_AutoProcProgramAttachment_deleted.sql';
