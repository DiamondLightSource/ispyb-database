DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_mrrun`(
     INOUT p_id integer,
     p_parentId integer,
     p_success boolean,
     p_message varchar(255), 
     p_pipeline varchar(50),
     p_inputCoordFile varchar(255), 
     p_outputCoordFile varchar(255), 
     p_inputMTZFile varchar(255), 
     p_outputMTZFile varchar(255), 
     p_runDirectory varchar(255),
     p_logFile varchar(255),
     p_commandLine varchar(255),
     p_rValueStart float ,
     p_rValueEnd float ,
     p_rFreeValueStart float ,
     p_rFreeValueEnd float ,
     p_starttime datetime,
     p_endtime datetime
     ) 
    MODIFIES SQL DATA
    COMMENT 'Update or insert new entry with info about a MX molecular replacements run, e.g. Dimple'    
BEGIN
    IF p_parentId IS NOT NULL THEN
      INSERT INTO MXMRRun (mxMRRunId, autoProcScalingId, success, message, pipeline, inputCoordFile, outputCoordFile, inputMTZFile, outputMTZFile, 
		runDirectory, logFile, commandLine, rValueStart, rValueEnd, rFreeValueStart, rFreeValueEnd, starttime, endtime) 
      VALUES (
        p_id, 
        p_parentId, 
        p_success, 
        substr(p_message, 1, 255),
        substr(p_pipeline, 1, 50),
        substr(p_inputCoordFile, 1, 255),
        substr(p_outputCoordFile, 1, 255),
        substr(p_inputMTZFile, 1, 255),
        substr(p_outputMTZFile, 1, 255),
        substr(p_runDirectory, 1, 255),
        substr(p_logFile, 1, 255),
        substr(p_commandLine, 1, 255),
        p_rValueStart, 
        p_rValueEnd, 
        p_rFreeValueStart, 
        p_rFreeValueEnd, 
        IFNULL(p_starttime, NOW()), 
        p_endtime)
		ON DUPLICATE KEY UPDATE
			autoProcScalingId = IFNULL(p_parentId, autoProcScalingId), 
            success = IFNULL(p_success, success), 
            message = IFNULL(substr(p_message, 1, 255), message), 
            pipeline = IFNULL(substr(p_pipeline, 1, 50), pipeline), 
            inputCoordFile = IFNULL(substr(p_inputCoordFile, 1, 255), inputCoordFile), 
            outputCoordFile = IFNULL(substr(p_outputCoordFile, 1, 255), outputCoordFile), 
            inputMTZFile = IFNULL(substr(p_inputMTZFile, 1, 255), inputMTZFile), 
            outputMTZFile = IFNULL(substr(p_outputMTZFile, 1, 255), outputMTZFile), 
            runDirectory = IFNULL(substr(p_runDirectory, 1, 255), runDirectory), 
            logFile = IFNULL(substr(p_logFile, 1, 255), logFile), 
            commandLine = IFNULL(substr(p_commandLine, 1, 255), commandLine), 
            rValueStart = IFNULL(p_rValueStart, rValueStart), 
            rValueEnd = IFNULL(p_rValueEnd, rValueEnd), 
            rFreeValueStart = IFNULL(p_rFreeValueStart, rFreeValueStart), 
            rFreeValueEnd = IFNULL(p_rFreeValueEnd, rFreeValueEnd), 
            starttime = IFNULL(p_starttime, starttime), 
            endtime = IFNULL(p_endtime, endtime);
 
 	  IF p_id IS NULL THEN 
		SET p_id = LAST_INSERT_ID();
      END IF;
	ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_parentId can not be NULL';
	END IF;
  END;;
DELIMITER ;