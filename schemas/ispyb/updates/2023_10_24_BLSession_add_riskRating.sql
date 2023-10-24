INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_24_BLSession_add_riskRating.sql', 'ONGOING');

ALTER TABLE BLSession
    ADD riskRating enum('Low','Medium','High', 'Not Permitted') COMMENT '';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_24_BLSession_add_riskRating.sql';
