DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_job_parameter`(
     INOUT p_id int(11) unsigned,
	 p_processingJobId int(11) unsigned,
     p_parameterKey varchar(80),
     p_parameterValue varchar(255)
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row. Otherwise updates existing row.'
BEGIN
  IF p_id IS NOT NULL OR p_processingJobId IS NOT NULL THEN
    INSERT INTO ProcessingJobParameter (
      processingJobParameterId, processingJobId, parameterKey, parameterValue) 
	VALUES (
	  p_id, p_processingJobId, p_parameterKey, p_parameterValue)
	ON DUPLICATE KEY UPDATE
      processingJobId = IFNULL(p_processingJobId, processingJobId),
      parameterKey = IFNULL(p_parameterKey, parameterKey),
      parameterValue = IFNULL(p_parameterValue, parameterValue);
	IF p_id IS NULL THEN 
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_id and/or p_processingJobId are NULL';  
  END IF;
END;;
DELIMITER ;