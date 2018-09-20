DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sessions_for_person_login`(p_login varchar(45))
READS SQL DATA
COMMENT 'Returns a multi-row result-set with info about the sessions associated with a person with login=p_login'
BEGIN
    IF p_login IS NOT NULL THEN
      SELECT bs.sessionId "id", bs.proposalId "proposalId", bs.startDate "startDate", bs.endDate "endDate",
        bs.beamlineName "beamline", bs.visit_number "sessionNumber", bs.comments "comments", shp.role "personRoleOnSession", shp.remote "personRemoteOnSession"
      FROM BLSession bs
        INNER JOIN Session_has_Person shp on shp.sessionId = bs.sessionId
        INNER JOIN Person p on p.personId = shp.personId
	    WHERE p.login = p_login
      ORDER BY bs.startDate;
    ELSE
	    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_login can not be NULL';
	  END IF;
END;;
DELIMITER ;
