-- Example call
/*
set @sia_id = NULL;
call upsert_sample_image_analysis(@sia_id, 'test_plate2', '1', '/dls/i02-2/data/2016/cm14559-5/.ispyb/something.jpg', NULL, 10, 11, 0.94, now() - INTERVAL 1 second, now());
select * from BLSampleImageAnalysis where blSampleImageAnalysisId = @sia_id;
*/
-- tested OK
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_sample_image_analysis` (
	 INOUT p_id int(11) unsigned,
     p_containerBarcode varchar(45),
     p_sampleLocation varchar(45),
     p_oavSnapshotBefore varchar(255),
     p_oavSnapshotAfter varchar(255),
     p_deltaX int,
     p_deltaY int,
     p_goodnessOfFit float,
     p_scaleFactor float,
     p_resultCode varchar(15),
     p_matchStartTS timestamp,
     p_matchEndTS timestamp
     ) 
MODIFIES SQL DATA
COMMENT 'Insert or update info about the sample image analysis for the most recent sample image on 
container p_containerBarcode in location p_sampleLocation. 
For updates, specify the ID of the row in p_id. 
For inserts, the ID is returned in p_id.'
  BEGIN
      DECLARE row_sampleImageId int(11) unsigned;
      
      IF (p_containerBarcode IS NOT NULL) AND (p_sampleLocation IS NOT NULL) THEN

        SELECT max(blsi.blsampleImageId) INTO row_sampleImageId
        FROM BLSampleImage blsi 
          INNER JOIN BLSample bls ON bls.blsampleId = blsi.blSampleId 
          INNER JOIN Container c ON c.containerId = bls.containerId 
        WHERE c.barcode = p_containerBarcode AND bls.location = p_sampleLocation;

	-- SELECT max(blSampleImageId) INTO row_sampleImageId 
        -- FROM BLSampleImage
        -- WHERE imageFullPath = p_imagerImage;
      
        IF row_sampleImageId is NOT NULL THEN
  
          INSERT INTO BLSampleImageAnalysis (blSampleImageAnalysisId, blSampleImageId, oavSnapshotBefore, oavSnapshotAfter, deltaX, deltaY, 
	        goodnessOfFit, scaleFactor, resultCode, matchStartTimeStamp, matchEndTimeStamp) 
	        VALUES (p_id, row_sampleImageId, p_oavSnapshotBefore, p_oavSnapshotAfter, p_deltaX, p_deltaY, 
              p_goodnessOfFit, p_scaleFactor, p_resultCode, p_matchStartTS, p_matchEndTS)
	        ON DUPLICATE KEY UPDATE
		      blSampleImageId = IFNULL(row_sampleImageId, blSampleImageId),
              oavSnapshotBefore = IFNULL(p_oavSnapshotBefore, oavSnapshotBefore),
              oavSnapshotAfter = IFNULL(p_oavSnapshotAfter, oavSnapshotAfter),
              deltaX = IFNULL(p_deltaX, deltaX),
              deltaY = IFNULL(p_deltaY, deltaY),
              goodnessOfFit = IFNULL(p_goodnessOfFit, goodnessOfFit),
              scaleFactor = IFNULL(p_scaleFactor, scaleFactor),
              resultCode = IFNULL(p_resultCode, resultCode),
              matchStartTimeStamp = IFNULL(p_matchStartTS, matchStartTimeStamp),
              matchEndTimeStamp = IFNULL(p_matchEndTS, matchEndTimeStamp);

	      IF p_id is NULL THEN 
		    SET p_id = LAST_INSERT_ID();
          END IF;      
        END IF;
      END IF;
  END;;
DELIMITER ;
