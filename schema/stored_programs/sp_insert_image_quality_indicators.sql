DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_quality_indicators`(
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
  p_driftFactor float
)
    MODIFIES SQL DATA
    COMMENT 'Inserts a row into the image quality indicators table'
BEGIN

  IF p_dataCollectionId IS NOT NULL AND p_imageNumber IS NOT NULL THEN
    INSERT INTO ImageQualityIndicators (
      dataCollectionId, autoProcProgramId, imageNumber, spotTotal, inResTotal, goodBraggCandidates, iceRings, 
	  method1Res, method2Res, maxUnitCell, pctSaturationTop50Peaks,
	  inResolutionOvrlSpots, binPopCutOffMethod2Res, totalIntegratedSignal, driftFactor) 
      VALUES (
        p_dataCollectionId, p_autoProcProgramId, p_imageNumber, p_spotTotal, p_inResTotal, p_goodBraggCandidates, p_iceRings,
        p_method1Res, p_method2Res, p_maxUnitCell, p_pctSaturationTop50Peaks, 
        p_inResolutionOvrlSpots, p_binPopCutOffMethod2Res, p_totalIntegratedSignal, p_driftFactor
      );
	SET p_id = 1; -- indicate success ...
  ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) p_dataCollectionId and/or p_imageNumber are NULL';  
  END IF;
END;;
DELIMITER ;