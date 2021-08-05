INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_08_05_MXMRRun_update.sql', 'ONGOING');

-- New enum type "Input" for attachment fileType
ALTER TABLE AutoProcProgramAttachment
  MODIFY COLUMN `fileType` enum('Log','Result','Graph','Debug','Input') DEFAULT NULL COMMENT 'Type of file Attachment'
;

ALTER TABLE MXMRRun
  ADD `LLG` float DEFAULT NULL COMMENT 'Log Likelihood Gain',
  ADD `TFZ` float DEFAULT NULL COMMENT 'Translation Function Z-score',
  ADD `spaceGroup` varchar(45) DEFAULT NULL COMMENT 'Space group of the MR solution',
  ADD `autoProcProgramId` int(11) unsigned,
  ADD CONSTRAINT mxMRRun_FK2 FOREIGN KEY (autoProcProgramId) REFERENCES AutoProcProgram(autoProcProgramId)
;

-- Copy relevant columns from MXMRRun table to new entries in the AutoProcProgram and AutoProcProgramAttachment tables
DELIMITER ;;
BEGIN NOT ATOMIC
  DECLARE done INT DEFAULT FALSE;
  DECLARE app_id int unsigned;
  DECLARE mxmr_commandLine, mxmr_message varchar(255);
  DECLARE mxmr_pipeline varchar(255);
  DECLARE mxmr_success tinyint(1);
  DECLARE mxmr_starttime, mxmr_endtime datetime;
  DECLARE mxmr_inputCoordFile, mxmr_outputCoordFile, mxmr_inputMTZFile, mxmr_outputMTZFile, mxmr_runDirectory, mxmr_logFile varchar(255);

  DECLARE cur1 CURSOR FOR
    SELECT
      commandLine, pipeline, success, message, starttime, endtime, 
      inputCoordFile, outputCoordFile, inputMTZFile, outputMTZFile, runDirectory, logFile
    FROM MXMRRun;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;
  read_loop: LOOP
    FETCH cur1 INTO
      mxmr_commandLine, mxmr_pipeline, mxmr_success, mxmr_message, mxmr_starttime, mxmr_endtime,
      mxmr_inputCoordFile, mxmr_outputCoordFile, mxmr_inputMTZFile, mxmr_outputMTZFile, mxmr_runDirectory, mxmr_logFile
    ;
    IF done THEN
      LEAVE read_loop;
    END IF;

    INSERT INTO AutoProcProgram (
        processingCommandLine, processingPrograms, processingStatus, processingMessage, processingStartTime, processingEndTime, recordTimeStamp
      )
      VALUES (mxmr_commandLine, mxmr_pipeline, mxmr_success, mxmr_message, mxmr_starttime, mxmr_endtime, mxmr_endtime);

    SET app_id := LAST_INSERT_ID();
 
    IF mxmr_inputCoordFile IS NOT NULL THEN
      INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
        VALUES (app_id, "Input", mxmr_runDirectory, mxmr_inputCoordFile, mxmr_endtime);
    END IF;

    IF mxmr_inputMTZFile IS NOT NULL THEN
      INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
        VALUES (app_id, "Input", mxmr_runDirectory, mxmr_inputMTZFile, mxmr_endtime);
    END IF;

    IF mxmr_outputCoordFile IS NOT NULL THEN
      INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
        VALUES (app_id, "Result", mxmr_runDirectory, mxmr_outputCoordFile, mxmr_endtime);
    END IF;

    IF mxmr_outputMTZFile IS NOT NULL THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp)
      VALUES (app_id, "Result", mxmr_runDirectory, mxmr_outputMTZFile, mxmr_endtime);
    END IF;

    IF mxmr_logFile IS NOT NULL THEN
    INSERT INTO AutoProcProgramAttachment (autoProcProgramId, fileType, filePath, fileName, recordTimeStamp, importanceRank)
      VALUES (app_id, "Log", mxmr_runDirectory, mxmr_logFile, mxmr_endtime, 0);
    END IF;

  END LOOP;
  CLOSE cur1;
END;;
DELIMITER ;

-- Remove columns now we've copied the data elsewhere
ALTER TABLE MXMRRun
  DROP IF EXISTS commandLine,
  DROP IF EXISTS pipeline,
  DROP IF EXISTS success,
  DROP IF EXISTS message,
  DROP IF EXISTS starttime,
  DROP IF EXISTS endtime,
  DROP IF EXISTS inputCoordFile,
  DROP IF EXISTS inputMTZFile,
  DROP IF EXISTS outputCoordFile,
  DROP IF EXISTS outputMTZFile,
  DROP IF EXISTS runDirectory,
  DROP IF EXISTS logFile
;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_08_05_MXMRRun_update.sql';
