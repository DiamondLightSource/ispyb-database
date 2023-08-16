INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_08_16_ContainerRegistry_barcode_unique_not_null.sql', 'ONGOING');

ALTER TABLE ContainerRegistry
    MODIFY barcode varchar(20) NOT NULL,
    ADD UNIQUE KEY ContainerRegistry_uniq_barcode (barcode);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_08_16_ContainerRegistry_barcode_unique_not_null.sql';
