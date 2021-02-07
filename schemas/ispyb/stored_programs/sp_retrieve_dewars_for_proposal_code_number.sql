DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE retrieve_dewars_for_proposal_code_number(p_proposalCode varchar(3), p_proposalNumber int unsigned)
    READS SQL DATA
    COMMENT 'Return multi-row result-set with dewar ID + other dewar info associated with shipments in a given proposal specified by proposal code, proposal_number'
BEGIN
    IF NOT (p_proposalNumber IS NULL) THEN
      SELECT
          d.dewarId "id", d.shippingId "shippingId", d.code "name", d.comments "comments", d.storageLocation "storageLocation",
          d.dewarStatus "status", d.isStorageDewar "isStorageDewar", d.barCode "barCode", d.firstExperimentId "firstSessionId",
					d.type "type", d.facilityCode "facilityCode", d.weight "weight", d.deliveryAgent_barcode "deliveryAgentBarcode"
      FROM Dewar d
        INNER JOIN Shipping s ON s.shippingId = d.shippingId
				INNER JOIN Proposal p ON p.proposalId = s.proposalId
      WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_proposalNumber is NULL';
    END IF;
END ;;
DELIMITER ;
