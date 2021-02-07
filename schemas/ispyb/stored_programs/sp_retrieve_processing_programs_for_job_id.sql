DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_programs_for_job_id`(p_id int unsigned)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with processing program instances for the given processing job ID'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT autoProcProgramId "id", processingCommandLine "commandLine", processingPrograms "programs",
          processingStatus "status", processingMessage "message", processingStartTime "startTime",
          processingEndTime "endTime", processingEnvironment "environment",
          recordTimeStamp "recordTimeStamp", processingJobId "jobId"
      FROM AutoProcProgram  
	  WHERE processingJobId = p_id
      ORDER BY autoProcProgramId ASC
      LIMIT 1000;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
