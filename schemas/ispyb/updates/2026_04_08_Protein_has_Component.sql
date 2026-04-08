INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_08_Protein_has_Component.sql', 'ONGOING');

CREATE TABLE Protein_has_Component (
    proteinHasComponentId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    proteinId int(10) unsigned NOT NULL COMMENT 'References Protein table',
    componentId int(10) unsigned NOT NULL COMMENT 'References Component table',
    CONSTRAINT `Protein_has_Component_fk_proteinId`
      FOREIGN KEY (proteinId)
        REFERENCES Protein (proteinId)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
    CONSTRAINT `Protein_has_Component_fk_componentId`
      FOREIGN KEY (componentId)
        REFERENCES Component (componentId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = 'Which elements are contained inside a molecule';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_08_Protein_has_Component.sql';
