INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_03_05_Dewar_dewarRegistryId.sql', 'ONGOING');

ALTER TABLE Dewar
  ADD dewarRegistryId int(11) unsigned COMMENT 'Reference to the registered dewar i.e. the physical item',
  ADD CONSTRAINT Dewar_fk_dewarRegistryId
  FOREIGN KEY (dewarRegistryId)
      REFERENCES DewarRegistry(dewarRegistryId)
          ON DELETE CASCADE
          ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_03_05_Dewar_dewarRegistryId.sql';
