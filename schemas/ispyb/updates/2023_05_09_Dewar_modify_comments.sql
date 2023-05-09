INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_05_09_Dewar_modify_comments.sql', 'ONGOING');

ALTER TABLE Dewar MODIFY comments varchar(1024);

-- Undo:
-- ALTER TABLE Dewar MODIFY comments tinytext;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_05_09_Dewar_modify_comments.sql';
