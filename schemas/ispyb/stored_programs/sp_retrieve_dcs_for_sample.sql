DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dcs_for_sample`(p_id int unsigned)
READS SQL DATA
COMMENT 'Return a multi-row result-set with the data-collection-main compatible records for the given sample ID'
BEGIN
    IF p_id IS NOT NULL THEN

	SELECT DISTINCT dc.dataCollectionId "id",
	    dc.dataCollectionGroupId "groupId",
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
	    dc.imageContainerSubPath "imgContainerSubPath",
	    dc.fileTemplate "fileTemplate",
	    dc.xtalSnapshotFullPath1 "snapshot1",
	    dc.xtalSnapshotFullPath2 "snapshot2",
	    dc.xtalSnapshotFullPath3 "snapshot3",
	    dc.xtalSnapshotFullPath4 "snapshot4",
	    dc.comments "comments"
	FROM BLSample bls
	    INNER JOIN DataCollection dc ON bls.blSampleId = dc.BLSAMPLEID
	WHERE bls.blSampleId = p_id;

    ELSE
	 SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	 MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
    END IF;

END;;
DELIMITER ;
