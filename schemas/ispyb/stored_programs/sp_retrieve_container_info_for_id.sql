DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container_info_for_id`(IN p_containerId int unsigned) 
READS SQL DATA
COMMENT 'Return single-row result set with info about a Container identified by p_containerId'
BEGIN
    IF NOT (p_containerId IS NULL) THEN
	    SELECT c.dewarId "dewarId", c.code "name", c.barcode "barcode", c.containerStatus "status", c.containerType "type", c.capacity "capacity",
	      c.sampleChangerLocation "location", c.beamlineLocation "beamline", c.comments "comments", c.experimentType "experimentType",
          p.proposalCode "proposalCode", p.proposalNumber "proposalNumber", bs.visit_number "sessionNumber",
          i.name "imagerName", i.serial "imagerSerialNumber", i.temperature "storageTemperature"
      FROM Container c
          LEFT OUTER JOIN Imager i on c.imagerId = i.imagerId
          LEFT OUTER JOIN BLSession bs on bs.sessionId = c.sessionId 
          LEFT OUTER JOIN Proposal p on p.proposalId = bs.proposalId
        WHERE c.containerId = p_containerId;
     ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_containerId';
    END IF;
END ;;
DELIMITER ;

