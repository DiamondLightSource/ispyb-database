-- Requirements for this SP described in http://jira.diamond.ac.uk/browse/SCI-6048
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_processing_program`(
     INOUT p_id int(11) unsigned,
	 p_commandLine varchar(255),
     p_programs varchar(255),
     p_status int(11),
     p_updateMessage varchar(80),
     p_startTimestamp datetime,
     p_updateTimestamp datetime,
     p_environment varchar(255),
	 p_processingJobId int(11) unsigned,
	 p_recordTimestamp datetime
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row. Otherwise updates existing row if uts processingStatus is NULL + other conditions.'
BEGIN
	DECLARE row_processingStatus tinyint(1) DEFAULT NULL;
	DECLARE row_processingEndTime datetime DEFAULT NULL;
	
    -- DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
    
	IF p_id IS NULL THEN
        -- creates a new row in AutoProcProgram with processingJobId set, and all the other values populated with the given values,
	    INSERT INTO AutoProcProgram (processingStatus, processingStartTime, processingEndTime, processingMessage, processingJobId,
		  processingCommandLine, processingPrograms, processingEnvironment, recordTimestamp)
		  VALUES (
              p_status, 
              p_startTimestamp,
              p_updateTimestamp,
              p_updateMessage, 
              p_processingJobId, 
              p_commandLine,
              p_programs,
              p_environment,
              -- apart from recordTimeStamp, which, if given as NULL, is populated with NOW()
              IFNULL(p_recordTimestamp, NOW())
		  );
        SET p_id = LAST_INSERT_ID();
	ELSE
		START TRANSACTION;
	    SELECT processingStatus, processingEndTime INTO row_processingStatus, row_processingEndTime 
		FROM AutoProcProgram 
        WHERE autoProcProgramId = p_id;

          -- If the existing value in processingStatus is not NULL then the row must not be updated. Stop reading here.
          -- If the existing value in processingEndTime is not NULL and update time is not NULL and 
          -- processingEndTime is greater (>) than update time and the new status value is NULL then the row must not be 
          -- updated. Stop reading here.
		IF row_processingStatus IS NULL AND (
            row_processingEndTime IS NULL OR p_updateTimestamp IS NULL OR 
              row_processingEndTime <= p_updateTimestamp OR p_status IS NOT NULL) THEN 

		    UPDATE AutoProcProgram 
            SET 
              -- Write status to processingStatus
              processingStatus = p_status,
			  --  If processingStartTime is NULL then write start time to processingStartTime. If start time is also NULL, 
			  -- then write NOW() instead
              processingStartTime = COALESCE(processingStartTime, p_startTimestamp, NOW()),
              -- Write update time to processingEndTime. If update time is NULL then write NOW() to processingEndTime
              processingEndTime = IFNULL(p_updateTimestamp, NOW()), 
              -- If update message is not NULL then write update message to processingMessage.
              processingMessage = IFNULL(p_updateMessage, processingMessage), 
              processingJobId = IFNULL(p_processingJobId, processingJobId),
              processingCommandLine = IFNULL(p_commandLine, processingCommandLine),
              processingPrograms = IFNULL(p_programs, processingPrograms),
			  processingEnvironment = IFNULL(p_environment, processingEnvironment)
		    WHERE autoProcProgramId = p_id;
        END IF;
        COMMIT;
    END IF;

    COMMIT;
END;;
DELIMITER ;
