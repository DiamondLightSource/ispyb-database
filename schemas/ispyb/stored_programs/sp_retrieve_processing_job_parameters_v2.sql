DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_job_parameters_v2`(p_id int unsigned, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a multi-row result-set (max 1000) with parameters for the given processing job ID'
BEGIN
    IF p_id IS NOT NULL THEN
        IF p_authLogin IS NOT NULL THEN
            SELECT pjp.processingJobParameterId "parameterId", pjp.parameterKey "parameterKey", pjp.parameterValue "parameterValue"
            FROM ProcessingJobParameter pjp 
                INNER JOIN ProcessingJob pj ON pj.processingJobId = pjp.processingJobId
                INNER JOIN DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
                INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId = dc.dataCollectionGroupId
                INNER JOIN Session_has_Person shp ON shp.sessionId = dcg.sessionId
                INNER JOIN Person per ON per.personId = shp.personId 
	        WHERE pjp.processingJobId = p_id AND per.login = p_authLogin
            GROUP BY pjp.processingJobParameterId, pjp.parameterKey, pjp.parameterValue 
            ORDER BY pjp.processingJobParameterId ASC
            LIMIT 1000;
        ELSE
            SELECT pjp.processingJobParameterId "parameterId", pjp.parameterKey "parameterKey", pjp.parameterValue "parameterValue"
            FROM ProcessingJobParameter pjp 
	        WHERE pjp.processingJobId = p_id
            ORDER BY pjp.processingJobParameterId ASC
            LIMIT 1000;
        END IF;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

