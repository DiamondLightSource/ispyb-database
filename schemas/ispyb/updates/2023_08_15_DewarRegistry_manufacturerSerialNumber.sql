INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_08_15_DewarRegistry_manufacturerSerialNumber.sql', 'ONGOING');

ALTER TABLE DewarRegistry
    ADD manufacturerSerialNumber varchar(15)
        COMMENT 'Dewar serial number as given by manufacturer. Used to be typically 5 or 6 digits, more likely to be 11 alphanumeric chars in future';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_08_15_DewarRegistry_manufacturerSerialNumber.sql';
