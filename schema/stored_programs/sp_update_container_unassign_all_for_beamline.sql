DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_unassign_all_for_beamline`(IN p_beamline varchar(20))
MODIFIES SQL DATA
COMMENT 'Unassigns all containers on a given beamline one by one by calling update_container_assign on each.'
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE row_registry_barcode VARCHAR(20);
    DECLARE row_position VARCHAR(20);
    DECLARE cur CURSOR FOR SELECT cr.barcode, c.sampleChangerLocation  
        FROM Container c
            INNER JOIN ContainerRegistry cr ON cr.containerRegistryId = c.containerRegistryId
            INNER JOIN BLSession bs ON bs.sessionId = c.sessionId
        WHERE bs.beamlineName = p_beamline AND c.containerStatus = 'processing';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    IF NOT (p_beamline IS NULL) THEN
        OPEN cur;
        call_loop: LOOP
            FETCH cur INTO row_registry_barcode, row_position;
            IF done THEN
                LEAVE call_loop;
            END IF;
            CALL update_container_assign(p_beamline, row_registry_barcode, row_position);
        END LOOP;
        CLOSE cur;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_beamline is NULL';
    END IF;

END;;
DELIMITER ;