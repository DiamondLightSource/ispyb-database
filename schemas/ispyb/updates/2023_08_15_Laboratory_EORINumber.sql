INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_08_15_Laboratory_EORINumber.sql', 'ONGOING');

ALTER TABLE Laboratory
    ADD EORINumber varchar(17)
        COMMENT 'An EORI number consists of an ISO Country code from an EU Member State  (2 characters) + a maximum of 15 characters';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_08_15_Laboratory_EORINumber.sql';
