DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` FUNCTION `upsert_program_run`(
     p_Id int(10) unsigned,
     p_cmd_line varchar(255),
     p_programs varchar(255),
     p_status tinyint(1) ,
     p_message varchar(255),
     p_starttime datetime,
     p_endtime datetime,
     p_environment varchar(255),
-- Store AutoProcProgramAttachments as well
     p_file1_id int(10) unsigned,
     p_filename1 varchar(255),
     p_filepath1 varchar(255),
     p_filetype1 enum('Log','Result','Graph'),
     p_file2_id int(10) unsigned,
     p_filename2 varchar(255),
     p_filepath2 varchar(255),
     p_filetype2 enum('Log','Result','Graph'),
     p_file3_id int(10) unsigned,
     p_filename3 varchar(255),
     p_filepath3 varchar(255),
     p_filetype3 enum('Log','Result','Graph')
  ) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
    DECLARE appid int(10) DEFAULT NULL;
    INSERT INTO AutoProcProgram (autoProcProgramId, processingCommandLine, processingPrograms, processingStatus, processingMessage, processingStartTime, processingEndTime, processingEnvironment, recordtimestamp)
		VALUES (p_Id, substr(p_cmd_line, 1, 255), p_programs, p_status, p_message, p_starttime, p_endtime, p_environment, now())
		ON DUPLICATE KEY UPDATE
      processingCommandLine = IFNULL(p_cmd_line, processingCommandLine),
      processingPrograms = IFNULL(p_programs, processingPrograms),
      processingStatus = IFNULL(p_status, processingStatus),
      processingMessage = IFNULL(p_message, processingMessage),
      processingStartTime = IFNULL(p_starttime, processingStarttime),
      processingEndTime = IFNULL(p_endtime, processingEndtime),
      processingEnvironment = IFNULL(p_environment, processingEnvironment);

	IF LAST_INSERT_ID() = 0 THEN 
		SET appid = p_id;
    ELSE 
		SET appid = LAST_INSERT_ID();
    END IF;
        
	IF p_filename1 IS NOT NULL THEN
        INSERT INTO AutoProcProgramAttachment (autoProcProgramAttachmentId,autoProcProgramId, filename, filepath, filetype, recordtimestamp)
          VALUES (p_file1_id, appid, p_filename1, p_filepath1, p_filetype1, now())
          ON DUPLICATE KEY UPDATE
		autoProcProgramId = IFNULL(appid, autoProcProgramId),
        filename = IFNULL(p_filename1, filename),
        filepath = IFNULL(p_filepath1, filepath),
        filetype = IFNULL(p_filetype1, filetype);
    END IF;
    IF p_filename2 IS NOT NULL THEN
        INSERT INTO AutoProcProgramAttachment (autoProcProgramAttachmentId, autoProcProgramId, filename, filepath, filetype, recordtimestamp)
          VALUES (p_file2_id, appid, p_filename2, p_filepath2, p_filetype2, now())
          ON DUPLICATE KEY UPDATE
		autoProcProgramId = IFNULL(appid, autoProcProgramId),
        filename = IFNULL(p_filename2, filename),
        filepath = IFNULL(p_filepath2, filepath),
        filetype = IFNULL(p_filetype2, filetype);
    END IF;
    IF p_filename3 IS NOT NULL THEN
        INSERT INTO AutoProcProgramAttachment (autoProcProgramAttachmentId, autoProcProgramId, filename, filepath, filetype, recordtimestamp)
          VALUES (p_file2_id, appid, p_filename3, p_filepath3, p_filetype3, now())
          ON DUPLICATE KEY UPDATE
		autoProcProgramId = IFNULL(appid, autoProcProgramId),
        filename = IFNULL(p_filename3, filename),
        filepath = IFNULL(p_filepath3, filepath),
        filetype = IFNULL(p_filetype3, filetype);
    END IF;

	RETURN appid;
  END;;
DELIMITER ;