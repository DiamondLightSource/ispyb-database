DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dcs_for_sample`(p_id int unsigned)
READS SQL DATA
COMMENT 'Return a multi-row result-set with the data-collection-main compatible records for the given sample ID'
BEGIN
    IF p_id IS NOT NULL THEN

	SELECT DISTINCT dc.dataCollectionId "dataCollectionId",
	    dc.dataCollectionGroupId "dataCollectionGroupId",
	    dc.detectorId "detectorId",
	    dc.blSubSampleId "blSubSampleId",
	    dc.dataCollectionNumber "dataCollectionNumber",
	    dc.startTime "startTime",
	    dc.endTime "endTime",
	    dc.runStatus "runStatus",
	    dc.numberOfImages "numberOfImages",
	    dc.startImageNumber "startImageNumber",
	    dc.numberOfPasses "numberOfPasses",
	    dc.imageDirectory "imageDirectory",
	    dc.imagePrefix "imagePrefix",
	    dc.imageSuffix "imageSuffix",
	    dc.imageContainerSubPath "imageContainerSubPath",
	    dc.fileTemplate "fileTemplate",
	    dc.xtalSnapshotFullPath1 "xtalSnapshotFullPath1",
	    dc.xtalSnapshotFullPath2 "xtalSnapshotFullPath2",
	    dc.xtalSnapshotFullPath3 "xtalSnapshotFullPath3",
	    dc.xtalSnapshotFullPath4 "xtalSnapshotFullPath4",
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
