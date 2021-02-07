DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_grid_info_for_dcg_v2`(IN p_dcgId int unsigned, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Return multi-row result-set with grid info values for the dcg'
BEGIN
    IF NOT (p_dcgId IS NULL) THEN
        IF p_authLogin IS NOT NULL THEN
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
                INNER JOIN DataCollectionGroup dcg ON gi.dataCollectionGroupId = dcg.dataCollectionGroupId
                INNER JOIN Session_has_Person shp ON dcg.sessionId = shp.sessionId
                INNER JOIN Person per ON per.personId = shp.personId
            WHERE per.login = p_authLogin AND gi.dataCollectionGroupId = p_dcgId
            GROUP BY gi.gridInfoId,
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
            ORDER BY gi.gridInfoId ASC;
        ELSE         
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
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_dcgId is NULL';
    END IF;
END;;
DELIMITER ;
