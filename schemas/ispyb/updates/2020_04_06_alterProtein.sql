-- first line of script
INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_04_06_alterProtein.sql','ONGOING');

-- body of the script

ALTER TABLE `Protein` ADD `safetyLevel` ENUM( 'GREEN', 'YELLOW', 'RED' ) NULL AFTER `acronym` ;

-- last line of script
UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_04_06_alterProtein.sql';
