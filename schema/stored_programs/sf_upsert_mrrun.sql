DELIMITER $$
CREATE OR REPLACE FUNCTION `upsert_mrrun` (
     p_id integer,
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
     RETURNs int
  MODIFIES SQL DATA
  BEGIN

    --  Insert a new row, using all the parameters
    INSERT INTO MXMRRun (mxMRRunId, autoProcScalingId, success, message, pipeline, inputCoordFile, outputCoordFile, inputMTZFile, outputMTZFile, 
		runDirectory, logFile, commandLine, rValueStart, rValueEnd, rFreeValueStart, rFreeValueEnd, starttime, endtime) 
      VALUES (
        p_id, 
        p_parentId, 
        p_success, 
        p_message, 
        p_pipeline, 
        p_inputCoordFile, 
        p_outputCoordFile, 
        p_inputMTZFile, 
        p_outputMTZFile, 
        p_runDirectory,
        p_logFile,
        p_commandLine,
        p_rValueStart, 
        p_rValueEnd, 
        p_rFreeValueStart, 
        p_rFreeValueEnd, 
        p_starttime, 
        p_endtime)
		ON DUPLICATE KEY UPDATE
			autoProcScalingId = IFNULL(p_parentId, autoProcScalingId), 
            success = IFNULL(p_success, success), 
            message = IFNULL(p_message, message), 
            pipeline = IFNULL(p_pipeline, pipeline), 
            inputCoordFile = IFNULL(p_inputCoordFile, inputCoordFile), 
            outputCoordFile = IFNULL(p_outputCoordFile, outputCoordFile), 
            inputMTZFile = IFNULL(p_inputMTZFile, inputMTZFile), 
            outputMTZFile = IFNULL(p_outputMTZFile, outputMTZFile), 
            runDirectory = IFNULL(p_runDirectory, runDirectory), 
            logFile = IFNULL(p_logFile, logFile), 
            commandLine = IFNULL(p_commandLine, commandLine), 
            rValueStart = IFNULL(p_rValueStart, rValueStart), 
            rValueEnd = IFNULL(p_rValueEnd, rValueEnd), 
            rFreeValueStart = IFNULL(p_rFreeValueStart, rFreeValueStart), 
            rFreeValueEnd = IFNULL(p_rFreeValueEnd, rFreeValueEnd), 
            starttime = IFNULL(p_starttime, starttime), 
            endtime = IFNULL(p_endtime, endtime);
 
	IF p_id IS NULL THEN 
		RETURN LAST_INSERT_ID();
    ELSE 
		RETURN p_id;
    END IF;
  END$$
DELIMITER ;
