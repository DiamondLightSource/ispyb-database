-- Test call:
-- CALL update_reg_container_barcode('DLS123', 'DLS456');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_reg_container_barcode`(IN p_oldBarcode varchar(20), IN p_newBarcode varchar(20))
MODIFIES SQL DATA
COMMENT 'For Registered Container with barcode==p_oldBarcode: Sets barcode=p_newBarcode'
BEGIN
    DECLARE row_containerRegistryId int(11) unsigned DEFAULT NULL;

    IF NOT (p_oldBarcode IS NULL) AND NOT (p_newBarcode IS NULL) THEN
        START TRANSACTION;
          SELECT containerRegistryId INTO row_containerRegistryId FROM ContainerRegistry WHERE barcode = p_oldBarcode FOR UPDATE;
          IF NOT (row_containerRegistryId IS NULL) THEN
              UPDATE ContainerRegistry SET barcode = p_newBarcode WHERE containerRegistryId = row_containerRegistryId;
          ELSE
              SIGNAL SQLSTATE '02000' SET MYSQL_ERRNO=1643, MESSAGE_TEXT='Barcode given by p_oldBarcode not found';
          END IF;
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_oldBarcode and/or p_newBarcode are NULL';
    END IF;
END ;;
DELIMITER ;
