-- Example call:
-- SET @id=NULL;
-- CALL upsert_processing_program_message(@id, 56986673,'ERROR','Hello','Something odd is happening');

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_program_message`(
     INOUT p_id int(10) unsigned,
     p_programId int(10) unsigned,
     p_severity varchar(255),
     p_message varchar(255),
     p_description text
  )
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates existing row in AutoProcProgramMessage.'
BEGIN
  IF p_id IS NULL AND NOT (p_programId IS NULL) THEN
    INSERT INTO AutoProcProgramMessage (autoProcProgramMessageId, autoProcProgramId, severity, message, description)
      VALUES (p_id, p_programId, p_severity, p_message, p_description);
    SET p_id = LAST_INSERT_ID();
  ELSEIF NOT (p_id IS NULL) THEN
    UPDATE AutoProcProgramMessage
      SET
		    autoProcProgramId = IFNULL(p_programId, autoProcProgramId),
        severity = IFNULL(p_severity, severity),
        message = IFNULL(p_message, message),
        description = IFNULL(p_description, description)
      WHERE
        autoProcProgramMessageId = p_id;
	ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Both arguments p_id and p_programId cannot be NULL';
  END IF;
END;;

DELIMITER ;
