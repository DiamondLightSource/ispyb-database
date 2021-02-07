DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_screening_output_v2`(
     OUT p_id int(11) unsigned,
     p_screeningId int(10) unsigned,
     p_statusDescription varchar(1024), 
     p_rejectedReflections int(10) unsigned, 
     p_resolutionObtained float, 
     p_spotDeviationR float, 
     p_spotDeviationTheta float, 
     p_beamShiftX float, 
     p_beamShiftY float, 
     p_numSpotsFound int(10) unsigned, 
     p_numSpotsUsed int(10) unsigned, 
     p_numSpotsRejected int(10) unsigned, 
     p_mosaicity float, 
     p_iOverSigma float, 
     p_diffractionRings boolean, 
     p_mosaicityEstimated boolean, 
     p_rankingResolution double, 
     p_program varchar(45), 
     p_doseTotal double, 
     p_totalExposureTime double, 
     p_totalRotationRange double, 
     p_totalNumberOfImages int(11), 
     p_rFriedel double, 
     p_indexingSuccess boolean, 
     p_strategySuccess boolean, 
     p_alignmentSuccess boolean
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening output. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningOutput (screeningId, statusDescription, rejectedReflections, resolutionObtained, spotDeviationR, spotDeviationTheta, 
        beamShiftX, beamShiftY, numSpotsFound, numSpotsUsed, numSpotsRejected, mosaicity, iOverSigma, 
        diffractionRings, mosaicityEstimated, rankingResolution, program, doseTotal, totalExposureTime, totalRotationRange, 
        totalNumberOfImages, rFriedel, indexingSuccess, strategySuccess, alignmentSuccess) 
        VALUES (p_screeningId, p_statusDescription, p_rejectedReflections, p_resolutionObtained, p_spotDeviationR, p_spotDeviationTheta, 
        p_beamShiftX, p_beamShiftY, p_numSpotsFound, p_numSpotsUsed, p_numSpotsRejected, p_mosaicity, p_iOverSigma, 
        p_diffractionRings, p_mosaicityEstimated, p_rankingResolution, p_program, p_doseTotal, p_totalExposureTime, p_totalRotationRange,
        p_totalNumberOfImages, p_rFriedel, p_indexingSuccess, p_strategySuccess, p_alignmentSuccess);

	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      
END;;
