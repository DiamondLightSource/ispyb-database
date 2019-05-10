-- Test call:
-- call update_container_assign('i04', 'DLS-0001', 11);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_container_assign`(IN p_beamline varchar(20), IN p_registry_barcode varchar(45), IN p_position int)
MODIFIES SQL DATA
COMMENT 'Toggles "assign" status of container (p_barcode).
Sets the s.c. position and beamline.
If assigned then: 1) Also assign its dewar and shipping. 2) Unassigns other containers in the same proposal on that beamline and s.c. position.
If unassign then:
'
BEGIN
    DECLARE row_containerId int(10) unsigned DEFAULT NULL;
    DECLARE row_containerStatus varchar(45) DEFAULT NULL;
    DECLARE currentContainerStatus varchar(45) DEFAULT NULL;
    DECLARE row_dewarId int(10) unsigned DEFAULT NULL;
    DECLARE row_beamlineLocation varchar(20) DEFAULT NULL;
    DECLARE row_sampleChangerLocation varchar(20) DEFAULT NULL;
    DECLARE row_proposalId int(10) unsigned DEFAULT NULL;
    DECLARE row_queuedCount int(11) unsigned DEFAULT NULL;

    IF NOT (p_registry_barcode IS NULL) THEN
        START TRANSACTION;

        SELECT c.containerId, c.containerStatus, c.dewarId, c.beamlineLocation, c.sampleChangerLocation, s.proposalId, count(*)
          INTO row_containerId, row_containerStatus, row_dewarId, row_beamlineLocation, row_sampleChangerLocation, row_proposalId, row_queuedCount
        FROM Container c
            INNER JOIN ContainerRegistry cr ON c.containerRegistryId = cr.containerRegistryId
            INNER JOIN Dewar d ON d.dewarId = c.dewarId
            INNER JOIN Shipping s ON s.shippingId = d.shippingId
            LEFT OUTER JOIN ContainerQueue cq ON cq.containerId = c.containerId
        WHERE cr.barcode = p_registry_barcode
        GROUP BY c.containerId, c.containerStatus, c.dewarId, c.beamlineLocation, c.sampleChangerLocation, s.proposalId
        ORDER BY c.containerId DESC
        LIMIT 1;

        SELECT row_containerStatus INTO currentContainerStatus;

        -- We need a containerId, and also we don't want to unassign unless the correct current beamline and s.c. position is given
        IF NOT row_containerId IS NULL THEN
          IF (NOT row_containerStatus <=> 'processing') OR (row_beamlineLocation = p_beamline AND row_sampleChangerLocation = p_position) THEN

            -- Assign the container
            UPDATE Container c
              INNER JOIN Dewar d ON d.dewarId = c.dewarId
              INNER JOIN Shipping s ON s.shippingId = d.shippingId
            SET
              c.sampleChangerLocation = IF(row_containerStatus<=>'processing', '', p_position),
              c.beamlineLocation = p_beamline,
              c.containerStatus = IF(row_containerStatus<=>'processing', 'at facility', 'processing'),
              d.dewarStatus = IF(row_containerStatus<=>'processing', d.dewarStatus, 'processing'),
              d.storageLocation = IF(row_containerStatus<=>'processing', d.storageLocation, p_beamline),
              s.shippingStatus = IF(row_containerStatus<=>'processing', s.shippingStatus, 'processing')
            WHERE
              c.containerId = row_containerId;

            SELECT IF(row_containerStatus<=>'processing', 'at facility', 'processing') INTO currentContainerStatus;

            IF NOT row_containerStatus <=> 'processing' THEN
              -- The container has been assigned a s.c. position on the beamline, so we need to unassign
              -- any other containers in this s.c. position on this beamline for this proposal
              UPDATE Container c
                INNER JOIN Dewar d ON d.dewarId = c.dewarId
                INNER JOIN Shipping s ON s.shippingId = d.shippingId
              SET c.containerStatus = 'at facility',
                c.sampleChangerLocation = ''
              WHERE s.proposalId = row_proposalId AND c.beamlineLocation = p_beamline AND
                c.sampleChangerLocation = p_position AND c.containerId <> row_containerId;

              -- Assign the dewar as well
              INSERT INTO DewarTransportHistory (dewarId, dewarStatus, storageLocation, arrivalDate)
                VALUES (row_dewarId, 'processing', p_beamline, NOW());
            END IF;

            -- Add to history
            INSERT INTO ContainerHistory (containerId, location, status, beamlineName)
              VALUES (row_containerId, p_position, IF(row_containerStatus<=>'processing', 'at facility', 'processing'), p_beamline);
          END IF;
        ELSE
          SIGNAL SQLSTATE '02000' SET MYSQL_ERRNO=1643, MESSAGE_TEXT='Container with p_registry_barcode not found';
        END IF;

        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_registry_barcode is NULL';
    END IF;
    SELECT row_containerId as "containerId",
      currentContainerStatus as "containerStatus",
      row_queuedCount as "queuedCount";
END ;;
DELIMITER ;
