INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_02_01_Tomogram_drop_processingJobId.sql', 'ONGOING');

ALTER TABLE Tomogram
  DROP IF EXISTS processingJobId,
  DROP CONSTRAINT IF EXISTS Tomogram_fk_processingJobId;

/*
-- Undo changes
ALTER TABLE Tomogram
  ADD processingJobId int(11) unsigned DEFAULT NULL,
  ADD CONSTRAINT Tomogram_fk_processingJobId FOREIGN KEY (processingJobId) REFERENCES ProcessingJob (processingJobId);
*/

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_02_01_Tomogram_drop_processingJobId.sql';
