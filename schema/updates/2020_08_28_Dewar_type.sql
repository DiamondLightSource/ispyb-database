INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_Dewar_type.sql', 'ONGOING');

ALTER TABLE Dewar
  MODIFY `type` enum('Dewar','Toolbox', 'Parcel') NOT NULL DEFAULT 'Dewar';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_08_28_Dewar_type.sql';
