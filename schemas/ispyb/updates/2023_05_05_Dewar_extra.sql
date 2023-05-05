INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_05_05_Dewar_extra.sql', 'ONGOING');

ALTER TABLE Dewar
  ADD `extra` JSON DEFAULT NULL COMMENT 'JSON column for facility-specific or hard-to-define attributes, e.g. LN2 top-ups and contents checks' CHECK (json_valid(`extra`));

-- Undo:
-- ALTER TABLE Dewar
--  DROP IF EXISTS extra;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_05_05_Dewar_extra.sql';
