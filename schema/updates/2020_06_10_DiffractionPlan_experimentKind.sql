INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_06_10_DiffractionPlan_experimentKind.sql', 'ONGOING');

ALTER TABLE DiffractionPlan MODIFY experimentKind enum('Default','MXPressE','MXPressO','MXPressE_SAD','MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement','OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE','Stepped transmission','XChem High Symmetry','XChem Low Symmetry', 'Commissioning');

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_06_10_DiffractionPlan_experimentKind.sql';
