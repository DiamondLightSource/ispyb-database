DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE retrieve_dewars_for_proposal_code_number_v2(
    p_proposalCode varchar(3),
    p_proposalNumber int unsigned,
    p_authLogin varchar(45))
    READS SQL DATA
    COMMENT 'Return multi-row result-set with dewar ID + other dewar info associated with shipments in a given proposal specified by proposal code, proposal_number'
BEGIN
    IF NOT (p_proposalCode IS NULL OR p_proposalNumber IS NULL) THEN

        IF p_authLogin IS NOT NULL THEN
            SELECT
                d.dewarId "id", d.shippingId "shippingId", d.code "name", d.comments "comments", d.storageLocation "storageLocation",
                d.dewarStatus "status", d.isStorageDewar "isStorageDewar", d.barCode "barCode", d.firstExperimentId "firstSessionId",
				        dr.type "type", d.facilityCode "facilityCode", d.weight "weight", d.deliveryAgent_barcode "deliveryAgentBarcode"
            FROM Dewar d
                LEFT JOIN DewarRegistry dr ON dr.facilityCode = d.facilityCode
                INNER JOIN Shipping s ON s.shippingId = d.shippingId
		            INNER JOIN Proposal p ON p.proposalId = s.proposalId
                INNER JOIN BLSession bs ON bs.proposalId = s.proposalId
                INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
                INNER JOIN Person per ON per.personId = shp.personId
            WHERE per.login = p_authLogin AND p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber
            GROUP BY d.dewarId, d.shippingId, d.code, d.comments, d.storageLocation,
                d.dewarStatus, d.isStorageDewar, d.barCode, d.firstExperimentId,
				        dr.type, d.facilityCode, d.weight, d.deliveryAgent_barcode;
        ELSE
            SELECT
                d.dewarId "id", d.shippingId "shippingId", d.code "name", d.comments "comments", d.storageLocation "storageLocation",
                d.dewarStatus "status", d.isStorageDewar "isStorageDewar", d.barCode "barCode", d.firstExperimentId "firstSessionId",
				        dr.type "type", d.facilityCode "facilityCode", d.weight "weight", d.deliveryAgent_barcode "deliveryAgentBarcode"
            FROM Dewar d
                LEFT JOIN DewarRegistry dr ON dr.facilityCode = d.facilityCode
                INNER JOIN Shipping s ON s.shippingId = d.shippingId
		            INNER JOIN Proposal p ON p.proposalId = s.proposalId
            WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber;
        END IF;

    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_proposalCode and/or p_proposalNumber are NULL';
    END IF;
END ;;
DELIMITER ;
