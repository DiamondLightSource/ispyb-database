INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_08_08_ProcessedTomogram.sql', 'ONGOING');

CREATE TABLE ProcessedTomogram (
    processedTomogramId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    tomogramId int(11) unsigned NOT NULL COMMENT 'references Tomogram table',
    filePath varchar(255) DEFAULT NULL COMMENT 'location on disk for the tomogram file',
    processingType varchar(255) DEFAULT NULL COMMENT 'nature of the processed tomogram',
    FOREIGN KEY (tomogramId)
        REFERENCES Tomogram(tomogramId)
            ON DELETE CASCADE
            ON UPDATE CASCADE
) COMMENT = 'References to processed tomogram paths';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_08_08_ProcessedTomogram.sql';
