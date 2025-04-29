INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_04_29_DewarRegistry_fk_labContactId_on_delete_set_null.sql', 'ONGOING');

ALTER TABLE DewarRegistry
  DROP CONSTRAINT DewarRegistry_ibfk_2;

ALTER TABLE DewarRegistry
  ADD CONSTRAINT DewarRegistry_ibfk_2
    FOREIGN KEY (labContactId)
      REFERENCES LabContact (labContactId)
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_04_29_DewarRegistry_fk_labContactId_on_delete_set_null.sql';
