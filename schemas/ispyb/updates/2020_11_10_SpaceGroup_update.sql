INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_11_10_SpaceGroup_update.sql', 'ONGOING');

START TRANSACTION;

UPDATE SpaceGroup SET spaceGroupId=spaceGroupId + 1000;
UPDATE SpaceGroup SET spaceGroupId=spaceGroupNumber;

COMMIT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_11_10_SpaceGroup_update.sql';
