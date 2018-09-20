DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_robot_action`(
	 INOUT p_id int(11) unsigned,
	 p_sessionId int(11) unsigned,
	 p_sampleId int(11) unsigned,
	 p_actionType varchar(15),
	 p_startTimestamp timestamp,
	 p_endTimestamp timestamp,
	 p_status varchar(24),
	 p_message varchar(255),
	 p_containerLocation smallint,
	 p_dewarLocation smallint,
	 p_sampleBarcode varchar(45),
	 p_snapshotBefore varchar(255),
	 p_snapshotAfter varchar(255)
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a robot action (p_id).\nMandatory columns:\nFor insert: p_sessionId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
	IF p_id IS NOT NULL OR p_sessionId IS NOT NULL THEN
		INSERT INTO RobotAction (robotActionId, blsessionId, blsampleId, actionType, startTimestamp, endTimestamp, status, message,
			containerLocation, dewarLocation, sampleBarcode, xtalSnapshotBefore, xtalSnapshotAfter)
			VALUES (p_id, p_sessionId, p_sampleId, p_actionType, p_startTimestamp, p_endTimestamp, p_status, p_message,
				p_containerLocation, p_dewarLocation, p_sampleBarcode, p_snapshotBefore, p_snapshotAfter)
			ON DUPLICATE KEY UPDATE
				blsessionId = IFNULL(p_sessionId, blsessionId),
				blsampleId = IFNULL(p_sampleId, blsampleId),
				actionType = IFNULL(p_actionType, actionType),
				startTimestamp = IFNULL(p_startTimestamp, startTimestamp),
				endTimestamp = IFNULL(p_endTimestamp, endTimestamp),
				status = IFNULL(p_status, status),
				message = IFNULL(p_message, message),
				containerLocation = IFNULL(p_containerLocation, containerLocation),
				dewarLocation = IFNULL(p_dewarLocation, dewarLocation),
				sampleBarcode = IFNULL(p_sampleBarcode, sampleBarcode),
				xtalSnapshotBefore = IFNULL(p_snapshotBefore, xtalSnapshotBefore),
				xtalSnapshotAfter = IFNULL(p_snapshotAfter, xtalSnapshotAfter);

			IF p_id IS NULL THEN
				SET p_id = LAST_INSERT_ID();
			END IF;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_sessionId must be non-NULL.';
	END IF;
END;;
DELIMITER ;
