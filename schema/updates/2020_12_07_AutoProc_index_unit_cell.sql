INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_12_07_AutoProc_index_unit_cell.sql', 'ONGOING');

CREATE INDEX AutoProc_refined_unit_cell ON AutoProc (refinedCell_a, refinedCell_b, refinedCell_c, refinedCell_alpha, refinedCell_beta, refinedCell_gamma, spaceGroup);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_12_07_AutoProc_index_unit_cell.sql';