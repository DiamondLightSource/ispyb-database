INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_10_24_BLSession_add_safetyLevel.sql', 'ONGOING');

ALTER TABLE BLSession
    ADD safetyLevel enum('GREEN','YELLOW','RED') COMMENT 'Risk rating';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_10_24_BLSession_add_safetyLevel.sql';
