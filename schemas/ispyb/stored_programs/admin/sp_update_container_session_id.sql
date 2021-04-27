-- Example call:
-- CALL update_container_session_id(...);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_session_id` (
    IN p_containerId int unsigned,
    IN p_proposalCode varchar(10),
    IN p_proposalNumber int,
    IN p_sessionNumber int,
    IN p_authLogin varchar(45)
)
MODIFIES SQL DATA
COMMENT 'Updates sessionId in the Container (given by p_containerId). If p_authLogin is given, it must be authorised.'
BEGIN

  DECLARE v_sessionId int unsigned DEFAULT NULL;
  DECLARE v_rows int unsigned DEFAULT 0;
  DECLARE v_containerId int unsigned DEFAULT NULL;
  DECLARE v_oldSessionId int unsigned DEFAULT NULL;

  IF p_authLogin IS NOT NULL THEN 

    -- p_authLogin is authorised if they're a member of the autocollect UG
    SELECT count(*)
      INTO v_rows
    FROM UserGroup_has_Person ughp
      JOIN Person p ON p.personId = ughp.personId
      JOIN UserGroup ug ON ug.userGroupId = ughp.userGroupId
      WHERE p.login = p_authLogin AND ug.name ='autocollect';

  END IF;

  IF p_authLogin IS NOT NULL AND v_rows = 0 THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Not authorised';
  END IF;
  
  IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL AND 
    p_sessionNumber IS NOT NULL THEN

    SELECT bs.sessionId INTO v_sessionId
    FROM BLSession bs 
      JOIN Proposal p ON p.proposalId = bs.proposalId
    WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber;

  END IF;

  IF p_containerId IS NOT NULL THEN

    -- Only set the Container.sessionId if p_proposalCode, p_proposalNumber, p_sessionNumber are all NULL
    -- OR the found corresponding sessionId is not NULL:
    IF (p_proposalCode IS NULL AND p_proposalNumber IS NULL AND 
      p_sessionNumber IS NULL) OR NOT (v_sessionId IS NULL) THEN

        SELECT containerId, c.sessionId INTO v_containerId, v_oldSessionId 
        FROM Container c
        WHERE containerId = p_containerId;

        IF NOT (v_containerId IS NULL) THEN
          UPDATE Container
          SET sessionId = v_sessionId
          WHERE containerId = p_containerId;

          SELECT v_oldSessionId;
        ELSE
          SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Container p_containerId not found';
        END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Invalid or not found session';
    END IF;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='p_containerId is NULL.';

  END IF;
END ;;
DELIMITER ;
