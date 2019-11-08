DELIMITER ;;

CREATE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_program_attachment_v2`(
     INOUT p_id int(10) unsigned,
     p_parentid int(10) unsigned,
     p_name varchar(255),
     p_path varchar(255),
     p_type enum('Log','Result','Graph', 'Debug'),
     p_importanceRank tinyint unsigned
  )
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates existing row in AutoProcProgramAttachment. Pa'
BEGIN
  IF NOT (p_parentid IS NULL) THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramAttachmentId, autoProcProgramId, filename, filepath, filetype, importanceRank, recordtimestamp)
      VALUES (p_id, p_parentid, p_name, p_path, p_type, p_importanceRank, now())
      ON DUPLICATE KEY UPDATE
		      autoProcProgramId = IFNULL(p_parentid, autoProcProgramId),
          filename = IFNULL(p_name, filename),
          filepath = IFNULL(p_path, filepath),
          filetype = IFNULL(p_type, filetype),
          importanceRank = IFNULL(p_importanceRank, importanceRank);

	  IF p_id IS NULL THEN
		  SET p_id = LAST_INSERT_ID();
    END IF;
	ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_parentid is NULL';
  END IF;
END;;

DELIMITER ;
