DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_expired_sessions_for_instrument_and_period`(IN p_instrument varchar(15), IN p_startDate datetime, IN p_endDate datetime)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the sessions that ended within the window defined by p_startDate and p_endDate on instrument given by p_instrument (can contain wildcards)'
BEGIN
  SELECT bs.beamlinename "instrument", concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) "session", bs.startDate, bs.endDate
    FROM Proposal p
      INNER JOIN BLSession bs on p.proposalId = bs.proposalId
	WHERE bs.beamlinename LIKE p_instrument AND bs.visit_number <> 0 AND bs.endDate BETWEEN p_startDate AND p_endDate
    ORDER BY bs.startDate;
END;;

DELIMITER ;
