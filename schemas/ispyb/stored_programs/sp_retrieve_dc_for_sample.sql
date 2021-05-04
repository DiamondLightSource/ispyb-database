DELIMITER ;;
CREATE OR REPLACE DEFINIER=`ispyb_root`@`%` PROCEDURE `retrieve_data_collections_for_sample`(p_sampleId int unsigned)
READS SQL DATA
COMMENT 'Return a multi-row result-set with the data-collection-main compatible records for the given sample ID'
BEGIN
    IF p_sampleId IS NOT NULL THEN

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
	    dc.imageDirectory "imageDirectort",
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
	    LEFT OUTER JOIN BLSubSample bss ON bls.blSampleId = bss.blSampleId
	    INNER JOIN DataCollection dc ON bls.blSampleId = dc.BLSAMPLEID
		OR bss.blSubSampleId = dc.blSubSampleId
	WHERE bls.blSampleId = p_sampleId;

    ELSE
	 SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	 MESSAGE_TEXT='Mandatory argument p_sampleId can not be NULL';
    END IF;

END;;
DELIMITER ;
