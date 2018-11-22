DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_xray_centring_result`(
	 INOUT p_id int(11) unsigned,
	 p_gridInfoId int(11) unsigned,
	 p_method varchar(15),
	 p_status varchar(45),
	 p_x float,
	 p_y float
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about an x-ray centring result (p_id).\nMandatory columns:\nFor insert: p_gridInfoId and p_status\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN

	IF p_status IS NOT NULL AND p_id IS NULL AND p_gridInfoId IS NOT NULL THEN
  	INSERT INTO XrayCentringResult (xrayCentringResultId, gridInfoId, method, status, x, y)
	  	VALUES (p_id, p_gridInfoId, p_method, p_status, p_x, p_y);
		SET p_id = LAST_INSERT_ID();
	ELSEIF p_status IS NOT NULL AND p_id IS NOT NULL THEN
	  UPDATE XrayCentringResult
		SET
				gridInfoId = IFNULL(p_gridInfoId, gridInfoId),
				method = IFNULL(p_method, method),
				status = IFNULL(p_status, status),
				x = IFNULL(p_x, x),
				y = IFNULL(p_y, y)
		WHERE xrayCentringResultId = p_id;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: status AND (p_id OR p_gridInfoId) must be non-NULL.';
	END IF;
END;;
DELIMITER ;
