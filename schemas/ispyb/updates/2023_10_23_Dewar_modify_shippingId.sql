INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_23_Dewar_modify_shippingId.sql', 'ONGOING');

ALTER TABLE Dewar
    MODIFY shippingId int(10) unsigned NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_23_Dewar_modify_shippingId.sql';
