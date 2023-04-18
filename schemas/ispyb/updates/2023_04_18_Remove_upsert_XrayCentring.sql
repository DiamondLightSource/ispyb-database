INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_04_18_Remove_upsert_XrayCentring.sql', 'ONGOING');

DROP PROCEDURE IF EXISTS `upsert_xray_centring_result`;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_04_18_Remove_upsert_XrayCentring.sql';
