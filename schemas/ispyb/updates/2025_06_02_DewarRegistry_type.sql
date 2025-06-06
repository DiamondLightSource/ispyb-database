INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_06_02_DewarRegistry_type.sql', 'ONGOING');

ALTER TABLE DewarRegistry
  ADD `type` enum('Dewar','Toolbox','Thermal Shipper') NOT NULL DEFAULT 'Dewar';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_06_02_DewarRegistry_type.sql';
