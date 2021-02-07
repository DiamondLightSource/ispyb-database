DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc_group_v2`(p_id int unsigned, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns a single-row result-set with the columns for the given data collection group id'
BEGIN
    IF p_id IS NOT NULL THEN
      IF p_authLogin IS NOT NULL THEN
      -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.
        SELECT dcg.sessionId,
          dcg.blSampleId "sampleId",
          dcg.experimentType "experimenttype",
          dcg.startTime "starttime",
          dcg.endTime "endtime",
          dcg.crystalClass,
          dcg.detectorMode,
          dcg.actualSampleBarcode,
          dcg.actualSampleSlotInContainer,
          dcg.actualContainerBarcode,
          dcg.actualContainerSlotInSC,
          dcg.comments,
          dcg.xtalSnapshotFullPath,
          dcg.scanParameters
        FROM DataCollectionGroup dcg
          INNER JOIN BLSession bs ON dcg.sessionId = bs.sessionId
          INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
          INNER JOIN Person p ON p.personId = shp.personId
        WHERE dcg.datacollectionGroupId = p_id AND p.login = p_authLogin;

      ELSE

        SELECT dcg.sessionId,
          dcg.blSampleId "sampleId",
          dcg.experimentType "experimenttype",
          dcg.startTime "starttime",
          dcg.endTime "endtime",
          dcg.crystalClass,
          dcg.detectorMode,
          dcg.actualSampleBarcode,
          dcg.actualSampleSlotInContainer,
          dcg.actualContainerBarcode,
          dcg.actualContainerSlotInSC,
          dcg.comments,
          dcg.xtalSnapshotFullPath,
          dcg.scanParameters
        FROM DataCollectionGroup dcg
        WHERE dcg.datacollectionGroupId = p_id;
      END IF;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
