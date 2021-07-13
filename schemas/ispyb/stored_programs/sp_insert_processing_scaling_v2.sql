-- Example:
--
/* 

SET @id := NULL;
CALL insert_processing_scaling_v2(@id, 596406, 
  'overall', 'comment 1', 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 1, 2, 1.0, 2.0, 3.0, 4.0, True, 1.0, 2.0, 3.0, 4.0,
  'innerShell', 'comment 2', 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 1, 2, 1.0, 2.0, 3.0, 4.0, True, 1.0, 2.0, 3.0, 4.0,
  'outerShell', 'comment 3', 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 1, 2, 1.0, 2.0, 3.0, 4.0, True, 1.0, 2.0, 3.0, 4.0
);

*/

DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_processing_scaling_v2`(
     OUT p_id integer unsigned,
     p_parentId integer unsigned,

     p_Type1 enum('overall','innerShell','outerShell'),
     p_Comments1 varchar(255),
     p_ResolutionLimitLow1 float ,
     p_ResolutionLimitHigh1 float ,
     p_rMerge1 float ,
     p_rMeasWithinIPlusIMinus1 float ,
     p_rMeasAllIPlusIMinus1 float,
     p_rPimWithinIPlusIMinus1 float,
     p_rPimAllIPlusIMinus1 float,
     p_fractionalPartialBias1 float,
     p_nTotalObservations1 integer,
     p_nTotalUniqueObservations1 integer,
     p_meanIOverSigI1 float,
     p_resIOverSigI21 float,
     p_completeness1 float,
     p_multiplicity1 float,
     p_anomalous1 boolean,
     p_anomalousCompleteness1 float,
     p_anomalousMultiplicity1 float,
     p_ccHalf1 float,
     p_ccAnomalous1 float,

     p_Type2 enum('overall','innerShell','outerShell'),
     p_Comments2 varchar(255),
     p_ResolutionLimitLow2 float,
     p_ResolutionLimitHigh2 float,
     p_rMerge2 float,
     p_rMeasWithinIPlusIMinus2 float,
     p_rMeasAllIPlusIMinus2 float,
     p_rPimWithinIPlusIMinus2 float,
     p_rPimAllIPlusIMinus2 float,
     p_fractionalPartialBias2 float,
     p_nTotalObservations2 integer,
     p_nTotalUniqueObservations2 integer,
     p_meanIOverSigI2 float,
     p_resIOverSigI22 float,
     p_completeness2 float,
     p_multiplicity2 float,
     p_anomalous2 boolean,
     p_anomalousCompleteness2 float,
     p_anomalousMultiplicity2 float,
     p_ccHalf2 float,
     p_ccAnomalous2 float,

     p_Type3 enum('overall','innerShell','outerShell'),
     p_Comments3 varchar(255),
     p_ResolutionLimitLow3 float,
     p_ResolutionLimitHigh3 float,
     p_rMerge3 float,
     p_rMeasWithinIPlusIMinus3 float,
     p_rMeasAllIPlusIMinus3 float,
     p_rPimWithinIPlusIMinus3 float,
     p_rPimAllIPlusIMinus3 float,
     p_fractionalPartialBias3 float,
     p_nTotalObservations3 integer,
     p_nTotalUniqueObservations3 integer,
     p_meanIOverSigI3 float,
     p_resIOverSigI23 float,
     p_completeness3 float,
     p_multiplicity3 float,
     p_anomalous3 boolean,
     p_anomalousCompleteness3 float,
     p_anomalousMultiplicity3 float,
     p_ccHalf3 float,
     p_ccAnomalous3 float
  )
    MODIFIES SQL DATA
    COMMENT 'Inserts 1 row in AutoProcScaling, 3 rows in AutoProcScalingStatistics. Returns: autoProcScalingId value in p_id'
BEGIN
    IF p_parentid IS NULL THEN
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_parentid is NULL';
	ELSE

	  START TRANSACTION;
	  INSERT INTO AutoProcScaling (autoProcId, recordTimeStamp)
        VALUES (p_parentId, now());

	  SET p_id = LAST_INSERT_ID();

      INSERT INTO AutoProcScalingStatistics (autoProcScalingId, scalingStatisticsType, comments, resolutionLimitLow, resolutionLimitHigh, rMerge,
        rMeasWithinIPlusIMinus, rMeasAllIPlusIMinus, rPimWithinIPlusIMinus, rPimAllIPlusIMinus, fractionalPartialBias, nTotalObservations, nTotalUniqueObservations,
        meanIOverSigI, resIOverSigI2, completeness, multiplicity, anomalous, anomalousCompleteness, anomalousMultiplicity, ccHalf, ccAnomalous, recordTimeStamp)
        VALUES (p_id, p_Type1, p_Comments1, p_ResolutionLimitLow1, p_ResolutionLimitHigh1, p_rMerge1, p_rMeasWithinIPlusIMinus1, p_rMeasAllIPlusIMinus1,
          p_rPimWithinIPlusIMinus1, p_rPimAllIPlusIMinus1, p_fractionalPartialBias1, p_nTotalObservations1, p_nTotalUniqueObservations1, p_meanIOverSigI1,
          p_resIOverSigI21, p_completeness1, p_multiplicity1, p_anomalous1, p_anomalousCompleteness1, p_anomalousMultiplicity1, p_ccHalf1, p_ccAnomalous1, now());

      INSERT INTO AutoProcScalingStatistics (autoProcScalingId, scalingStatisticsType, comments, resolutionLimitLow, resolutionLimitHigh, rMerge,
        rMeasWithinIPlusIMinus, rMeasAllIPlusIMinus, rPimWithinIPlusIMinus, rPimAllIPlusIMinus, fractionalPartialBias, nTotalObservations, nTotalUniqueObservations,
        meanIOverSigI, resIOverSigI2, completeness, multiplicity, anomalous, anomalousCompleteness, anomalousMultiplicity, ccHalf, ccAnomalous, recordTimeStamp)
        VALUES (p_id, p_Type2, p_Comments2, p_ResolutionLimitLow2, p_ResolutionLimitHigh2, p_rMerge2, p_rMeasWithinIPlusIMinus2, p_rMeasAllIPlusIMinus2,
          p_rPimWithinIPlusIMinus2, p_rPimAllIPlusIMinus2, p_fractionalPartialBias2, p_nTotalObservations2, p_nTotalUniqueObservations2, p_meanIOverSigI2,
          p_resIOverSigI22, p_completeness2, p_multiplicity2, p_anomalous2, p_anomalousCompleteness2, p_anomalousMultiplicity2, p_ccHalf2, p_ccAnomalous2, now());

      INSERT INTO AutoProcScalingStatistics (autoProcScalingId, scalingStatisticsType, comments, resolutionLimitLow, resolutionLimitHigh, rMerge,
        rMeasWithinIPlusIMinus, rMeasAllIPlusIMinus, rPimWithinIPlusIMinus, rPimAllIPlusIMinus, fractionalPartialBias, nTotalObservations, nTotalUniqueObservations,
        meanIOverSigI, resIOverSigI2, completeness, multiplicity, anomalous, anomalousCompleteness, anomalousMultiplicity, ccHalf, ccAnomalous, recordTimeStamp)
        VALUES (p_id, p_Type3, p_Comments3, p_ResolutionLimitLow3, p_ResolutionLimitHigh3, p_rMerge3, p_rMeasWithinIPlusIMinus3, p_rMeasAllIPlusIMinus3,
          p_rPimWithinIPlusIMinus3, p_rPimAllIPlusIMinus3, p_fractionalPartialBias3, p_nTotalObservations3, p_nTotalUniqueObservations3, p_meanIOverSigI3,
          p_resIOverSigI23, p_completeness3, p_multiplicity3, p_anomalous3, p_anomalousCompleteness3, p_anomalousMultiplicity3, p_ccHalf3, p_ccAnomalous3, now());
	  COMMIT;

    END IF;
  END ;;
DELIMITER ;