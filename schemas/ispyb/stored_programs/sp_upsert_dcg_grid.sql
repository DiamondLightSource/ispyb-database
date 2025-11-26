-- Example call:
-- SET @id := NULL;
-- CALL upsert_dcg_grid(@id, 5440739, 1, 2, 10, 20, 7, 0.7, 0.8, 4.5, 4.6, 'vertical', 1);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_dcg_grid`(
  INOUT p_id int(11) unsigned,
  p_dcgId int(11) unsigned,
  p_dxInMm double,
  p_dyInMm double,
  p_stepsX double,
  p_stepsY double,
  p_meshAngle double,
  p_micronsPerPixelX float,
  p_micronsPerPixelY float,
  p_snapshotOffsetXPixel float,
  p_snapshotOffsetYPixel float,
  p_orientation enum('vertical','horizontal'),
  p_snaked boolean
)
    MODIFIES SQL DATA
BEGIN
	IF p_dcgId IS NOT NULL THEN
      INSERT INTO GridInfo (gridInfoId, dataCollectionGroupId, dx_mm, dy_mm, steps_x, steps_y, meshAngle,
        micronsPerPixelX, micronsPerPixelY,
        snapshot_offsetXPixel, snapshot_offsetYPixel, orientation, snaked)
        VALUES (p_id, p_dcgId, p_dxInMm, p_dyInMm, p_stepsX, p_stepsY, p_meshAngle,
        p_micronsPerPixelX, p_micronsPerPixelY,
        p_snapshotOffsetXPixel, p_snapshotOffsetYPixel, p_orientation, p_snaked)
        ON DUPLICATE KEY UPDATE
		  dataCollectionGroupId = IFNULL(p_dcgId, dataCollectionGroupId),
		  dx_mm = IFNULL(p_dxInMm, dx_mm),
		  dy_mm = IFNULL(p_dyInMm, dy_mm),
		  steps_x = IFNULL(p_stepsX, steps_x),
		  steps_y = IFNULL(p_stepsY, steps_y),
		  meshAngle = IFNULL(p_meshAngle, meshAngle),
		  micronsPerPixelX = IFNULL(p_pixelsPerMicronX, micronsPerPixelX),
		  micronsPerPixelY = IFNULL(p_pixelsPerMicronY, micronsPerPixelY),
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
