DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_grid_info`(
	OUT p_id int(11) unsigned,
	p_xOffset double,
	p_yOffset double,
	p_dx_mm double,
	p_dy_mm double,
	p_steps_x double,
	p_steps_y double,
	p_meshAngle double,
	p_recordTimeStamp timestamp,
	p_workflowMeshId int(11) unsigned,
	p_orientation enum('vertical', 'horizontal'),
	p_dataCollectionGroupId int(11),
	p_pixelsPerMicronX float,
	p_pixelsPerMicronY float,
	p_snapshot_offsetXPixel float,
	p_snapshot_offsetYPixel float,
	p_snaked tinyint(1),
	p_dataCollectionId int(11) unsigned)
MODIFIES SQL DATA
COMMENT 'Inserts a row into the GridInfo table.\nReturns Record ID in p_id.'
BEGIN

	INSERT INTO GridInfo
		(xOffset, yOffset, dx_mm, dy_mm, steps_x, steps_y, meshAngle, recordTimeStamp,
		workflowMeshId, orientation, dataCollectionGroupId, pixelsPerMicronX,
		pixelsPerMicronY, snapshot_offsetXPixel, snapshot_offsetYPixel, snaked,
		dataCollectionId)
	VALUES
		(p_xOffset, p_yOffset, p_dx_mm, p_dy_mm, p_steps_x, p_steps_y, p_meshAngle, p_recordTimeStamp,
		p_workflowMeshId, p_orientation, p_dataCollectionGroupId, p_pixelsPerMicronX,
		p_pixelsPerMicronY, p_snapshot_offsetXPixel, p_snapshot_offsetYPixel, p_snaked,
		p_dataCollectionId);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
