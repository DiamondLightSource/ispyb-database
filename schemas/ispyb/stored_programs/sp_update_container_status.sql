DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_status`(IN p_barcode varchar(45), IN p_status varchar(45)) 
MODIFIES SQL DATA 
COMMENT 'Set container containerStatus = p_status for barcode = p_barcode. Only a defined range of statuses are accepted.'
BEGIN
  DECLARE row_containerId int(11) unsigned DEFAULT NULL;
  DECLARE row_scLoc varchar(20) DEFAULT NULL;

  IF NOT (p_barcode IS NULL) AND p_status IN ('in_storage', 'in_localstorage', 'processing', 'disposed',
	'in_transit_to_localstorage', 'in_transit_to_storage', 'in_transit_loading', 'in_transit_unloading', 'in_loadlock', 'in_transit_to_loadlock') THEN

	SELECT containerId, sampleChangerLocation INTO row_containerId, row_scLoc
    FROM Container
    WHERE barcode = p_barcode;

	IF row_containerId is not NULL THEN
		UPDATE Container
		SET containerStatus = p_status
		WHERE containerId = row_containerId;

    INSERT INTO ContainerHistory (containerId, location, status, beamlineName, currentDewarId)
      SELECT row_containerId, row_scLoc, p_status, 'i02-2', currentDewarId
      FROM Container
      WHERE containerId = row_containerId;

	END IF;
    ELSEIF p_barcode IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_status does not have a valid value';
  END IF;
END;;
DELIMITER ;
