/*
set @id = NULL;
call upsert_motion_correction_drift(@id, 13, 1, 1, 1);
*/
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_motion_correction_drift`(
     INOUT p_id int(11) unsigned,
	 p_motionCorrectionId int(11) unsigned,
     p_frameNumber smallint unsigned,
     p_deltaX float,
     p_deltaY float
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row. Otherwise updates existing row.'
BEGIN
  IF p_id IS NOT NULL OR p_motionCorrectionId IS NOT NULL THEN
    INSERT INTO MotionCorrectionDrift (
      motionCorrectionDriftId, motionCorrectionId, frameNumber, deltaX, deltaY) 
	VALUES (
	  p_id, p_motionCorrectionId, p_frameNumber, p_deltaX, p_deltaY)
	ON DUPLICATE KEY UPDATE
      motionCorrectionId = IFNULL(p_motionCorrectionId, motionCorrectionId),
      frameNumber = IFNULL(p_frameNumber, frameNumber),
      deltaX = IFNULL(p_deltaX, deltaX),
      deltaY = IFNULL(p_deltaY, deltaY);
	IF p_id IS NULL THEN 
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_id and/or p_motionCorrectionId are NULL';  
  END IF;
END;;
DELIMITER ;
