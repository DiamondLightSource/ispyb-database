DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_program_attachments_for_program_id`(p_id int unsigned)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the processing program attachments for the given processing program id'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT
        appa.autoProcProgramAttachmentId "attachmentId", appa.fileType "fileType", appa.filePath "filePath", appa.fileName "fileName"
      FROM AutoProcProgramAttachment appa
      WHERE appa.autoProcProgramId = p_id;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
