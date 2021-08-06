DELIMITER ;;
CREATE OR REPLACE FUNCTION `upsert_mrrun`(
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
     ) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN

  DECLARE app_id integer DEFAULT NULL;
  DECLARE tmp_runDirectory varchar(255);

  -- Insert/update the new MXMRRun rows
  INSERT INTO MXMRRun (mxMRRunId, autoProcScalingId, rValueStart, rValueEnd, rFreeValueStart, rFreeValueEnd)
    VALUES (
      p_id,
      p_parentId,
      p_rValueStart,
      p_rValueEnd,
      p_rFreeValueStart,
      p_rFreeValueEnd)
  ON DUPLICATE KEY UPDATE
    autoProcScalingId = IFNULL(p_parentId, autoProcScalingId),
    rValueStart = IFNULL(p_rValueStart, rValueStart),
    rValueEnd = IFNULL(p_rValueEnd, rValueEnd),
    rFreeValueStart = IFNULL(p_rFreeValueStart, rFreeValueStart),
    rFreeValueEnd = IFNULL(p_rFreeValueEnd, rFreeValueEnd)
    ;

	IF p_id IS NULL THEN
		SET p_id = LAST_INSERT_ID();
  END IF;

  -- Get the autoProcProgramId for this row, if set (only applicable if updating)
  SET app_id = (SELECT autoProcProgramId FROM MXMRRun WHERE mxMRRunId = p_id);

  -- Insert/update the related AutoProcProgram entry
  INSERT INTO AutoProcProgram (
    autoProcProgramId, processingCommandLine, processingPrograms, processingStatus,
    processingMessage, processingStartTime, processingEndTime, recordTimeStamp)
    VALUES (app_id, p_commandLine, p_pipeline, p_success, p_message, p_starttime, p_endtime, p_endtime)
  ON DUPLICATE KEY UPDATE
    autoProcProgramId = autoProcProgramId,
    processingCommandLine = IFNULL(p_commandLine, processingCommandLine),
    processingPrograms = IFNULL(p_pipeline, processingPrograms),
    processingStatus = IFNULL(p_success, processingStatus),
    processingMessage = IFNULL(p_message, processingMessage),
    processingStartTime = IFNULL(p_starttime, p_starttime),
    processingEndTime = IFNULL(p_endtime, processingEndTime),
    recordTimeStamp = IFNULL(p_endtime, recordTimeStamp)
    ;

  -- Set the autoProcProgramId in MXMRRun if not already set
  IF app_id IS NULL THEN
    SET app_id = LAST_INSERT_ID();
    UPDATE MXMRRun SET autoProcProgramId = app_id WHERE mxMRRunId = p_id;
  END IF;

  -- mxmr_runDirectory with trailing space for use with REPLACE below
  SET tmp_runDirectory = p_runDirectory;
  IF tmp_runDirectory IS NOT NULL AND RIGHT(tmp_runDirectory, 1) != '/' THEN
    SET tmp_runDirectory = CONCAT(tmp_runDirectory, '/') ;
  END IF;

  IF p_inputCoordFile IS NOT NULL THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
      VALUES (app_id, "Input", p_runDirectory, REPLACE(p_inputCoordFile, tmp_runDirectory, ''), p_endtime);
  END IF;

  IF p_inputMTZFile IS NOT NULL THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
      VALUES (app_id, "Input", p_runDirectory, REPLACE(p_inputMTZFile, tmp_runDirectory, ''), p_endtime);
  END IF;

  IF p_outputCoordFile IS NOT NULL THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
      VALUES (app_id, "Result", p_runDirectory, REPLACE(p_outputCoordFile, tmp_runDirectory, ''), p_endtime);
  END IF;

  IF p_outputMTZFile IS NOT NULL THEN
  INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
    VALUES (app_id, "Result", p_runDirectory, REPLACE(p_outputMTZFile, tmp_runDirectory, ''), p_endtime);
  END IF;

  IF p_logFile IS NOT NULL THEN
  INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp, importanceRank)
    VALUES (app_id, "Log", p_runDirectory, REPLACE(p_logFile, tmp_runDirectory, ''), p_endtime, 0);
  END IF;

  RETURN p_id;

  END ;;
DELIMITER ;