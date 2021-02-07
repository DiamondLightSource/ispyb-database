/* Test call:
CALL retrieve_sample_type_for_sample(11677);
*/

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sample_type_for_sample`(IN p_sampleId int unsigned) 
READS SQL DATA
COMMENT 'Return single-row result set with sample type columns for sample p_sampleId'
BEGIN
    IF NOT (p_sampleId IS NULL) THEN
		SELECT c.crystalId "sampleTypeId", c.proteinId "componentId", c.name "name", c.comments "comments"
        FROM Crystal c
          INNER JOIN BLSample bls ON c.crystalId = bls.crystalId
        WHERE bls.blSampleId = p_sampleId
        ORDER BY c.crystalId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_sampleId';
    END IF;
END ;;
DELIMITER ;
