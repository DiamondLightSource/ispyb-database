/* 
Example call:
call retrieve_session_id_v2('sw12500-1');
-- tested OK
*/
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_session_id_v2` (p_session varchar(15), p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns the session ID (an integer) for p_session (e.g. mx12345-123)'
BEGIN

    IF p_authLogin IS NOT NULL THEN
    -- Authorise only if the person (p_authLogin) is a member of the session.

      SELECT max(bs.sessionid) 
      FROM Proposal p 
        INNER JOIN BLSession bs ON p.proposalid = bs.proposalid 
        INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
        INNER JOIN Person per ON per.personId = shp.personId
      WHERE per.login = p_authLogin AND concat(p.proposalcode, p.proposalnumber, '-', bs.visit_number) = p_session;

    ELSE 

      SELECT max(bs.sessionid) 
      FROM Proposal p 
        INNER JOIN BLSession bs ON p.proposalid = bs.proposalid 
      WHERE concat(p.proposalcode, p.proposalnumber, '-', bs.visit_number) = p_session;

    END IF;

END;;

DELIMITER ;
