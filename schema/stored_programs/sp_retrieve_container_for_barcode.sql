-- Test:
-- CALL retrieve_container_for_barcode('VMXiSim-001');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container_for_barcode`(IN p_barcode varchar(45))
READS SQL DATA
COMMENT 'Return single-row result set with info about a Container identified by p_barcode'
BEGIN
    IF NOT (p_barcode IS NULL) THEN
      SELECT c.containerId, c.sessionId, c.dewarId "dewarId",
        c.code "name", c.barcode "barcode", c.containerStatus "status",
        c.containerType "type", c.capacity "capacity",
	      c.sampleChangerLocation "location", c.beamlineLocation "beamline",
        c.comments "comments", c.experimentType "experimentType",
        concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) "visit",
        date_format(c.blTimeStamp, '%Y') "year"
      FROM Container c
        LEFT OUTER JOIN BLSession bs ON bs.sessionId = c.sessionId
        LEFT OUTER JOIN Proposal p ON p.proposalId = bs.proposalId
      WHERE c.barcode=p_barcode
        LIMIT 1;
     ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_barcode';
    END IF;
END;;
DELIMITER ;
