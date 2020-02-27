INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_02_27_Container_scLocationUpdated.sql', 'ONGOING');

ALTER TABLE Container ADD scLocationUpdated datetime DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_02_27_Container_scLocationUpdated.sql';
