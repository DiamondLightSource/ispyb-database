DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_sample_image`(
     INOUT p_id int(11) unsigned,
     p_sampleId int(11) unsigned,
     p_containerInspectionId int(11) unsigned,
     p_micronsPerPixelX float,
     p_micronsPerPixelY float,
     p_imageFullPath varchar(255),
     p_comments varchar(255)
  )
    MODIFIES SQL DATA
    COMMENT 'If p_id is not provided, inserts new row and returns ID in p_id. Otherwise updates existing row.'
BEGIN
	IF p_id IS NULL THEN
    INSERT INTO BLSampleImage (blSampleId, containerInspectionId, micronsPerPixelX, micronsPerPixelY, imageFullPath, comments, blTimeStamp)
            VALUES (p_sampleId, p_containerInspectionId, p_micronsPerPixelX, p_micronsPerPixelY, p_imageFullPath, p_comments, current_timestamp);
    SET p_id = LAST_INSERT_ID();

  ELSE
    UPDATE BLSampleImage
    SET
      blSampleId = IFNULL(p_sampleId, blSampleId),
      containerInspectionId = IFNULL(p_containerInspectionId, containerInspectionId),
      micronsPerPixelX = IFNULL(p_micronsPerPixelX, micronsPerPixelX),
      micronsPerPixelY = IFNULL(p_micronsPerPixelY, micronsPerPixelY),
      imageFullPath = IFNULL(p_imageFullPath, imageFullPath),
      comments = IFNULL(p_comments, comments),
      modifiedTimeStamp = current_timestamp
    WHERE blSampleImageId = p_id;
  END IF;
END;;
DELIMITER ;
