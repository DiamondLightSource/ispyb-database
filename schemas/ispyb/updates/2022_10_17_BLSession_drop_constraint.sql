INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_10_17_BLSession_drop_constraint.sql', 'ONGOING');

ALTER TABLE BLSession DROP CONSTRAINT IF EXISTS BLSession_ibfk_3;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_10_17_BLSession_drop_constraint.sql';
