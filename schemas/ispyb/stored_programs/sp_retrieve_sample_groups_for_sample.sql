DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sample_groups_for_sample`(IN p_sampleId int unsigned) 
READS SQL DATA
COMMENT 'Return multi-row result-set with sample group IDs, order in the group and type for sample p_sampleId'
BEGIN
    IF NOT (p_sampleId IS NULL) THEN
        SELECT blSampleGroupId "sampleGroupId", groupOrder "order", `type` 
        FROM BLSampleGroup_has_BLSample 
        WHERE blSampleId=p_sampleId;
	ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_sampleId is NULL';
    END IF;
END;;
DELIMITER ;


