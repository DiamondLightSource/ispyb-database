INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_12_source_column.sql', 'ONGOING');

ALTER TABLE Shipping
   ADD source varchar(50) DEFAULT current_user();

ALTER TABLE Dewar
  ADD source varchar(50) DEFAULT current_user();

ALTER TABLE Container
  ADD source varchar(50) DEFAULT current_user();

ALTER TABLE BLSample
  ADD source varchar(50) DEFAULT current_user();

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_12_source_column.sql';
