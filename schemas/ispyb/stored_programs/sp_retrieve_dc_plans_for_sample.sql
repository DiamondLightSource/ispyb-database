DELIMITER ;;
CREATE OR REPLACE PROCEDURE `retrieve_dc_plans_for_sample`(IN p_sampleId int unsigned)
    READS SQL DATA
    COMMENT 'Return multi-row result-set with info about data collection plan'
BEGIN
    IF NOT (p_sampleId IS NULL) THEN
    SELECT dp.diffractionPlanId "dcPlanId", dp.name "name", bhd.planOrder "sampleOrderInPlan", dp.experimentKind "experimentKind",
      dp.preferredBeamSizeX "preferredBeamSizeX", dp.preferredBeamSizeY "preferredBeamSizeY", dp.requiredResolution "requiredResolution",
      dp.monoBandwidth "monoBandwidth", dp.energy "energy",
      dhd.detectorId "detectorId", dhd.exposureTime "exposureTime", dhd.distance "distance", dhd.roll "roll",
      spm.scanParametersModelId "scanParamModelId", sps.name "scanParamServiceName", spm.sequenceNumber "scanParamSequenceNumber",
      spm.start "scanParamModelStart", spm.stop "scanParamModelStop", spm.step "scanParamModelStep", spm.array "scanParamModelArray"
    FROM BLSample_has_DataCollectionPlan bhd
      INNER JOIN DiffractionPlan dp ON dp.diffractionPlanId = bhd.dataCollectionPlanId
      INNER JOIN ScanParametersModel spm on spm.dataCollectionPlanId = dp.diffractionPlanId
      INNER JOIN ScanParametersService sps on sps.scanParametersServiceId = spm.scanParametersServiceId
      LEFT OUTER JOIN DataCollectionPlan_has_Detector dhd on dhd.dataCollectionPlanId = dp.diffractionPlanId
    WHERE bhd.blSampleId = p_sampleId
    ORDER BY dp.diffractionPlanId ASC, spm.sequenceNumber ASC;

    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_sampleId is NULL';
    END IF;

END ;;
DELIMITER ;
