DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_session_has_person_for_session_and_login`(
  p_proposalCode varchar(45),
  p_proposalNumber int(11) unsigned,
  p_visit_number int(10) unsigned,
  p_login varchar(45),
  p_role varchar(100),
  p_remote tinyint(1)
  )
  MODIFIES SQL DATA
  COMMENT 'Inserts or updates info about a session - person association (p_sessionId, p_personId).
Mandatory columns: p_proposalCode, p_proposalNumber, p_visit_number, p_login
Returns: Nothing.'
BEGIN
  DECLARE v_personId int unsigned DEFAULT 0;
  
  IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL AND p_visit_number IS NOT NULL AND p_login IS NOT NULL THEN
    SELECT per.personId INTO v_personId FROM Person per WHERE per.login = p_login;
    INSERT INTO Session_has_Person(sessionId, personId, `role`, remote)
      SELECT bs.sessionId, v_personId, p_role, p_remote
      FROM Proposal p INNER JOIN BLSession bs ON p.proposalId = bs.proposalId
        WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_visit_number
      ON DUPLICATE KEY UPDATE
        `role` = IFNULL(p_role, `role`),
        remote = IFNULL(p_remote, remote);
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_proposalCode, p_proposalNumber, p_visit_number AND p_login must be non-NULL.';
  END IF;
END;;
DELIMITER ;
