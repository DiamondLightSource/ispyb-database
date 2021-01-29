DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_quality_indicators`(
  OUT p_id int(11) unsigned,
  p_dataCollectionId int(11) unsigned, 
  p_autoProcProgramId int(10) unsigned, 
  p_imageNumber mediumint(8) unsigned,
  p_spotTotal int(10),
  p_inResTotal int(10),
  p_goodBraggCandidates int(10),
  p_iceRings int(10),
  p_method1Res float,
  p_method2Res float,
  p_maxUnitCell float,
  p_pctSaturationTop50Peaks float,
  p_inResolutionOvrlSpots int(10),
  p_binPopCutOffMethod2Res float,
  p_totalIntegratedSignal double,
  p_dozorScore double,
  p_driftFactor float
)
    MODIFIES SQL DATA
    COMMENT 'Inserts into or updates a row in the image quality indicators table'
BEGIN
  DECLARE row_DataCollectionId int(11) unsigned DEFAULT NULL;
  DECLARE row_imageNumber mediumint(8) unsigned DEFAULT NULL;
  
  IF (p_dataCollectionId IS NOT NULL AND p_imageNumber IS NOT NULL) THEN
    SELECT dataCollectionId, imageNumber INTO row_DataCollectionId, row_imageNumber FROM ImageQualityIndicators WHERE dataCollectionId = p_dataCollectionId AND imageNumber = p_imageNumber;
    IF row_DataCollectionId IS NULL THEN
        INSERT INTO ImageQualityIndicators (
          dataCollectionId, imageNumber, autoProcProgramId, spotTotal, goodBraggCandidates,  
	      method1Res, method2Res, totalIntegratedSignal, dozor_score, driftFactor) 
        VALUES (
          p_dataCollectionId, p_imageNumber, p_autoProcProgramId, p_spotTotal, p_goodBraggCandidates, 
          p_method1Res, p_method2Res, p_totalIntegratedSignal, p_dozorScore, p_driftFactor
        );
        SET p_id = 1;
    ELSE
        -- Not setting dataCollectionId and imageNumber as they are sort of the "primary keys" here
        -- and have already been used for looking up the row:
        UPDATE ImageQualityIndicators 
        SET
          spotTotal = IFNULL(p_spotTotal, spotTotal),
          goodBraggCandidates = IFNULL(p_goodBraggCandidates, goodBraggCandidates),
          method1Res = IFNULL(p_method1Res, method1Res),
          method2Res = IFNULL(p_method2Res, method2Res),
          totalIntegratedSignal = IFNULL(p_totalIntegratedSignal, totalIntegratedSignal),
          dozor_score = IFNULL(p_dozorScore, dozor_score),
          driftFactor = IFNULL(p_driftFactor, driftFactor),
          autoProcProgramId = IFNULL(p_autoProcProgramId, autoProcProgramId)
		WHERE dataCollectionId = p_dataCollectionId AND imageNumber = p_imageNumber;
        SET p_id = 1;
    END IF;
  ELSE
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_dataCollectionId and/or p_imageNumber are NULL';  
  END IF;
END;;
DELIMITER ;