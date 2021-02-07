DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_ls_position`(IN p_barcode varchar(45), IN p_position int) 
MODIFIES SQL DATA
COMMENT 'Updates container sampleChangerLocation for barcode = p_barcode, then calls update_container_status(p_barcode, in_localstorage)'
BEGIN
	IF NOT (p_barcode IS NULL) THEN
	  UPDATE Container
      SET sampleChangerLocation = p_position
      WHERE barcode = p_barcode;

	  -- CALL update_container_status(p_barcode, 'in_localstorage');
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
    END IF;
END;;
DELIMITER ;
