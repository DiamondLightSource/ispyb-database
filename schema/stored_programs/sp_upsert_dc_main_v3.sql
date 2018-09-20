DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_dc_main_v3`(
     INOUT p_id int(11) unsigned,
     p_groupId int(11) unsigned,
     p_detectorId int(11),
     p_blSubSampleId int(11) unsigned,
     p_dcNumber int(10) unsigned,
     p_startTime datetime,
     p_endTime datetime,
     p_status varchar(45),
     p_noImages int(10) unsigned,
	   p_startImgNumber int(10) unsigned,
	   p_noPasses int(10) unsigned,
     p_imgDir varchar(255),
	   p_imgPrefix varchar(45),
     p_imgSuffix varchar(45),
     p_imgContainerSubPath varchar(255),
     p_fileTemplate varchar(255),
     p_snapshot1 varchar(255),
     p_snapshot2 varchar(255),
     p_snapshot3 varchar(255),
     p_snapshot4 varchar(255),
     p_comments varchar(1024)
)
    MODIFIES SQL DATA
    COMMENT 'Inserts (if p_id not provided) or updates a row in DataCollection, returns ID in p_id. '
BEGIN
    INSERT INTO DataCollection (dataCollectionId, dataCollectionGroupId, sessionId, blSampleId, blSubSampleId, detectorId, datacollectionNumber, startTime, endTime,
        runStatus, numberOfImages, startImageNumber, numberOfPasses, imageDirectory, imagePrefix, imageSuffix, imageContainerSubPath, fileTemplate,
        xtalSnapshotFullPath1, xtalSnapshotFullPath2, xtalSnapshotFullPath3, xtalSnapshotFullPath4, comments)
      VALUES (p_id, p_groupId,
      (SELECT sessionId FROM DataCollectionGroup WHERE dataCollectionGroupId = p_groupId),
      (SELECT blSampleId FROM DataCollectionGroup WHERE dataCollectionGroupId = p_groupId),
      p_blSubSampleId,
      p_detectorId,
      p_dcNumber, p_startTime, p_endTime,
      p_status, p_noImages, p_startImgNumber, p_noPasses, p_imgDir, p_imgPrefix, p_imgSuffix, p_imgContainerSubPath, p_fileTemplate,
      p_snapshot1, p_snapshot2, p_snapshot3, p_snapshot4, comments)
      ON DUPLICATE KEY UPDATE
		    datacollectiongroupid = IFNULL(p_groupId, datacollectiongroupid),
		    blSubSampleId = IFNULL(p_blSubSampleId, blSubSampleId),
        detectorId = IFNULL(p_detectorId, detectorId),
        datacollectionNumber = IFNULL(p_dcNumber, datacollectionNumber),
        starttime = IFNULL(p_starttime, starttime),
        endtime = IFNULL(p_endtime, endtime),
        runStatus = IFNULL(p_status, runStatus),
        numberOfImages = IFNULL(p_noImages, numberOfImages),
        startImageNumber = IFNULL(p_noImages, startImageNumber),
        numberOfPasses = IFNULL(p_noPasses, numberOfPasses),
        imagedirectory = IFNULL(p_imgDir, imagedirectory),
        imageprefix = IFNULL(p_imgPrefix, imageprefix),
        imagesuffix = IFNULL(p_imgSuffix, imagesuffix),
        imageContainerSubPath = IFNULL(p_imgContainerSubPath, imageContainerSubPath),
        fileTemplate = IFNULL(p_fileTemplate, fileTemplate),
        xtalSnapshotFullPath1 = IFNULL(p_snapshot1, xtalSnapshotFullPath1),
        xtalSnapshotFullPath2 = IFNULL(p_snapshot2, xtalSnapshotFullPath2),
        xtalSnapshotFullPath3 = IFNULL(p_snapshot3, xtalSnapshotFullPath3),
        xtalSnapshotFullPath4 = IFNULL(p_snapshot4, xtalSnapshotFullPath4),
        comments = IFNULL(p_comments, comments);
	IF p_id IS NULL THEN
		SET p_id = LAST_INSERT_ID();
    END IF;
  END;;
DELIMITER ;
