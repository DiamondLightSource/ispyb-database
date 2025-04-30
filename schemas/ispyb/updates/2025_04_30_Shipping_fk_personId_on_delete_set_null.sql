INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_04_30_Shipping_fk_personId_on_delete_set_null.sql', 'ONGOING');

ALTER TABLE Shipping
  DROP CONSTRAINT Shipping_ibfk_4;

  ALTER TABLE Shipping
  ADD CONSTRAINT Shipping_ibfk_4
    FOREIGN KEY (deliveryAgent_flightCodePersonId)
      REFERENCES Person (personId)
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_04_30_Shipping_fk_personId_on_delete_set_null.sql';
