INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_09_08_DewarRegistry_modify_fks.sql', 'ONGOING');

ALTER TABLE DewarRegistry
  DROP CONSTRAINT DewarRegistry_ibfk_1,
  DROP CONSTRAINT DewarRegistry_ibfk_2;

ALTER TABLE DewarRegistry
  ADD CONSTRAINT `DewarRegistry_ibfk_1`
    FOREIGN KEY (`proposalId`)
      REFERENCES `Proposal` (`proposalId`)
        ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `DewarRegistry_ibfk_2`
    FOREIGN KEY (`labContactId`)
      REFERENCES `LabContact` (`labContactId`)
        ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_09_08_DewarRegistry_modify_fks.sql';
