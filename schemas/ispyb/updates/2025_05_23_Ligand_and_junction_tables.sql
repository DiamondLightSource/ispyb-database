-- To undo:
-- drop table BLSample_has_Ligand;
-- drop table Ligand_has_PDB
-- drop table Ligand;
-- delete from SchemaStatus where scriptName = '2025_05_23_Ligand_and_junction_tables.sql';


INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_23_Ligand_and_junction_tables.sql', 'ONGOING');

CREATE TABLE Ligand (
    ligandId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    proposalId int(10) unsigned NOT NULL COMMENT 'References Proposal table',
    name varchar(30) NOT NULL COMMENT 'Ligand name',
    SMILES varchar(400) COMMENT 'Chemical structure',
    libraryName varchar(30) COMMENT 'Name of ligand library, to preserve provenance',
    libraryBatchNumber varchar(30) COMMENT 'Batch number of library, to preserve provenance',
    plateBarcode varchar(30) COMMENT 'Specific barcode of the plate it came from, to preserve provenance',
    sourceWell varchar(30) COMMENT 'Location within that plate, to preserve provenance',
    CONSTRAINT `Ligand_fk_proposalId`
      FOREIGN KEY (proposalId)
        REFERENCES Proposal (proposalId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = 'Ligands in biochemistry are substances that bind to biomolecules';

CREATE TABLE BLSample_has_Ligand (
    blSampleId int(10) unsigned,
    ligandId int(11) unsigned,
    PRIMARY KEY (blSampleId, ligandId),
    CONSTRAINT BLSample_has_Ligand_fk1
      FOREIGN KEY (blSampleId)
        REFERENCES BLSample (blSampleId)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
    CONSTRAINT BLSample_has_Ligand_fk2
      FOREIGN KEY (ligandId)
        REFERENCES Ligand (ligandId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = 'Junction table for BLSample and Ligand';

CREATE TABLE Ligand_has_PDB (
  ligandId int(11) unsigned,
  pdbId int(11) unsigned,
  PRIMARY KEY (ligandId, pdbId),
  CONSTRAINT Ligand_Has_PDB_fk1
    FOREIGN KEY (ligandId)
      REFERENCES Ligand (ligandId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
  CONSTRAINT Ligand_Has_PDB_fk2
    FOREIGN KEY (pdbid)
      REFERENCES PDB (pdbId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT = 'Junction table for Ligand and PDB';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_23_Ligand_and_junction_tables.sql';
