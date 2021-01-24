DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_fluo_mapping`(
	 INOUT p_id int(11) unsigned,
	 p_roiId int(11) unsigned,
	 p_roiStartEnergy float,
	 p_roiEndEnergy float,
	 p_dcId int(11) unsigned,
	 p_imgNumber int(10) unsigned,
	 p_counts int(10) unsigned
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a fluorescence spectrum mapping (p_id).\nMandatory columns:\nFor insert: (p_roiId OR (p_roiStartEnergy AND p_roiEndEnergy)) AND p_dcId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
  DECLARE row_xrfFluorescenceMappingROIId int(10) unsigned DEFAULT NULL;

	IF p_id IS NOT NULL OR ((p_roiId IS NOT NULL OR (p_roiStartEnergy IS NOT NULL AND p_roiEndEnergy IS NOT NULL)) AND p_dcId IS NOT NULL) THEN

    IF p_roiId IS NULL THEN
      SELECT MAX(xrfFluorescenceMappingROIId) INTO row_xrfFluorescenceMappingROIId
			FROM XRFFluorescenceMappingROI
			WHERE p_roiStartEnergy >= startEnergy AND p_roiEndEnergy <= endEnergy;
		ELSE
		  SET row_xrfFluorescenceMappingROIId = p_roiId;
    END IF;

  	INSERT INTO XRFFluorescenceMapping (xrfFluorescenceMappingId, xrfFluorescenceMappingROIId, dataCollectionId, imageNumber, counts)
	  	VALUES (p_id, row_xrfFluorescenceMappingROIId, p_dcId, p_imgNumber, p_counts)
	  	ON DUPLICATE KEY UPDATE
				xrfFluorescenceMappingROIId = IFNULL(row_xrfFluorescenceMappingROIId, xrfFluorescenceMappingROIId),
				dataCollectionId = IFNULL(p_dcId, dataCollectionId),
				imageNumber = IFNULL(p_imgNumber, imageNumber),
				counts = IFNULL(p_counts, counts);

		IF p_id IS NULL THEN
			SET p_id = LAST_INSERT_ID();
		END IF;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR (p_roiId OR (p_roiStartEnergy AND p_roiEndEnergy)) AND p_dcId) must be non-NULL.';
	END IF;
END;;
DELIMITER ;

