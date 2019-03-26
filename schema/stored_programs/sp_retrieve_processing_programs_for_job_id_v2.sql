DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_programs_for_job_id_v2`(p_id int unsigned, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns a multi-row result-set with processing program instances for the given processing job ID'
BEGIN
    IF p_id IS NOT NULL THEN
        IF p_authLogin IS NOT NULL THEN
            SELECT app.autoProcProgramId "id", app.processingCommandLine "commandLine", app.processingPrograms "programs",
                app.processingStatus "status", app.processingMessage "message", app.processingStartTime "startTime",
                app.processingEndTime "endTime", app.processingEnvironment "environment",
                app.recordTimeStamp "recordTimeStamp", app.processingJobId "jobId"
            FROM AutoProcProgram app  
                INNER JOIN ProcessingJob pj ON pj.processingJobId = app.processingJobId
                INNER JOIN DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
                INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId = dc.dataCollectionGroupId
                INNER JOIN Session_has_Person shp ON shp.sessionId = dcg.sessionId
                INNER JOIN Person per ON per.personId = shp.personId 
	        WHERE app.processingJobId = p_id AND per.login = p_authLogin
            GROUP BY app.autoProcProgramId, app.processingCommandLine, app.processingPrograms,
                app.processingStatus, app.processingMessage, app.processingStartTime,
                app.processingEndTime, app.processingEnvironment,
                app.recordTimeStamp, app.processingJobId
            ORDER BY app.autoProcProgramId ASC
            LIMIT 1000;
        ELSE
            SELECT app.autoProcProgramId "id", app.processingCommandLine "commandLine", app.processingPrograms "programs",
                app.processingStatus "status", app.processingMessage "message", app.processingStartTime "startTime",
                app.processingEndTime "endTime", app.processingEnvironment "environment",
                app.recordTimeStamp "recordTimeStamp", app.processingJobId "jobId"
            FROM AutoProcProgram app  
	        WHERE app.processingJobId = p_id
            ORDER BY app.autoProcProgramId ASC
            LIMIT 1000;
        END IF;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
