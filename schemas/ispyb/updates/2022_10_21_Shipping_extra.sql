INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_10_21_Shipping_extra.sql', 'ONGOING');

ALTER TABLE Shipping ADD extra JSON NULL DEFAULT NULL COMMENT 'JSON column for facility-specific or hard-to-define attributes';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_10_21_Shipping_extra.sql';
