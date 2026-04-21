-- Note: upsert_dewar_v3 is the same as upsert_dewar_v2 except it doesn't set the deprecated type column
-- Test:
-- SET @id = NULL;
-- CALL upsert_dewar_v3(@id, 'boaty', 6988, 'boatys dewar', NULL, '1', 'at facility', 0, 'DLS-MX-00101', NULL, 0, 0, NULL, NULL, 'DLS-MX-00101', 5, NULL);
--

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_dewar_v3`(

	 INOUT p_id int(10) unsigned,
	 p_authLogin varchar(45),
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
	 p_facilityCode varchar(20),
	 p_weight float,
	 p_deliveryAgentBarcode varchar(30)
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a dewar/parcel (p_id).\nMandatory columns:\nFor insert: none\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
	DECLARE row_storageLocation varchar(45) DEFAULT NULL;
	DECLARE row_dewarStatus varchar(45) DEFAULT NULL;
  DECLARE row_count int unsigned DEFAULT 0;

	IF p_storageLocation IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_storageLocation is NULL';
	END IF;

  IF p_authLogin IS NOT NULL AND p_shippingId IS NOT NULL THEN

    -- Authorise only if the person (p_authLogin) is a member of a session on the proposal of the shipping that the dewar belongs to.
    -- If the dewar doesn't have a shipping this will fail.
    SELECT count(*) INTO row_count
    FROM Shipping s
      INNER JOIN BLSession bs ON bs.proposalId = s.proposalId
      INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
      INNER JOIN Person p ON p.personId = shp.personId
    WHERE p.login = p_authLogin AND s.shippingId = p_shippingId;

    IF row_count = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MYSQL_ERRNO=1643, MESSAGE_TEXT = 'Dewar not in a shipping belonging to one of the p_authLogin Person sessions';
    END IF;
  END IF;

  IF p_id IS NULL THEN
    INSERT INTO Dewar(dewarId,shippingId,code,comments,storageLocation,dewarStatus,isStorageDewar,barCode,firstExperimentId,customsValue,transportValue,
	    trackingNumberToSynchrotron,trackingNumberFromSynchrotron,FACILITYCODE,weight,deliveryAgent_barcode)
	    VALUES (p_id, p_shippingId, p_name, p_comments, p_storageLocation, p_status, p_isStorageDewar, p_barcode, p_firstSessionId, p_customsValue, p_transportValue,
		    p_trackingNumberToSynchrotron, p_trackingNumberFromSynchrotron, p_facilityCode, p_weight, p_deliveryAgentBarcode);
	  SET p_id = LAST_INSERT_ID();
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
