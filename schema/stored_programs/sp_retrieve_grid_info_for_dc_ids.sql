DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_grid_info_for_dc_ids`(IN p_dcIds TEXT) 
READS SQL DATA
COMMENT 'Return multi-row result-set with dc ID, grid info and some additional related dc values'
BEGIN
    IF NOT (p_dcIds IS NULL) THEN
      SELECT
        dc.datacollectionid,
        gi.dx_mm,
        gi.dy_mm,
        gi.steps_x,
        gi.steps_y,
        gi.pixelsPerMicronX,
        gi.pixelsPerMicronY,
        gi.snapshot_offsetXPixel,
        gi.snapshot_offsetYPixel,
        gi.orientation,
        gi.snaked,
        dc.beamSizeAtSampleX,
        dc.beamSizeAtSampleY,
        dc.imageDirectory,
        dc.imagePrefix,
        dc.imageSuffix,
        dc.fileTemplate,
        dc.xtalSnapshotFullPath1,
        dc.xtalSnapshotFullPath2,
        dc.xtalSnapshotFullPath3,
        dc.xtalSnapshotFullPath4
    FROM GridInfo gi
      INNER JOIN DataCollection dc ON dc.dataCollectionGroupId = gi.dataCollectionGroupId
    WHERE FIND_IN_SET(dc.dataCollectionId, p_dcIds);
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_dcIds is NULL';
    END IF;
END;;
DELIMITER ;
