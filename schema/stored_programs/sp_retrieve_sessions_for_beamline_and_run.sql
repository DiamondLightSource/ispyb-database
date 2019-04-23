DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sessions_for_beamline_and_run`(
  IN p_beamline varchar(15),
  IN p_run varchar(7)
)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the sessions (mx12345-123), their start and end dates for beamline p_beamline and run p_run'
BEGIN
  SELECT
      bs.sessionId "sessionId",
      concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) "session",
      bs.startDate "startDate",
      bs.endDate "endDate"
  FROM Proposal p
      INNER JOIN BLSession bs on p.proposalId = bs.proposalId
      INNER JOIN v_run vr ON bs.startDate BETWEEN vr.startDate AND vr.endDate
	WHERE bs.beamlinename = p_beamline AND vr.run = p_run
  ORDER BY bs.startDate, bs.sessionId;
END;;

DELIMITER ;
