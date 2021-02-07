DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_persons_for_proposal`(p_proposal_code varchar(5), p_proposal_number int) 
READS SQL DATA
COMMENT 'Returns a multi-row result-set with info about the persons for 
proposal p_proposal_code + p_proposal_number'
BEGIN
    IF p_proposal_code IS NOT NULL AND p_proposal_number IS NOT NULL THEN
      SELECT per.title, per.givenName, per.familyName, per.login, php.role
      FROM Person per 
        INNER JOIN ProposalHasPerson php on php.personId = per.personId
        INNER JOIN Proposal p on p.proposalId = php.proposalId
	  WHERE p.proposalCode = p_proposal_code AND p.proposalNumber = p_proposal_number;
    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_proposalCode + p_proposalNumber can not be NULL';
	END IF;
END;;
DELIMITER ;
