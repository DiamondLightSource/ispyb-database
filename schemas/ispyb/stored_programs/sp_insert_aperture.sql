DELIMITER ;;
CREATE OR REPlACE DEFINIER=`ispyb_root`@`%` PROCEDURE `insert_aperture`(OUT p_id int(10) unsigned, p_sizeX float)
MODIFIES SQL DATA
COMMENT 'Inserts a row into the Aperture table'
BEGIN
	INSERT INTO Aperture (sizeX)
	VALUES (p_sizeX);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
