INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200731_extend_dcattachment_enum.sql', 'ONGOING');

ALTER TABLE `DataCollectionFileAttachment`
    CHANGE `fileType` `fileType` ENUM('snapshot','log','xy','recip','pia','warning','params') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200731_extend_dcattachment_enum.sql';
