DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_session_for_proposal_code_number`(
	 INOUT p_id int(11) unsigned,
	 p_proposalCode varchar(3),
	 p_proposalNumber int(11),
	 p_visitNumber int(10) unsigned,
	 p_beamLineSetupId int(10) unsigned,
	 p_startDate datetime,
	 p_endDate datetime,
	 p_beamlineName varchar(45),
	 p_title varchar(255),
	 p_beamlineOperator varchar(45),
	 p_nbShifts int(10) unsigned,
	 p_scheduled tinyint(1),
	 p_usedFlag tinyint(1),
	 p_comments varchar(255),
	 p_externalPkId int(11) unsigned,
	 p_externalPkUUID varchar(32)
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates a session for a proposal with given code and number.\nMandatory columns:\p_proposalCode and p_proposalNumber\nReturns: Record ID in p_id.'
BEGIN
	DECLARE row_proposal_id int(10) unsigned DEFAULT NULL;
	IF p_id IS NOT NULL OR (p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL) THEN
		SELECT min(proposalId) INTO row_proposal_id FROM Proposal WHERE proposalCode=p_proposalCode AND proposalNumber=p_proposalNumber;

	  IF p_id IS NULL THEN
		  INSERT INTO BLSession(sessionId, proposalId, visit_number, beamLineSetupId, startDate, endDate,
			  beamLineName, sessionTitle, beamLineOperator, nbShifts, scheduled, usedFlag, comments, expSessionPk, externalId)
			  VALUES (p_id, row_proposal_id, p_visitNumber, p_beamLineSetupId, p_startDate, p_endDate,
				  p_beamlineName, p_title, p_beamlineOperator, p_nbShifts, p_scheduled, p_usedFlag, p_comments, p_externalPkId, unhex(p_externalPkUUID));
		  SET p_id = LAST_INSERT_ID();

	  ELSEIF p_id IS NOT NULL THEN
	    UPDATE BLSession
			SET
				proposalId = IFNULL(row_proposal_id, proposalId),
				visit_number = IFNULL(p_visitNumber, visit_number),
				beamLineSetupId = IFNULL(p_beamLineSetupId, beamLineSetupId),
				startDate = IFNULL(p_startDate, startDate),
				endDate = IFNULL(p_endDate, endDate),
				beamLineName = IFNULL(p_beamlineName, beamLineName),
				sessionTitle = IFNULL(p_title, sessionTitle),
				beamLineOperator = IFNULL(p_beamlineOperator, beamLineOperator),
				nbShifts = IFNULL(p_nbShifts, nbShifts),
				scheduled = IFNULL(p_scheduled, scheduled),
				usedFlag = IFNULL(p_usedFlag, usedFlag),
				comments = IFNULL(p_comments, comments),
				expSessionPk = IFNULL(p_externalPkId, expSessionPk),
				externalId = IFNULL(unhex(p_externalPkUUID), externalId)
		  WHERE sessionId = p_id;
    END IF;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR (p_proposalCode AND p_proposalNumber) must be non-NULL.';
	END IF;
END;;
DELIMITER ;
