INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_29_Protein_isotropy.sql', 'ONGOING');
  
ALTER TABLE Protein
  ADD isotropy enum('isotropic', 'anisotropic') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_29_Protein_isotropy.sql';
