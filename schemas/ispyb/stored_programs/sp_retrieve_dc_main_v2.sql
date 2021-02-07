DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc_main_v2`(p_id int unsigned, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the main data collection info for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN

    	IF p_authLogin IS NOT NULL THEN
    	-- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

				SELECT dc.dataCollectionGroupId "groupId",
					dc.detectorId "detectorId",
					dc.blSubSampleId "blSubSampleId",
					dc.dataCollectionNumber "dcNumber",
					dc.startTime "startTime",
					dc.endTime "endTime",
					dc.runStatus "status",
					dc.numberOfImages "noImages",
					dc.startImageNumber "startImgNumber",
					dc.numberOfPasses "noPasses",
					dc.imageDirectory "imgDir",
					dc.imagePrefix "imgPrefix",
					dc.imageSuffix "imgSuffix",
					dc.fileTemplate "fileTemplate",
					dc.xtalSnapshotFullPath1 "snapshot1",
					dc.xtalSnapshotFullPath2 "snapshot2",
					dc.xtalSnapshotFullPath3 "snapshot3",
					dc.xtalSnapshotFullPath4 "snapshot4",
					dc.comments "comments"
				FROM DataCollection dc
					INNER JOIN DataCollectionGroup dcg ON dc.dataCollectionGroupId = dcg.dataCollectionGroupId
        	INNER JOIN BLSession bs ON dcg.sessionId = bs.sessionId 
        	INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
        	INNER JOIN Person p ON p.personId = shp.personId
	  		WHERE p.login = p_authLogin AND	dc.dataCollectionId = p_id;

    	ELSE 

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

    	END IF;

    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

