DELIMITER ;;
CREATE PROCEDURE `upsert_dc_grid`(
  INOUT p_id int(11) unsigned,
  p_dcId int(11) unsigned,
  p_dxInMm double,
  p_dyInMm double,
  p_stepsX double,
  p_stepsY double,
  p_meshAngle double,
  p_pixelsPerMicronX float,
  p_pixelsPerMicronY float,
  p_snapshotOffsetXPixel float,
  p_snapshotOffsetYPixel float,
  p_orientation enum('vertical','horizontal'),
  p_snaked boolean
)
    MODIFIES SQL DATA
BEGIN
        IF p_dcId IS NOT NULL THEN
      INSERT INTO GridInfo (gridInfoId, dataCollectionId, dx_mm, dy_mm, steps_x, steps_y, meshAngle, pixelsPerMicronX, pixelsPerMicronY,
        snapshot_offsetXPixel, snapshot_offsetYPixel, orientation, snaked)
        VALUES (p_id, p_dcId, p_dxInMm, p_dyInMm, p_stepsX, p_stepsY, p_meshAngle, p_pixelsPerMicronX, p_pixelsPerMicronY,
        p_snapshotOffsetXPixel, p_snapshotOffsetYPixel, p_orientation, p_snaked)
        ON DUPLICATE KEY UPDATE
                  dataCollectionId = IFNULL(p_dcId, dataCollectionId),
                  dx_mm = IFNULL(p_dxInMm, dx_mm),
                  dy_mm = IFNULL(p_dyInMm, dy_mm),
                  steps_x = IFNULL(p_stepsX, steps_x),
                  steps_y = IFNULL(p_stepsY, steps_y),
                  meshAngle = IFNULL(p_meshAngle, meshAngle),
                  pixelsPerMicronX = IFNULL(p_pixelsPerMicronX, pixelsPerMicronX),
                  pixelsPerMicronY = IFNULL(p_pixelsPerMicronY, pixelsPerMicronY),
                  snapshot_offsetXPixel = IFNULL(p_snapshotOffsetXPixel, snapshot_offsetXPixel),
                  snapshot_offsetYPixel = IFNULL(p_snapshotOffsetYPixel, snapshot_offsetYPixel),
                  orientation = IFNULL(p_orientation, orientation),
                  snaked = IFNULL(p_snaked, snaked);
          IF LAST_INSERT_ID() <> 0 THEN
                  SET p_id = LAST_INSERT_ID();
      END IF;
        END IF;
END ;;
DELIMITER ;