DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_current_sessions_for_person`(IN p_beamline varchar(15), IN p_fed_id varchar(24), IN p_tolerance_minutes int)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the current (within tolerance p_tolerance_minutes)
session(s) (mx12345-123), their start and end dates for person p_fed_id and beamline p_beamline'
BEGIN
	  SET p_tolerance_minutes = IFNULL(p_tolerance_minutes, 0);
    SELECT concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) `session`, bs.startDate, bs.endDate
    FROM Proposal p
      INNER JOIN BLSession bs on p.proposalId = bs.proposalId
      INNER JOIN Session_has_Person shp ON shp.sessionId = bs.sessionId
	    INNER JOIN Person per ON shp.personId = per.personId
	  WHERE bs.beamlinename = p_beamline AND bs.visit_number <> 0 AND per.login = p_fed_id AND now() BETWEEN bs.startDate - INTERVAL p_tolerance_minutes MINUTE and bs.endDate + INTERVAL p_tolerance_minutes MINUTE
    ORDER BY bs.startDate;
END;;

DELIMITER ;
