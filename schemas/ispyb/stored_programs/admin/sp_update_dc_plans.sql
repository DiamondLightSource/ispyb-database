-- Example calls:
-- CALL update_dc_plans(NULL, NULL, NULL, 398810, '{"strategy": "yes"}', 5, 2.0, 2.0, 'SAD', 3.0, 'Sulphur', 'optical', 1, 'mx');
-- CALL update_dc_plans(NULL, NULL, NULL, 398810, '{"strategy": "no"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'mx');
-- CALL update_dc_plans(NULL, NULL, 34864, NULL, '{"strategy": "maybe"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'mx');
-- CALL update_dc_plans(NULL, 8572, NULL, NULL, '{"strategy": "shoot first, ask questions later"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'mx');
-- CALL update_dc_plans(7227, NULL, NULL, NULL, '{"strategy": "divide and conquer"}', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'mx');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_dc_plans` (
    IN p_shippingId int unsigned,
    IN p_dewarId int unsigned,
    IN p_containerId int unsigned,
    IN p_sampleId int unsigned,
    IN p_strategyOption varchar(200),
    IN p_priority int,
    IN p_minimalResolution float,
    IN p_requiredResolution double,
    IN p_experimentKind varchar(20), 
    IN p_energy float, 
    IN p_anomalousScatterer varchar(255),
    IN p_centringMethod varchar(20),
    IN p_useNulls boolean,
    IN p_useProposalType varchar(10)
)
MODIFIES SQL DATA
COMMENT 'Updates the DiffractionPlan strategyOption and priority for a given shipment.
If p_shippingId is set, then update for all plans in the shipment.
If p_dewarId is set, then update for all plans in the dewar.
If p_containerId is set, then update for all plans in the container.
If p_sampleId is set, then update for all plans in the sample.
If p_useNulls is true, then use plan parameter values as given, otherwise only set them if they are not-null.
p_useProposalType should be a value used in the proposalType column in the ExperimentType table.'
BEGIN

  DECLARE v_null boolean DEFAULT NULL;
  DECLARE v_experimentTypeId int(10) unsigned DEFAULT NULL;

  IF p_useNulls = True THEN
    SET v_null := 1;
  END IF;

  IF p_experimentKind IS NULL THEN
    SET v_experimentTypeId := NULL;
  ELSE
    SELECT experimentTypeId INTO v_experimentTypeId FROM ExperimentType WHERE name = p_experimentKind AND proposalType = p_useProposalType AND active = 1;
  END IF;

  IF p_shippingId IS NOT NULL THEN

    UPDATE DiffractionPlan dp
      INNER JOIN BLSample s ON s.diffractionPlanId = dp.diffractionPlanId
      INNER JOIN Container c ON c.containerId = s.containerId
      INNER JOIN Dewar d ON d.dewarId = c.dewarId
    SET
      dp.strategyOption = nvl2(v_null, p_strategyOption, ifnull(p_strategyOption, dp.strategyOption) ),
      dp.priority = nvl2(v_null, p_priority, ifnull(p_priority, dp.priority) ),
      dp.minimalResolution = nvl2(v_null, p_minimalResolution, ifnull(p_minimalResolution, dp.minimalResolution) ),
      dp.requiredResolution = nvl2(v_null, p_requiredResolution, ifnull(p_requiredResolution, dp.requiredResolution) ),
      dp.experimentKind = nvl2(v_null, p_experimentKind, ifnull(p_experimentKind, dp.experimentKind) ),
      dp.experimentTypeId = nvl2(v_null, v_experimentTypeId, ifnull(v_experimentTypeId, dp.experimentTypeId) ),
      dp.energy = nvl2(v_null, p_energy, ifnull(p_energy, dp.energy) ),
      dp.anomalousScatterer = nvl2(v_null, p_anomalousScatterer, ifnull(p_anomalousScatterer, dp.anomalousScatterer) ),
      dp.centringMethod = nvl2(v_null, p_centringMethod, ifnull(p_centringMethod, dp.centringMethod) )
    WHERE d.shippingId = p_shippingId;

  ELSEIF p_dewarId IS NOT NULL THEN

    UPDATE DiffractionPlan dp
      INNER JOIN BLSample s ON s.diffractionPlanId = dp.diffractionPlanId
      INNER JOIN Container c ON c.containerId = s.containerId
    SET
      dp.strategyOption = nvl2(v_null, p_strategyOption, ifnull(p_strategyOption, dp.strategyOption) ),
      dp.priority = nvl2(v_null, p_priority, ifnull(p_priority, dp.priority) ),
      dp.minimalResolution = nvl2(v_null, p_minimalResolution, ifnull(p_minimalResolution, dp.minimalResolution) ),
      dp.requiredResolution = nvl2(v_null, p_requiredResolution, ifnull(p_requiredResolution, dp.requiredResolution) ),
      dp.experimentKind = nvl2(v_null, p_experimentKind, ifnull(p_experimentKind, dp.experimentKind) ),
      dp.experimentTypeId = nvl2(v_null, v_experimentTypeId, ifnull(v_experimentTypeId, dp.experimentTypeId) ),
      dp.energy = nvl2(v_null, p_energy, ifnull(p_energy, dp.energy) ),
      dp.anomalousScatterer = nvl2(v_null, p_anomalousScatterer, ifnull(p_anomalousScatterer, dp.anomalousScatterer) ),
      dp.centringMethod = nvl2(v_null, p_centringMethod, ifnull(p_centringMethod, dp.centringMethod) )
    WHERE c.dewarId = p_dewarId;

  ELSEIF p_containerId IS NOT NULL THEN

    UPDATE DiffractionPlan dp
      INNER JOIN BLSample s ON s.diffractionPlanId = dp.diffractionPlanId
    SET
      dp.strategyOption = nvl2(v_null, p_strategyOption, ifnull(p_strategyOption, dp.strategyOption) ),
      dp.priority = nvl2(v_null, p_priority, ifnull(p_priority, dp.priority) ),
      dp.minimalResolution = nvl2(v_null, p_minimalResolution, ifnull(p_minimalResolution, dp.minimalResolution) ),
      dp.requiredResolution = nvl2(v_null, p_requiredResolution, ifnull(p_requiredResolution, dp.requiredResolution) ),
      dp.experimentKind = nvl2(v_null, p_experimentKind, ifnull(p_experimentKind, dp.experimentKind) ),
      dp.experimentTypeId = nvl2(v_null, v_experimentTypeId, ifnull(v_experimentTypeId, dp.experimentTypeId) ),
      dp.energy = nvl2(v_null, p_energy, ifnull(p_energy, dp.energy) ),
      dp.anomalousScatterer = nvl2(v_null, p_anomalousScatterer, ifnull(p_anomalousScatterer, dp.anomalousScatterer) ),
      dp.centringMethod = nvl2(v_null, p_centringMethod, ifnull(p_centringMethod, dp.centringMethod) )
    WHERE s.containerId = p_containerId;

  ELSEIF p_sampleId IS NOT NULL THEN

    UPDATE DiffractionPlan dp
      INNER JOIN BLSample s ON s.diffractionPlanId = dp.diffractionPlanId
    SET
      dp.strategyOption = nvl2(v_null, p_strategyOption, ifnull(p_strategyOption, dp.strategyOption) ),
      dp.priority = nvl2(v_null, p_priority, ifnull(p_priority, dp.priority) ),
      dp.minimalResolution = nvl2(v_null, p_minimalResolution, ifnull(p_minimalResolution, dp.minimalResolution) ),
      dp.requiredResolution = nvl2(v_null, p_requiredResolution, ifnull(p_requiredResolution, dp.requiredResolution) ),
      dp.experimentKind = nvl2(v_null, p_experimentKind, ifnull(p_experimentKind, dp.experimentKind) ),
      dp.experimentTypeId = nvl2(v_null, v_experimentTypeId, ifnull(v_experimentTypeId, dp.experimentTypeId) ),
      dp.energy = nvl2(v_null, p_energy, ifnull(p_energy, dp.energy) ),
      dp.anomalousScatterer = nvl2(v_null, p_anomalousScatterer, ifnull(p_anomalousScatterer, dp.anomalousScatterer) ),
      dp.centringMethod = nvl2(v_null, p_centringMethod, ifnull(p_centringMethod, dp.centringMethod) )
    WHERE s.blSampleId = p_sampleId;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='One of arguments p_shippingId, p_dewarId, p_containerId, p_sampleId must be non-NULL';
  END IF;

END ;;
DELIMITER ;
