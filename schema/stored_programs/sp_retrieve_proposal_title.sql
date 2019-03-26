DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_proposal_title`(p_proposal_code varchar(5), p_proposal_number int, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row, single-column result set with the title of the proposal p_proposal_code + p_proposal_number'
BEGIN

    IF p_authLogin IS NOT NULL THEN
    -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

      SELECT pr.title
      FROM Proposal pr
        INNER JOIN BLSession bs ON pr.proposalid = bs.proposalid 
        INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
        INNER JOIN Person p ON p.personId = shp.personId
	    WHERE p.login = p_authLogin AND pr.proposalCode = p_proposal_code AND pr.proposalNumber = p_proposal_number
      LIMIT 1;

    ELSE 

      SELECT title
      FROM Proposal 
	    WHERE proposalCode = p_proposal_code AND proposalNumber = p_proposal_number
      LIMIT 1;

    END IF;

END;;

DELIMITER ;
