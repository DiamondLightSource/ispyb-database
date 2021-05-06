DELIMITER ;;
CREATE OR REPLACE DEFINER= `ispyb_root`@`%` PROCEDURE `retrieve_apertures_using_size`(p_sizeX double)
READS SQL DATA
COMMENT 'Return a multi-row result set with info about Apertures identified by aperture size.'
BEGIN
	SELECT 
		a.apertureId,
		a.sizeX
	FROM Aperture a
	WHERE a.sizeX = p_sizeX;
END;;
DELIMITER ;

