-- Test:
-- SET @id = NULL;
-- CALL upsert_container_report(@id, 'VMXiSim-001', 'boaty', 'This is a really good container');
-- 

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_container_report`(
  INOUT p_id int(11) unsigned,
  p_containerRegistryBarcode varchar(20),
  p_login varchar(45),
  p_report text
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates a ContainerReport (p_barcode).
   Returns: Record ID in p_id.'
BEGIN
  DECLARE row_containerRegistryId int(11) unsigned DEFAULT NULL;
  DECLARE row_personId int(10) unsigned DEFAULT NULL;

  IF p_containerRegistryBarcode IS NOT NULL THEN
    SELECT max(containerRegistryId) INTO row_containerRegistryId FROM ContainerRegistry WHERE barcode = p_containerRegistryBarcode;
  END IF;

  IF p_id IS NULL AND row_containerRegistryId IS NOT NULL THEN
    SELECT personId INTO row_personId FROM Person WHERE login = p_login;
    INSERT INTO ContainerReport (containerRegistryId, personId, report, recordTimestamp) 
      VALUES (row_containerRegistryId, row_personId, p_report, now());
    SET p_id = LAST_INSERT_ID();

  ELSEIF p_id IS NOT NULL THEN

    UPDATE ContainerReport
    SET 
      containerRegistryId = IFNULL(row_containerRegistryId, containerRegistryId),
      personId = IFNULL(row_personId, personId),
      report = IFNULL(p_report, report)
    WHERE containerReportId = p_id;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='p_id must be non-NULL or p_containerRegistryBarcode must match barcode in ContainerRegistry.';
  END IF;
  
END;;
DELIMITER ;
