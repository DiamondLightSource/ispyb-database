DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_unqueue`(IN p_barcode varchar(45))
    MODIFIES SQL DATA
    COMMENT 'Find the containerQueueId for the non-completed rows in ContainerQueue associated with barcode p_barcode.
    Remove the association to that ContainerQueue row for the  from sub sample queue and remove the ContainerQueue row for the container with this barcode'
BEGIN
  DECLARE row_containerStatus varchar(45) DEFAULT NULL;
  DECLARE row_containerType varchar(20) DEFAULT NULL;
  DECLARE row_containerId int(10) unsigned DEFAULT NULL;
  DECLARE row_containerQueueId int(11) unsigned DEFAULT NULL;

  IF NOT (p_barcode IS NULL) THEN

    SELECT c.containerId, c.containerStatus, IFNULL(ct.name, c.containerType)
      INTO row_containerId, row_containerStatus, row_containerType
    FROM Container c
      LEFT OUTER JOIN ContainerType ct ON c.containerTypeId = ct.containerTypeId
    WHERE c.barcode = p_barcode;

    SELECT max(containerQueueId) INTO row_containerQueueId
    FROM ContainerQueue 
    WHERE containerId = row_containerId AND completedTimestamp IS NULL;

    IF NOT (row_containerQueueId IS NULL) AND (
      row_containerType = 'Puck' OR
      row_containerStatus IN ('in_storage', 'disposed') OR
      row_containerStatus IS NULL) THEN

      UPDATE ContainerQueueSample 
      SET containerQueueId = NULL 
      WHERE containerQueueId = row_containerQueueId;

      DELETE 
      FROM ContainerQueue 
      WHERE containerQueueId = row_containerQueueId;
    END IF;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
  END IF;
END ;;
DELIMITER ;
