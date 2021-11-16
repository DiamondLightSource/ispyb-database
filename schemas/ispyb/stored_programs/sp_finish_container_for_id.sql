DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `finish_container_for_id`(IN p_id int(10) unsigned)
    MODIFIES SQL DATA
    COMMENT 'Set the completedTimeStamp in the ContainerQueue table for the container with this containerId'
BEGIN
  IF NOT (p_id IS NULL) THEN
    UPDATE ContainerQueue cq
      JOIN (
        SELECT max(containerQueueId) as containerQueueId
        FROM ContainerQueue 
        WHERE completedTimeStamp IS NULL and containerId = p_id
      ) cqmax
          ON cq.containerQueueId = cqmax.containerQueueId
    SET cq.completedTimeStamp = current_timestamp
    WHERE cq.completedTimeStamp IS NULL;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id is NULL';
  END IF;
END ;;
DELIMITER ;
