DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_processing_job_v2`(p_id int unsigned, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns a single-row result-set with info about the processing job for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN
        IF p_authLogin IS NOT NULL THEN
            SELECT pj.dataCollectionId "dataCollectionId", pj.displayName "displayName", pj.comments "comments",
                pj.recordTimestamp "recordTimestamp", pj.recipe "recipe", pj.automatic "automatic"
            FROM ProcessingJob pj
                INNER JOIN DataCollection dc ON dc.dataCollectionId = pj.dataCollectionId
                INNER JOIN DataCollectionGroup dcg ON dcg.dataCollectionGroupId = dc.dataCollectionGroupId
                INNER JOIN Session_has_Person shp ON shp.sessionId = dcg.sessionId
                INNER JOIN Person per ON per.personId = shp.personId 
	        WHERE pj.processingJobId = p_id AND per.login = p_authLogin
            LIMIT 1;
        ELSE
            SELECT pj.dataCollectionId "dataCollectionId", pj.displayName "displayName", pj.comments "comments",
                pj.recordTimestamp "recordTimestamp", pj.recipe "recipe", pj.automatic "automatic"
            FROM ProcessingJob pj
	        WHERE pj.processingJobId = p_id
            LIMIT 1;
        END IF;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
