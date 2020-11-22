DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_job_image_sweeps`(p_id int unsigned) 
READS SQL DATA
COMMENT 'Returns a multi-row result-set with sweep info for the given processing job ID'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT processingJobImageSweepId "sweepId", dataCollectionId "dataCollectionId", startImage "startImage", endImage "endImage"
      FROM ProcessingJobImageSweep  
	  WHERE processingJobId = p_id
      ORDER BY processingJobImageSweepId ASC
      LIMIT 1000;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

