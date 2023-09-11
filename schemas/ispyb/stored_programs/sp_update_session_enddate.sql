DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_session_enddate`(
	 p_id int(11) unsigned,
	 p_endDate datetime
 )
	 MODIFIES SQL DATA
	 COMMENT 'Updates the end date for a session. Mandatory params: p_id and p_endDate.'
BEGIN
  IF p_id IS NOT NULL AND p_endDate IS NOT NULL THEN
      UPDATE BLSession
      SET
        endDate = p_endDate
      WHERE sessionId = p_id;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id AND p_endDate must be non-NULL.';
  END IF;
END;;
DELIMITER ;
