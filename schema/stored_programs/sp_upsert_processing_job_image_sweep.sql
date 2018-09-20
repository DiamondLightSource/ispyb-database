DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_job_image_sweep`(
     INOUT p_id int(11) unsigned,
	 p_processingJobId int(11) unsigned,
	 p_dataCollectionId int(11) unsigned,
     p_startImage mediumint(8) unsigned,
     p_endImage mediumint(8) unsigned
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row. Otherwise updates existing row.'
BEGIN
  IF p_id IS NOT NULL OR (p_processingJobId IS NOT NULL AND p_dataCollectionId IS NOT NULL) THEN
    INSERT INTO ProcessingJobImageSweep (
      processingJobImageSweepId, processingJobId, dataCollectionId, startImage, endImage) 
	VALUES (
	  p_id, p_processingJobId, p_dataCollectionId, p_startImage, p_endImage)
	ON DUPLICATE KEY UPDATE
      processingJobId = IFNULL(p_processingJobId, processingJobId),
      dataCollectionId = IFNULL(p_dataCollectionId, dataCollectionId),
      startImage = IFNULL(p_startImage, startImage),
      endImage = IFNULL(p_endImage, endImage);
	IF p_id IS NULL THEN 
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_id and/or p_processingJobId + p_dataCollectionId are NULL';  
  END IF;
END;;
DELIMITER ;
