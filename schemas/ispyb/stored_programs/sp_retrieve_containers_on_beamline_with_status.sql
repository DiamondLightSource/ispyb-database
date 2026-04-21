DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_containers_on_beamline_with_status`(IN p_beamline varchar(20), IN p_status varchar(45))
    READS SQL DATA
    COMMENT 'Returns a multi-row result-set with info about when containers on beamline p_beamline last had status p_status'
BEGIN
  IF NOT (p_status IS NULL) AND NOT (p_beamline IS NULL) THEN
    SELECT c.barcode "barcode", c.sampleChangerLocation "location", max(ch.blTimeStamp) "added"
    FROM Container c
      LEFT OUTER JOIN ContainerHistory ch ON c.containerId = ch.containerId AND ch.status = p_status
    WHERE c.containerStatus = p_status AND ch.beamlineName = p_beamline
    GROUP BY c.barcode, c.sampleChangerLocation
    ORDER BY ch.blTimeStamp ASC;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_status and/or p_beamline are NULL';
  END IF;
END ;;
DELIMITER ;
