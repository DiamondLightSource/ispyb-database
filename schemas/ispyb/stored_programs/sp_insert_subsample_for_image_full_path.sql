DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_subsample_for_image_full_path`(
     OUT p_id int(11) unsigned,
     p_imageFullPath varchar(255),
     p_source varchar(10),
--     p_type varchar(10),
     p_position1x double,
     p_position1y double,
     p_position2x double,
     p_position2y double
  )
    MODIFIES SQL DATA
    COMMENT 'Returns subsample ID in p_id.'
BEGIN
  DECLARE l_position1Id, l_position2Id, l_sampleId int unsigned DEFAULT NULL;
  DECLARE EXIT HANDLER FOR SQLWARNING
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='SQLWARNING, transaction rollback';
  END;

  IF p_imageFullPath IS NOT NULL AND p_source IS NOT NULL AND p_position1x IS NOT NULL AND p_position1y IS NOT NULL THEN
    SELECT blSampleId INTO l_sampleId
    FROM BLSampleImage
    WHERE imageFullPath = p_imageFullPath
    ORDER BY blSampleImageId DESC
    LIMIT 1;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_imageFullPath, p_source, p_position1x, p_position1y cannot be NULL';
  END IF;

  IF l_sampleId IS NOT NULL THEN

    START TRANSACTION;

    INSERT INTO Position (posX, posY) VALUES (p_position1x, p_position1y); 
    SET l_position1Id := LAST_INSERT_ID();

    IF p_position2x IS NOT NULL AND p_position2y IS NOT NULL THEN
      INSERT INTO Position (posX, posY) VALUES (p_position2x, p_position2y);
      SET l_position2Id := LAST_INSERT_ID();
    END IF;

    INSERT INTO BLSubSample (
      blSampleId,
      source,
--      type,
      positionId, 
      position2Id
    )
      VALUES (l_sampleId, p_source, /*p_type,*/ l_position1Id, l_position2Id);
    SET p_id := LAST_INSERT_ID();

    COMMIT;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Image p_imageFullPath not found in table';
  END IF;
END;;
DELIMITER ;
