DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_subsample`(
     OUT p_id int(11) unsigned,
     p_sampleId int(11) unsigned,
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
  DECLARE v_position1Id, v_position2Id int unsigned;
  
  IF p_sampleId IS NOT NULL AND p_source IS NOT NULL AND p_position1x IS NOT NULL AND p_position1y IS NOT NULL THEN

    START TRANSACTION;

    INSERT INTO Position (posX, posY) VALUES (p_position1x, p_position1y); 
    SET v_position1Id := LAST_INSERT_ID();

    IF p_position1x IS NOT NULL AND p_position2x IS NOT NULL THEN
      INSERT INTO Position (posX, posY) VALUES (p_position2x, p_position2y);
      SET v_position2Id := LAST_INSERT_ID();
    END IF;

    INSERT INTO BLSubSample (
      blSampleId,
      source,
--      type,
      positionId, 
      position2Id
    )
      VALUES (p_sampleId, p_source, /*p_type,*/ v_position1Id, v_position2Id);
    SET p_id := LAST_INSERT_ID();

    COMMIT;
  END IF;
END;;
DELIMITER ;
