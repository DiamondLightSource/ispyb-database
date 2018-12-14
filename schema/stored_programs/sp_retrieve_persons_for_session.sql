DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_persons_for_session`(p_proposal_code varchar(5), p_proposal_number int, p_visit_number int)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with info about the persons for
session identified by p_proposal_code, p_proposal_number, p_visit_number'
BEGIN
    IF p_proposal_code IS NOT NULL AND p_proposal_number IS NOT NULL AND p_visit_number IS NOT NULL THEN
      SELECT per.title, per.givenName, per.familyName, per.login, shp.role, shp.remote
      FROM Person per
        INNER JOIN Session_has_Person shp on shp.personId = per.personId
        INNER JOIN BLSession bs on bs.sessionId = shp.sessionId
        INNER JOIN Proposal p on p.proposalId = bs.proposalId
	  WHERE p.proposalCode = p_proposal_code AND p.proposalNumber = p_proposal_number AND bs.visit_number = p_visit_number;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_proposalCode + p_proposalNumber + p_visit_number can not be NULL';
	END IF;
END;;
DELIMITER ;
