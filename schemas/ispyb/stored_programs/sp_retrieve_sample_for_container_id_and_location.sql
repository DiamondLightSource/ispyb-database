DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sample_for_container_id_and_location`(IN p_containerId int(11) unsigned, p_location varchar(45))
READS SQL DATA
COMMENT 'Return single-row result set with info about a BLSample identified by p_containerId and p_location'
BEGIN
    IF NOT (p_containerId IS NULL OR p_location IS NULL) THEN
      SELECT bls.blSampleId "sampleId",
        bls.name "sampleName",
        bls.code "sampleCode",
        bls.comments "sampleComments",
        bls.location "sampleLocation"
      FROM BLSample bls
      WHERE bls.location = p_location AND bls.containerId = p_containerId
      LIMIT 1;
    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_containerId and/or p_location';
    END IF;
END;;
DELIMITER ;
