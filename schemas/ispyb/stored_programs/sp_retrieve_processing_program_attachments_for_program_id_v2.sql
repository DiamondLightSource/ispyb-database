DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_program_attachments_for_program_id_v2`(
    p_id int unsigned,	
    p_authLogin varchar(45)
)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the processing program attachments for the given processing program id'
BEGIN
    IF p_id IS NOT NULL THEN
        IF p_authLogin IS NOT NULL THEN
            SELECT
                appa.autoProcProgramAttachmentId "attachmentId", appa.fileType "fileType", appa.filePath "filePath", appa.fileName "fileName", appa.importanceRank "importanceRank"
            FROM AutoProcProgramAttachment appa
                INNER JOIN AutoProcProgram app ON app.autoProcProgramId = appa.autoProcProgramId
                INNER JOIN ProcessingJob pj ON pj.processingJobId = app.processingJobId
                INNER JOIN DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
                INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId = dc.dataCollectionGroupId
                INNER JOIN Session_has_Person shp ON shp.sessionId = dcg.sessionId
                INNER JOIN Person per ON per.personId = shp.personId 
            WHERE appa.autoProcProgramId = p_id AND per.login = p_authLogin
            GROUP BY appa.autoProcProgramAttachmentId, appa.fileType, appa.filePath, appa.fileName, appa.importanceRank;
        ELSE
            SELECT
                appa.autoProcProgramAttachmentId "attachmentId", appa.fileType "fileType", appa.filePath "filePath", appa.fileName "fileName", appa.importanceRank "importanceRank"
            FROM AutoProcProgramAttachment appa
            WHERE appa.autoProcProgramId = p_id;
        END IF;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
