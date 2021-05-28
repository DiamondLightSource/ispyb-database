DELIMITER ;;
CREATE FUNCTION `retrieve_proposal_title_v2`(p_proposalCode varchar(5), p_proposalNumber int) RETURNS varchar(255) CHARSET latin1
READS SQL DATA
COMMENT 'Retrieve the title for a given proposal code and number.'
BEGIN
	DECLARE ret_title varchar(255);
	SELECT title INTO ret_title
	FROM Proposal
		WHERE proposalCode = p_proposalCode
		AND proposalNumber = p_proposalNumber
	LIMIT 1;
	RETURN ret_title;
END ;;
DELIMITER ;
