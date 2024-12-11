INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_09_04_ProcessedTomogram_comment.sql', 'ONGOING');

ALTER TABLE ProcessedTomogram COMMENT = 'Indicates the sample''s location on a multi-sample pin, where 1 is closest to the pin base or a sample''s position in a cryo-EM cassette';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_09_04_ProcessedTomogram_comment.sql';
