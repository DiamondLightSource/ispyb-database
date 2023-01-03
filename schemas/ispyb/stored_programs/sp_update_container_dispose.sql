DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_dispose`(IN p_barcode varchar(45))
    MODIFIES SQL DATA
    COMMENT 'Update the Container with barcode p_barcode: Set containerStatus to disposed and imagerId to NULL. Also add a row in ContainerHistory with status = disposed.'
BEGIN

  DECLARE EXIT HANDLER FOR SQLWARNING
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='SQLWARNING, transaction rollback';
  END;

  IF NOT (p_barcode IS NULL) THEN

      START TRANSACTION;

      UPDATE Container
      SET 
        containerStatus = 'disposed',
        imagerId = NULL
      WHERE barcode = p_barcode;

      INSERT INTO ContainerHistory (containerId, status)
        SELECT containerId, 'disposed'
        FROM Container
        WHERE barcode = p_barcode;

      COMMIT;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
  END IF;
END ;;
DELIMITER ;
