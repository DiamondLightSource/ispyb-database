DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_position` (
	OUT p_id int(11) unsigned,
	p_posX long,
	p_posY long,
	p_posZ long,
	p_scale long)
MODIFIES SQL DATA
COMMENT 'Inserts information into the Position table.\nReturns Record ID in p_id.'
BEGIN
	INSERT INTO Position (posX, posY, posZ, scale)
	VALUES (p_posX, p_posY, p_posZ, p_scale);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
