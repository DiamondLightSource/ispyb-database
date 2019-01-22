DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_current_sessions`(IN p_beamline varchar(15), IN p_tolerance_minutes int)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the current (within tolerance p_tolerance_minutes)
session(s) (mx12345-123), their start and end dates for beamline p_beamline'
BEGIN
	set p_tolerance_minutes = IFNULL(p_tolerance_minutes, 0);
    SELECT concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) `session`, bs.startDate, bs.endDate
    FROM Proposal p
      INNER JOIN BLSession bs on p.proposalId = bs.proposalId
	WHERE bs.beamlinename = p_beamline AND bs.visit_number <> 0 AND now() BETWEEN bs.startDate - INTERVAL p_tolerance_minutes MINUTE and bs.endDate + INTERVAL p_tolerance_minutes MINUTE
    ORDER BY bs.startDate;
END;;

DELIMITER ;
