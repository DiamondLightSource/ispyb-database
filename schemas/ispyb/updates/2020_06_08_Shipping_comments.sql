INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_06_08_Shipping_comments.sql', 'ONGOING');

ALTER TABLE Shipping MODIFY comments varchar(512);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_06_08_Shipping_comments.sql';
