DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_job_parameters`(p_id int unsigned) 
READS SQL DATA
COMMENT 'Returns a multi-row result-set (max 1000) with parameters for the given processing job ID'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT processingJobParameterId "parameterId", parameterKey "parameterKey", parameterValue "parameterValue"
      FROM ProcessingJobParameter  
	  WHERE processingJobId = p_id
      ORDER BY processingJobParameterId ASC
      LIMIT 1000;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

