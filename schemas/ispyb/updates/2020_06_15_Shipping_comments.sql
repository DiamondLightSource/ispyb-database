INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_06_15_Shipping_comments.sql', 'ONGOING');

ALTER TABLE Shipping MODIFY comments varchar(1000);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_06_15_Shipping_comments.sql';
