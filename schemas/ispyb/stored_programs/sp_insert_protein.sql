DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_protein` (
	OUT p_id int(10) unsigned,
	p_proposalId int(10) unsigned,
	p_name varchar(255),
	p_acronym varchar(45),
	p_description text,
	p_hazardGroup tinyint(3),
	p_containmentLevel tinyint(3),
	p_safetyLevel enum('GREEN', 'YELLOW', 'RED'),
	p_molecularMass double,
	p_proteinType varchar(45),
	p_personId int(10) unsigned,
	p_bltimeStamp timestamp,
	p_isCreatedBySampleSheet tinyint(1),
	p_sequence text,
	p_MOD_ID varchar(20),
	p_componentTypeId int(11) unsigned,
	p_concentrationTypeId int(11) unsigned,
	p_global tinyint(1),
	p_externalId binary(16),
	p_density float,
	p_abundance float,
	p_isotropy enum('isotropic', 'anisotropic'))
MODIFIES SQL DATA
COMMENT 'Inserts a row into the Protein table.\nReturns Record ID in p_id.'
BEGIN
	INSERT INTO Protein
		(proposalId, name, acronym, description, hazardGroup, containmentLevel,
		safetyLevel, molecularMass, proteinType, personId, bltimeStamp,
		isCreatedBySampleSheet, sequence, MOD_ID, componentTypeId,
		concentrationTypeId, global, externalId, density, abundance, isotropy)
	VALUES
		(p_proposalId, p_name, p_acronym, p_description, p_hazardGroup, p_containmentLevel,
		p_safetyLevel, p_molecularMass, p_proteinType, p_personId, p_bltimeStamp,
		p_isCreatedBySampleSheet, p_sequence, p_MOD_ID, p_componentTypeId,
		p_concentrationTypeId, p_global, p_externalId, p_density, p_abundance, p_isotropy);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
