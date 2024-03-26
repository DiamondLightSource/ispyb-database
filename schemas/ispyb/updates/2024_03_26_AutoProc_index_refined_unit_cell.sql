INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_03_26_AutoProc_index_refined_unit_cell.sql', 'ONGOING');

DROP INDEX AutoProc_refined_unit_cell ON AutoProc;
CREATE INDEX AutoProc_refined_unit_cell ON AutoProc(refinedCell_a, refinedCell_b, refinedCell_c, refinedCell_alpha, refinedCell_beta, refinedCell_gamma);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_03_26_AutoProc_index_refined_unit_cell.sql';
