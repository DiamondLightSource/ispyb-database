-- Example call:
-- CALL retrieve_processing_program_attachments_for_dc_group_and_program(988855, 'xia2');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_program_attachments_for_dc_group_and_program`(p_id int unsigned, p_program varchar(255))
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the processing program attachments for the given DC group ID'
BEGIN
    IF p_id IS NOT NULL AND p_program IS NOT NULL THEN
      SELECT dc.dataCollectionId, app.autoProcProgramId,
        app.processingStatus,
        concat('[', group_concat(json_object('fileType', appa.fileType, 'fullFilePath', concat(appa.filePath, '/', appa.fileName))), ']') "processingAttachments"
      FROM DataCollection dc
        INNER JOIN AutoProcIntegration api
          ON api.dataCollectionId = dc.dataCollectionId
        INNER JOIN AutoProcProgram app
          ON app.autoProcProgramId = api.autoProcProgramId
        INNER JOIN AutoProcProgramAttachment appa
          ON appa.autoProcProgramId = api.autoProcProgramId
      WHERE
        dc.dataCollectionGroupId = p_id AND app.processingPrograms = p_program
      GROUP BY
        dc.dataCollectionId, app.autoProcProgramId, app.processingStatus;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory arguments p_id and p_program can not be NULL';
	END IF;
END;;
DELIMITER ;
