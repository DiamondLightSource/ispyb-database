DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_crystal` (
	OUT p_id int(11) unsigned,
	p_diffractionPlanId int(11) unsigned,
	p_proteinId int(11) unsigned,
	p_crystalUUID varchar(45),
	p_name varchar(255),
	p_spaceGroup varchar(20),
	p_morphology varchar(255),
	p_color varchar(45),
	p_size_x long,
	p_size_y long,
	p_size_z long,
	p_cell_a long,
	p_cell_b long,
	p_cell_c long,
	p_cell_alpha long,
	p_cell_beta long,
	p_cell_gamma long,
	p_comments varchar(255),
	p_recordTimeStamp varchar(1024),
	p_abundance float,
	p_theoreticalDensity float)
MODIFIES SQL DATA
COMMENT 'Inserts information into the Crystal table.\nReturns Record ID in p_id.'
BEGIN
	INSERT INTO Crystal
		(diffractionPlanId, proteinId, crystalUUID, name, spaceGroup,
		morphology, color, size_X, size_Y, size_Z, cell_a, cell_b, cell_c,
		cell_alpha, cell_beta, cell_gamma, comments, pdbFileName, pdbFilePath,
		recordTimeStamp, abundance, theoreticalDensity)
	VALUES
		(p_diffractionPlanId, p_proteinId, p_crystalUUID, p_name, p_spaceGroup,
		p_morphology, p_color, p_size_x, p_size_y, p_size_z, p_cell_a, p_cell_b, p_cell_c,
		p_cell_alpha, p_cell_beta, p_cell_gamma, p_comments, p_pdbFileName, p_pdbFilePath,
		p_recordTimeStamp, p_abundance, p_theoreticalDensity);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
