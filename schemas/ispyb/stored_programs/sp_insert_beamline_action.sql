DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_beamline_action`(
     OUT p_id int(11) unsigned,
     p_proposalCode varchar(3),
     p_proposalNumber int(10),
     p_sessionNumber int(10),
     p_startTime timestamp,
     p_endTime timestamp,
     p_message varchar(255),
     p_parameter varchar(50),
     p_value varchar(50),
     p_logLevel enum('DEBUG','CRITICAL','INFO'),
     p_status enum('PAUSED','RUNNING','TERMINATED','COMPLETE','ERROR','EPICSFAIL')
)
    MODIFIES SQL DATA
    COMMENT 'Insert a beamline action row for session p_proposalCode + p_proposalNumber + p_sessionNumber. Returns ID of row in p_id'
BEGIN
	DECLARE row_session_id int(10) unsigned DEFAULT NULL;
	DECLARE row_proposal_id int(10) unsigned DEFAULT NULL;
  
	IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL AND p_sessionNumber IS NOT NULL THEN
      SELECT max(bs.sessionid), p.proposalId INTO row_session_id, row_proposal_id 
      FROM Proposal p INNER JOIN BLSession bs ON p.proposalid = bs.proposalid 
      WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber;

      INSERT INTO BeamlineAction (sessionId, startTimestamp, endTimestamp, message, parameter, `value`, loglevel, `status`) 
          VALUES (row_session_id, p_startTime, p_endTime, p_message, p_parameter, p_value, p_logLevel, p_status);

	  IF p_id IS NULL THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='One or more mandatory arguments are NULL: p_proposalCode, p_proposalNumber, p_sessionNumber';
    END IF;
  END;;
DELIMITER ;