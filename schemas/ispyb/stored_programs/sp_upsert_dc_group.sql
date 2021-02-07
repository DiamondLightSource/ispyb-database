-- Example call
/*
set @dcg_id = NULL;
call upsert_dc_group(@dcg_id, 'sw', 15561, 2, 113, NULL, 'OSC', now() - 1, now(), NULL, NULL, NULL, NULL, NULL, NULL, 'Karl\'s comments ...');
select @dcg_id;
call upsert_dc_group(@dcg_id, 'sw', 15561, 2, 113, NULL, 'OSC', now() - 1, now(), NULL, NULL, NULL, NULL, NULL, NULL, 'Karl\'s comments again ...');
select * from DataCollectionGroup where datacollectiongroupid = @dcg_id;
*/
-- tested OK
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_dc_group` (
	 INOUT p_id int(11) unsigned,
     p_proposalCode varchar(3),
     p_proposalNumber int(10),
     p_sessionNumber int(10),
     p_sampleId int(10) unsigned, 
     p_sampleBarcode varchar(45),
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
MODIFIES SQL DATA
COMMENT 'Inserts or updates info about data collection group (p_id).
Mandatory columns:
For insert: p_proposalCode, p_proposalNumber, p_sessionNumber
For update: p_id 
In order to associate the data collection group with a sample, one of the following sets of parameters are required:
* p_sampleId
* p_proposalCode, p_proposalNumber, p_sessionNumber + p_sampleBarcode
* p_actualContainerBarcode + p_actualSampleSlotInContainer'
  BEGIN

	DECLARE row_session_id int(10) unsigned DEFAULT NULL;
	DECLARE row_proposal_id int(10) unsigned DEFAULT NULL;
	DECLARE row_sample_id int(10) unsigned DEFAULT NULL;
        
	IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL AND p_sessionNumber IS NOT NULL THEN
      SELECT max(bs.sessionid), p.proposalId INTO row_session_id, row_proposal_id 
      FROM Proposal p INNER JOIN BLSession bs ON p.proposalid = bs.proposalid 
      WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber;
      
      IF p_sampleId IS NULL AND p_sampleBarcode IS NOT NULL THEN
        SELECT max(bls.blSampleId) INTO p_sampleId
        FROM BLSample bls
          INNER JOIN Container c on c.containerId = bls.containerId
          INNER JOIN Dewar d on d.dewarId = c.dewarId
          INNER JOIN Shipping s on s.shippingId = d.shippingId
        WHERE bls.code = p_sampleBarcode AND s.proposalId = row_proposal_id;
        
      END IF;
      
      IF p_sampleId IS NULL AND (p_actualContainerBarcode IS NOT NULL) AND (p_actualSampleSlotInContainer IS NOT NULL) THEN
	    SELECT max(bls.blSampleId) INTO p_sampleId
        FROM BLSample bls
          INNER JOIN Container c on c.containerId = bls.containerId
		WHERE c.barcode = p_actualContainerBarcode AND bls.location = p_actualSampleSlotInContainer;
      END IF;
	END IF;

	IF p_id IS NOT NULL OR row_session_id IS NOT NULL THEN

      INSERT INTO DataCollectionGroup (datacollectionGroupId, sessionId, blsampleId, experimenttype, starttime, endtime, crystalClass, detectorMode, 
        actualSampleBarcode, actualSampleSlotInContainer, actualContainerBarcode, actualContainerSlotInSC, comments) 
        VALUES (p_id, row_session_id, p_sampleId, p_experimenttype, p_starttime, p_endtime, p_crystalClass, p_detectorMode, 
        p_actualSampleBarcode, p_actualSampleSlotInContainer, p_actualContainerBarcode, p_actualContainerSlotInSC, p_comments)
	    ON DUPLICATE KEY UPDATE
		  sessionId = IFNULL(row_session_id, sessionId),
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
		  SET p_id = LAST_INSERT_ID();
      END IF;      
    END IF;
  END;;
DELIMITER ;
