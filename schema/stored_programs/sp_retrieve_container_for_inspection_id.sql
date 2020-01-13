-- This should probably be re-written to get the proposal code and number via
-- the container sessionId. Currently, if getting it through dewar -> shipping
-- -> proposal there could be ambiguity ....
-- Also, concat(something, NULL) returns NULL, so there are no situations where
-- we will get the proposal code and number but not the visit number. So we
-- might as well get the proposal code and number via the c.sessionId.

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container_for_inspection_id`(IN p_containerInspectionId int(11) unsigned)
READS SQL DATA
COMMENT 'Return single-row result set with info about a Container identified by p_containerInspectionId'
BEGIN
    IF NOT (p_containerInspectionId IS NULL) THEN
        SELECT c.containerType, c.containerId, c.sessionId, concat(p.proposalCode, p.proposalNumber, '-', bs.visit_number) "visit",
        date_format(c.blTimeStamp, '%Y') as year
        FROM Container c
          INNER JOIN ContainerInspection ci ON ci.containerId = c.containerId
          INNER JOIN Dewar d ON d.dewarId = c.dewarId
          INNER JOIN Shipping s ON s.shippingId = d.shippingId
          INNER JOIN Proposal p ON p.proposalId = s.proposalId
          LEFT OUTER JOIN BLSession bs ON bs.sessionId = c.sessionId
        WHERE ci.containerinspectionId = p_containerInspectionId
        LIMIT 1;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_containerInspectionId';
    END IF;
END;;
DELIMITER ;
