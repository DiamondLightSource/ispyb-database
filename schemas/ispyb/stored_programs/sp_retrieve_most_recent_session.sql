DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_most_recent_session`(IN p_beamline varchar(15), IN p_proposal_code varchar(5))
READS SQL DATA
COMMENT 'Returns a single-row result-set with the session (mx12345-123), its start and end dates
for beamline p_beamline and proposal code p_proposal_code (e.g. cm, mx, nt, in, ee)'
BEGIN
    SELECT concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) `session`, bs.startDate, bs.endDate
    FROM Proposal p
      INNER JOIN BLSession bs on p.proposalId = bs.proposalId
	WHERE p.proposalCode = p_proposal_code AND bs.beamlinename = p_beamline AND bs.visit_number <> 0 AND now() > bs.startDate
    ORDER BY bs.startDate DESC
    LIMIT 1;
END;;

DELIMITER ;
