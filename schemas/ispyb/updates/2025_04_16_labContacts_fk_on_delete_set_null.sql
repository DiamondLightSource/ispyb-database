INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_04_16_labContacts_fk_on_delete_set_null.sql', 'ONGOING');

ALTER TABLE Shipping
  DROP CONSTRAINT Shipping_ibfk_2,
  DROP CONSTRAINT Shipping_ibfk_3;

ALTER TABLE Shipping
  ADD CONSTRAINT Shipping_ibfk_2
    FOREIGN KEY (sendingLabContactId)
      REFERENCES LabContact (labContactId)
        ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT Shipping_ibfk_3
    FOREIGN KEY (returnLabContactId)
      REFERENCES LabContact (labContactId)
        ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE DewarRegistry_has_Proposal
  DROP CONSTRAINT DewarRegistry_has_Proposal_ibfk4;

ALTER TABLE DewarRegistry_has_Proposal
  ADD CONSTRAINT DewarRegistry_has_Proposal_ibfk4
    FOREIGN KEY (labContactId)
      REFERENCES LabContact (labContactId)
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_04_16_labContacts_fk_on_delete_set_null.sql';
