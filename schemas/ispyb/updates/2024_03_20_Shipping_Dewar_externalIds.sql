INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_20_Shipping_Dewar_externalIds.sql', 'ONGOING');

ALTER TABLE Shipping
  ADD COLUMN `externalShippingIdToSynchrotron` int(11) unsigned
    COMMENT 'ID for shipping to synchrotron in external application';

ALTER TABLE Dewar
  ADD COLUMN `externalShippingIdFromSynchrotron` int(11) unsigned
    COMMENT 'ID for shipping from synchrotron in external application';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_20_Shipping_Dewar_externalIds.sql';
