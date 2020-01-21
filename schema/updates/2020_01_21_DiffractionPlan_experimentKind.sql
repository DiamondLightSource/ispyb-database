INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_01_21_DiffractionPlan_experimentKind.sql', 'ONGOING');

ALTER TABLE DiffractionPlan MODIFY `experimentKind` enum('Default','MXPressE','MXPressO','MXPressE_SAD','MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement','OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE','Stepped transmission', 'XChem High Symmetry', 'XChem Low Symmetry') DEFAULT NULL, ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_01_21_DiffractionPlan_experimentKind.sql';
