DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_dc_file_attachment`(
	 INOUT p_id int(11) unsigned,
     p_dataCollectionId int(11) unsigned,
     p_fileFullPath varchar(255),
     p_fileType varchar(45)
	)
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates info about a file attachmet for a data collection. Returns: The PK value in p_id.'
BEGIN
	IF p_id IS NOT NULL OR p_dataCollectionId IS NOT NULL THEN

      INSERT INTO DataCollectionFileAttachment (dataCollectionFileAttachmentId, dataCollectionId, fileFullPath, fileType) 
        VALUES (p_id, p_dataCollectionId, p_fileFullPath, p_fileType)
	    ON DUPLICATE KEY UPDATE
		  dataCollectionId = IFNULL(p_dataCollectionId, dataCollectionId),
          fileFullPath = IFNULL(p_fileFullPath, fileFullPath),
          fileType = IFNULL(p_fileType, fileType);

	  IF p_id IS NULL THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;
    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_id OR p_dataCollectionId must be non-NULL.';
    END IF;      
END;;
DELIMITER ;

