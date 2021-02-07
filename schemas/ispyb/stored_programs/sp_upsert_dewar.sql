DELIMITER ;;
-- DEFINER=`ispyb_root`@`%`
CREATE OR REPLACE PROCEDURE `upsert_dewar`(
	 INOUT p_id int(10) unsigned,
	 p_shippingId int(10) unsigned,
	 p_name varchar(45),
	 p_comments tinytext,
	 p_storageLocation varchar(45),
	 p_status varchar(45),
	 p_isStorageDewar tinyint(1),
	 p_barcode varchar(45),
	 p_firstSessionId int(10) unsigned,
	 p_customsValue int(11) unsigned,
	 p_transportValue int(11) unsigned,
	 p_trackingNumberToSynchrotron varchar(30),
	 p_trackingNumberFromSynchrotron varchar(30),
	 p_type varchar(40),
	 p_facilityCode varchar(20),
	 p_weight float,
	 p_deliveryAgentBarcode varchar(30)
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a dewar/parcel (p_id).\nMandatory columns:\nFor insert: none\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
    DECLARE row_storageLocation varchar(45) DEFAULT NULL;
	  DECLARE row_dewarStatus varchar(45) DEFAULT NULL;

    IF p_id IS NULL THEN
		  IF p_type IS NOT NULL THEN
        INSERT INTO Dewar(dewarId,shippingId,code,comments,storageLocation,dewarStatus,isStorageDewar,barCode,firstExperimentId,customsValue,transportValue,
			    trackingNumberToSynchrotron,trackingNumberFromSynchrotron,`type`,FACILITYCODE,weight,deliveryAgent_barcode)
			    VALUES (p_id, p_shippingId, p_name, p_comments, p_storageLocation, p_status, p_isStorageDewar, p_barcode, p_firstSessionId, p_customsValue, p_transportValue,
				    p_trackingNumberToSynchrotron, p_trackingNumberFromSynchrotron, p_type, p_facilityCode, p_weight, p_deliveryAgentBarcode);
			  SET p_id = LAST_INSERT_ID();
			ELSE
				SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_type must be non-NULL.';
			END IF;
	  ELSE

      SELECT storageLocation, dewarStatus INTO row_storageLocation, row_dewarStatus FROM Dewar WHERE dewarId = p_id;

			UPDATE Dewar
			  SET shippingId = IFNULL(p_shippingId, shippingId),
				code = IFNULL(p_name, code),
				comments = IFNULL(p_comments, comments),
				storageLocation = IFNULL(p_storageLocation, storageLocation),
				dewarStatus = IFNULL(p_status, dewarStatus),
				isStorageDewar = IFNULL(p_isStorageDewar, isStorageDewar),
				barCode = IFNULL(p_barcode, barCode),
				firstExperimentId = IFNULL(p_firstSessionId, firstExperimentId),
				customsValue = IFNULL(p_customsValue, customsValue),
				transportValue = IFNULL(p_transportValue, transportValue),
				trackingNumberToSynchrotron = IFNULL(p_trackingNumberToSynchrotron, trackingNumberToSynchrotron),
				trackingNumberFromSynchrotron = IFNULL(p_trackingNumberFromSynchrotron, trackingNumberFromSynchrotron),
				`type` = IFNULL(p_type, `type`),
				FACILITYCODE = IFNULL(p_facilityCode, FACILITYCODE),
				weight = IFNULL(p_weight, weight),
				deliveryAgent_barcode = IFNULL(p_deliveryAgentBarcode, deliveryAgent_barcode)
			WHERE dewarId = p_id;

			--  If a dewar is moved or the status has changed then ...
      IF row_storageLocation <> p_storageLocation OR row_dewarStatus <> p_status THEN
        INSERT INTO DewarTransportHistory (dewarId, dewarStatus, storageLocation, arrivalDate)
				  VALUES (p_id, p_status, p_storageLocation, NOW());
      END IF;

			--  If a dewar is moved then ...
		  IF row_storageLocation <> p_storageLocation THEN
			  -- any pucks within the dewar should have sampleChangerLocation set to blank and the containerStatus field set to "at facility"
        UPDATE Container
				SET sampleChangerLocation = '', containerStatus = 'at facility'
				WHERE dewarId = p_id;
			END IF;
		END IF;
END;;
DELIMITER ;
