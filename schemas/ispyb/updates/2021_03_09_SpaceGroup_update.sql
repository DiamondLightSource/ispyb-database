INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_09_SpaceGroup_update.sql', 'ONGOING');

UPDATE SpaceGroup SET spaceGroupShortName='P63/mmc', spaceGroupName='P63/m m c' WHERE spaceGroupId = 194;
UPDATE SpaceGroup SET MX_used=1 WHERE spaceGroupId BETWEEN 1 AND 230;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_09_SpaceGroup_update.sql';
