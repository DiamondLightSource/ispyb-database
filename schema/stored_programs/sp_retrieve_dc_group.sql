DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc_group`(p_id int unsigned)
READS SQL DATA
COMMENT 'Returns a single-row result-set with the columns for the given data collection group id'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT sessionId, blsampleId, experimentType, startTime, endTime,
        crystalClass, detectorMode, actualSampleBarcode, actualSampleSlotInContainer, actualContainerBarcode, actualContainerSlotInSC,
        comments, xtalSnapshotFullPath, scanParameters
      FROM DataCollectionGroup
      WHERE datacollectionGroupId = p_id;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
