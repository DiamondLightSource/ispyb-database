-- Test on dev - insert and the update:
/*
set @id=NULL;
call upsert_processing_job(@id, 161240, 'test_job_1', 'First test job', 'some recipe ...', 0);
call upsert_processing_job(@id, 161240, 'test_job_1', '1st test job', 'some recipe ...', 0);
*/

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_job`(
     INOUT p_id int(11) unsigned,
	 p_dataCollectionId int(11) unsigned,
     p_displayName varchar(80),
     p_comments varchar(255),
     p_recipe varchar(50),
     p_automatic tinyint(1)
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row. Otherwise updates existing row.'
BEGIN
  IF p_id IS NOT NULL OR p_dataCollectionId IS NOT NULL THEN
    INSERT INTO ProcessingJob (
      processingJobId, dataCollectionId, displayName, comments, recipe, automatic) 
	VALUES (
	  p_id, p_dataCollectionId, p_displayName, p_comments, p_recipe, p_automatic)
	ON DUPLICATE KEY UPDATE
      dataCollectionId = IFNULL(p_dataCollectionId, dataCollectionId),
      displayName = IFNULL(p_displayName, displayName),
      comments = IFNULL(p_comments, comments),
      recipe = IFNULL(p_recipe, recipe),
      automatic = IFNULL(p_automatic, automatic);
	IF p_id IS NULL THEN 
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_id and/or p_dataCollectionId are NULL';  
  END IF;
END;;
DELIMITER ;
