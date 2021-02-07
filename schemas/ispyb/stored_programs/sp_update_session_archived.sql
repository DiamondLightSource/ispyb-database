DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_session_archived`(
    IN p_proposalCode varchar(3), 
    IN p_proposalNumber int, 
    IN p_sessionNumber int,
    IN p_archived boolean)
MODIFIES SQL DATA
COMMENT 'Updates the session `archived` column for session specified by p_proposalCode, p_proposalNumber, p_sessionNumber'
BEGIN
	IF NOT (p_proposalCode IS NULL) AND NOT (p_proposalNumber IS NULL) AND NOT (p_sessionNumber IS NULL) THEN
	    UPDATE BLSession bs
            INNER JOIN Proposal p USING(proposalId)
        SET bs.archived = p_archived
        WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number =  p_sessionNumber;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MYSQL_ERRNO=1644, 
            MESSAGE_TEXT='Mandatory arguments p_proposalCode, p_proposalNumber int, p_sessionNumber must be non-NULL';
    END IF;
END;;
DELIMITER ;
