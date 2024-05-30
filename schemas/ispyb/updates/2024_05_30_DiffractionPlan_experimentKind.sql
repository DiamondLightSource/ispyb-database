INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_05_30_DiffractionPlan_experimentKind.sql', 'ONGOING');

ALTER TABLE DiffractionPlan
  MODIFY experimentKind enum('Default','MXPressE','MXPressO','MXPressE_SAD',
    'MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement',
    'OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE',
    'Stepped transmission','XChem High Symmetry','XChem Low Symmetry',
    'Commissioning','Metal ID') DEFAULT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_05_30_DiffractionPlan_experimentKind.sql';
