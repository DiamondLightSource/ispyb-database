INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_09_17_SpaceGroup_trim.sql', 'ONGOING');

UPDATE SpaceGroup SET spaceGroupShortName=trim(trailing '1' FROM spaceGroupShortName) WHERE spaceGroupId in (51,52,53,54,55,56,57,58,59,60,61,62,63,64,73,74,127,128,129,130,205,206,223,224,227,228,230);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_09_17_SpaceGroup_trim.sql';
