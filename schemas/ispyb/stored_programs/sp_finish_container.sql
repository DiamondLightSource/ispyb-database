DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `finish_container`(IN p_barcode varchar(45))
    MODIFIES SQL DATA
    COMMENT 'Set the completedTimeStamp in the ContainerQueue table for the container with this barcode'
BEGIN
  IF NOT (p_barcode IS NULL) THEN
    UPDATE ContainerQueue
    SET completedTimeStamp = current_timestamp
    WHERE completedTimeStamp is NULL and containerId in (SELECT containerId FROM Container WHERE barcode = p_barcode);
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
  END IF;
END ;;
DELIMITER ;
