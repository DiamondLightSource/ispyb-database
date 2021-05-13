DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_quality_indicators`(p_dataCollectionId int unsigned,
p_imageNumber int unsigned)
READS SQL DATA
COMMENT 'Returns a single-row result set with the image quality indicators for a given data collection id and image number.'
BEGIN
	IF p_dataCollectionId IS NOT NULL THEN
		IF p_imageNumber IS NOT NULL THEN

			SELECT
			  dataCollectionId,
			  imageNumber,
			  imageId,
			  autoProcProgramId,
			  spotTotal,
			  inResTotal,
			  goodBraggCandidates,
			  iceRings,
			  method1Res,
			  method2Res,
			  maxUnitCell,
			  pctSaturationTop50Peaks,
			  inResolutionOvrlSpots,
			  binPopCutOffMethod2Res,
			  recordTimeStamp,
			  totalIntegratedSignal,
			  dozor_score,
			  driftFactor
			FROM ImageQualityIndicators
			WHERE dataCollectionId = p_dataCollectionId
			  AND imageNumber = p_imageNumber;

		ELSE
		  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
		    MESSAGE_TEXT='Mandatory arguments p_imageNumber can not be NULL';
		END IF;

	ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	  MESSAGE_TEXT='Mandatory arguments dataCollectionId can not be NULL';
	END IF;
END;;
DELIMITER ;
