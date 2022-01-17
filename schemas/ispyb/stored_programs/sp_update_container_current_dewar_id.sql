-- Test call:
-- CALL update_container_current_dewar_id(34888, 8572);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_current_dewar_id`(IN p_id int unsigned, IN p_dewarId int unsigned)
MODIFIES SQL DATA
COMMENT 'For Container with containerId==p_id: Sets currentDewarId=p_dewarId and inserts row into ContainerHistory with that currentDewarId.'
BEGIN
    IF NOT (p_id IS NULL) THEN

        UPDATE Container SET currentDewarId = p_dewarId WHERE containerId = p_id;

        INSERT INTO ContainerHistory (containerId, location, status, beamlineName, currentDewarId)
          SELECT p_id, sampleChangerLocation, containerStatus, beamlineLocation, p_dewarId FROM Container WHERE containerId = p_id;

    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id is NULL';
    END IF;
END ;;
DELIMITER ;
