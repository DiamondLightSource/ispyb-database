-- Example call:
-- select upsert_dcgroup(NULL, 403, 113, 'OSC', now() - 1, now(), NULL, NULL, NULL, NULL, NULL, NULL, 'Karl\'s comments ...');
-- tested OK

DELIMITER $$
CREATE OR REPLACE FUNCTION `upsert_dcgroup` (
	 p_id int(11) unsigned,
     p_parentId int(10) unsigned,
     p_sampleId int(10) unsigned, 
     p_experimenttype varchar(45), -- values controlled by enum on the table
     p_starttime datetime,
     p_endtime datetime,
     p_crystalClass varchar(20),
     p_detectorMode varchar(255),
     p_actualSampleBarcode varchar(45),
     p_actualSampleSlotInContainer integer(10),
     p_actualContainerBarcode varchar(45),
     p_actualContainerSlotInSC integer(10),
     p_comments varchar(1024)
     ) 
     RETURNS int
     MODIFIES SQL DATA
  BEGIN
    INSERT INTO DataCollectionGroup (datacollectionGroupId, sessionId, blsampleId, experimenttype, starttime, endtime, crystalClass, detectorMode, 
      actualSampleBarcode, actualSampleSlotInContainer, actualContainerBarcode, actualContainerSlotInSC, comments) 
      VALUES (p_id, p_parentId, p_sampleId, p_experimenttype, p_starttime, p_endtime, p_crystalClass, p_detectorMode, 
      p_actualSampleBarcode, p_actualSampleSlotInContainer, p_actualContainerBarcode, p_actualContainerSlotInSC, p_comments)
	  ON DUPLICATE KEY UPDATE
		sessionId = IFNULL(p_parentId, sessionId),
        blsampleId = IFNULL(p_sampleId, blsampleId),
        experimenttype = IFNULL(p_experimenttype, experimenttype),
        starttime = IFNULL(p_starttime, starttime),
        endtime = IFNULL(p_endtime, endtime),
        crystalClass = IFNULL(p_crystalClass, crystalClass),
        detectorMode = IFNULL(p_detectorMode, detectorMode),
        actualSampleBarcode = IFNULL(p_actualSampleBarcode, actualSampleBarcode),
        actualSampleSlotInContainer = IFNULL(p_actualSampleSlotInContainer, actualSampleSlotInContainer),
        actualContainerBarcode = IFNULL(p_actualContainerBarcode, actualContainerBarcode),
        actualContainerSlotInSC = IFNULL(p_actualContainerSlotInSC, actualContainerSlotInSC),
        comments = IFNULL(p_comments, comments);

	IF p_id IS NULL THEN 
		RETURN LAST_INSERT_ID();
    ELSE 
		RETURN p_id;
    END IF;
  END$$
DELIMITER ;
