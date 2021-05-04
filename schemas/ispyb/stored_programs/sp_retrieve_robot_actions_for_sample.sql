DELIMITER ;;

CREATE OR REPLACE DEFINER `ispyb_root`@`%` PROCEDURE `retrieve_robot_actions_for_sample`(
	p_id int unsigned,
	p_useRobotActionSession boolean,
	p_authLogin varchar(45)
)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the robot actions for the given sample ID.'
BEGIN

	IF p_id IS NOT NULL THEN

		IF p_useRobotActionSession = True THEN

			IF p_authlogin IS NOT NULL THEN
			-- Authorise if the persion (p_authLogin) is a member of a session on the proposal.

				SELECT DISTINCT 
				ra.robotActionId "robotActionId",
				ra.blsessionId "sessionId",
				ra.blSampleId "sampleId",
				ra.actionType "actionType",
				ra.startTimeStamp "startTimeStamp",
				ra.endTimeStamp "endTimeStamp",
				ra.status "status",
				ra.message "message",
				ra.containerLocation "location",
				ra.dewarLocation "dewarLocation",
				ra.sampleBarcode "sampleBarcode",
				xtalSnapshotBefore "xtalSnapshotBefore",
				xtalSnapshotAfter "xtalSnapshotAfter"
				FROM BLSample bls
				  INNER JOIN RobotAction ra ON bls.blSampleId = ra.blSampleId
				  INNER JOIN BLSession bs ON ra.blsessionId = bs.sessionId
				  INNER JOIN Proposal p ON bs.proposalId = p.proposalId
				  INNER JOIN BLSession bs2 on p.proposalID = bs2.proposalID
				  INNER JOIN Session_has_Person shp ON bs2.sessionId = shp.sessionId
				  INNER JOIN Person pe ON pe.personID = shp.personId
				WHERE pe.login = p_authLogin;

			ELSE
			-- no p_authLogin
				SELECT
				ra.robotActionId "robotActionId",
				NULL "sessionId",
				ra.blSampleId "sampleId",
				ra.actionType "actionType",
				ra.startTimeStamp "startTimeStamp",
				ra.endTimeStamp "endTimeStamp",
				ra.status "status",
				ra.message "message",
				ra.containerLocation "location",
				ra.dewarLocation "dewarLocation",
				ra.sampleBarcode "sampleBarcode",
				xtalSnapshotBefore "xtalSnapshotBefore",
				xtalSnapshotAfter "xtalSnapshotAfter"
				FROM BLSample bls
				  INNER JOIN RobotAction ra ON bls.blSampleID = ra.blSampleId
				  INNER JOIN BLSession bs ON ra.blsessionId = bs.sessionId
				  INNER JOIN Proposal p ON bs.proposalId = p.proposalId
				WHERE bls.blSampleId = p_id;
			END IF;

		ELSE
		-- not using robot action session

			IF p_authLogin IS NOT NULL THEN
			 -- Authorise if the persion (p_authLogin) is a member of a session on the proposal.
				
				SELECT DISTINCT
				ra.robotActionId "robotActionId",
				ra.blsessionId "sessionId",
				ra.blSampleId "sampleId",
				ra.actionType "actionType",
				ra.startTimeStamp "startTimeStamp",
				ra.endTimeStamp "endTimeStamp",
				ra.status "status",
				ra.message "message",
				ra.containerLocation "location",
				ra.dewarLocation "dewarLocation",
				ra.sampleBarcode "sampleBarcode",
				xtalSnapshotBefore "xtalSnapshotBefore",
				xtalSnapshotAfter "xtalSnapshotAfter"
				FROM BLSample bls
				  INNER JOIN RobotAction ra ON bls.blSampleId = ra.blSampleId
				  INNER JOIN BLSession bs ON ra.blsessionId = bs.sessionId
				  INNER JOIN Proposal p ON bs.proposalId = p.proposalId
				  INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
				  INNER JOIN Person pe ON pe.personID = shp.personId
				WHERE pe.login = p_authLogin AND bls.blSampleId = p_id;
			
			ELSE
			-- no p_authLogin
				
				SELECT 
				ra.robotActionId "robotActionId",
				NULL "sessionId",
				ra.blSampleId "sampleId",
				ra.actionType "actionType",
				ra.startTimeStamp "startTimeStamp",
				ra.endTimeStamp "endTimeStamp",
				ra.status "status",
				ra.message "message",
				ra.containerLocation "location",
				ra.dewarLocation "dewarLocation",
				ra.sampleBarcode "sampleBarcode",
				xtalSnapshotBefore "xtalSnapshotBefore",
				xtalSnapshotAfter "xtalSnapshotAfter"
				FROM BLSample bls
				  INNER JOIN RobotAction ra ON bls.blSampleId = ra.blSampleId
				  INNER JOIN BLSession bs ON ra.blsessionId = bs.sessionId
				  INNER JOIN Proposal p ON bs.proposalId = p.proposalId
				WHERE bls.blSampleId = p_id;
			END IF;

		END IF;
	
	ELSE
	-- no p_id
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

