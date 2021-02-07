DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_mrrun_blob`(
     INOUT p_id integer,
     p_parentId integer,
     p_view1 varchar(255), 
     p_view2 varchar(255), 
     p_view3 varchar(255) 
  )
  MODIFIES SQL DATA
  COMMENT 'Update or insert new entry with info about views (image paths) for an MX molecular replacement run, e.g. Dimple.'
BEGIN
  IF p_parentId IS NOT NULL THEN
    INSERT INTO MXMRRunBlob (mxMRRunBlobId, mxMRRunId, view1, view2, view3) 
		VALUES (p_id, p_parentId, substr(p_view1, 1, 255), substr(p_view2, 1, 255), substr(p_view3, 1, 255))
		ON DUPLICATE KEY UPDATE
			mxMRRunId = IFNULL(p_parentId, mxMRRunId),
			view1 = IFNULL(substr(p_view1, 1, 255), view1),
			view2 = IFNULL(substr(p_view2, 1, 255), view2),
			view3 = IFNULL(substr(p_view3, 1, 255), view3);

 	IF p_id IS NULL THEN 
		SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_parentId can not be NULL';
  END IF;  
END;;
DELIMITER ;