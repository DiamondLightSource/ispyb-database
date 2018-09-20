DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc_main`(p_id int unsigned) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the main data collection info for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN
		SELECT dataCollectionGroupId "groupId",
			detectorId "detectorId",
			blSubSampleId "blSubSampleId",
			dataCollectionNumber "dcNumber",
			startTime "startTime",
			endTime "endTime",
			runStatus "status",
			numberOfImages "noImages",
			startImageNumber "startImgNumber",
			numberOfPasses "noPasses",
			imageDirectory "imgDir",
			imagePrefix "imgPrefix",
			imageSuffix "imgSuffix",
			fileTemplate "fileTemplate",
			xtalSnapshotFullPath1 "snapshot1",
			xtalSnapshotFullPath2 "snapshot2",
			xtalSnapshotFullPath3 "snapshot3",
			xtalSnapshotFullPath4 "snapshot4",
			comments "comments"
		FROM DataCollection 
		WHERE dataCollectionId = p_id;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

