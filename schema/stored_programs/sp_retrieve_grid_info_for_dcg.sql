DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_grid_info_for_dcg`(IN p_dcgId int unsigned)
READS SQL DATA
COMMENT 'Return multi-row result-set with grid info values for the dcg'
BEGIN
    IF NOT (p_dcgId IS NULL) THEN
      SELECT
        gi.gridInfoId,
        gi.dx_mm,
        gi.dy_mm,
        gi.steps_x,
        gi.steps_y,
        gi.meshAngle,
        gi.pixelsPerMicronX,
        gi.pixelsPerMicronY,
        gi.snapshot_offsetXPixel,
        gi.snapshot_offsetYPixel,
        gi.orientation,
        gi.snaked
    FROM GridInfo gi
    WHERE gi.dataCollectionGroupId = p_dcgId
    ORDER BY gi.gridInfoId ASC;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_dcgId is NULL';
    END IF;
END;;
DELIMITER ;
