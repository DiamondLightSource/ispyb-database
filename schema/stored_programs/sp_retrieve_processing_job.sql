DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_job`(p_id int unsigned) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with info about the processing job for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT dataCollectionId "dataCollectionId", displayName "displayName", comments "comments", 
        recordTimestamp "recordTimestamp", recipe "recipe", automatic "automatic"
      FROM ProcessingJob  
	  WHERE processingJobId = p_id
      LIMIT 1;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

