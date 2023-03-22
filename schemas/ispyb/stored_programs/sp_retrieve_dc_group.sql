DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc_group`(p_id int unsigned)
READS SQL DATA
COMMENT 'Returns a single-row result-set with the columns for the given data collection group id'
BEGIN
    IF p_id IS NOT NULL THEN
      SELECT p.proposalCode, p.proposalNumber, bs.visit_number "sessionNumber", dcg.sessionId, dcg.blSampleId "sampleId", dcg.experimentType "experimenttype", dcg.startTime "starttime", dcg.endTime "endtime",
        dcg.crystalClass, dcg.detectorMode, dcg.actualSampleBarcode, dcg.actualSampleSlotInContainer, dcg.actualContainerBarcode, dcg.actualContainerSlotInSC,
        dcg.comments, dcg.xtalSnapshotFullPath, dcg.scanParameters
      FROM DataCollectionGroup dcg
        JOIN BLSession bs ON bs.sessionId = dcg.sessionId
        JOIN Proposal p ON p.proposalId = bs.proposalId
      WHERE datacollectionGroupId = p_id;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
