/* Tests:
CALL retrieve_scm_sample(398828, False, NULL)\G
CALL retrieve_scm_sample(398828, False, 'boaty')\G
CALL retrieve_scm_sample(398828, True, NULL)\G
CALL retrieve_scm_sample(398828, True, 'boaty')\G
*/

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_scm_sample`(p_id int unsigned, p_useContainerSession boolean, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the sample for the given ID'
BEGIN

    IF p_id IS NOT NULL THEN

      IF p_useContainerSession = True THEN

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT bls.blSampleId "sampleId",
            pr.proteinId "materialId",
            bls.containerId "containerId",
            bls.diffractionPlanId "planId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",

            bls.name "sampleName",
            bls.code "sampleCode",
            bls.volume "sampleVolume",
            bls.dimension1 "thickness",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",

            pr.name "materialName",
            pr.acronym "materialAcronym",
            pr.sequence "materialFormula",
            pr.density "materialDensity",
            pr.safetyLevel "materialSafetyLevel", -- enum(GREEN, YELLOW, RED)
            pr.description "materialChemicalDescription",
            pr.molecularMass "materialMolecularMass",
            compt.name "materialType", -- protein, DNA, RNA, small molecule, ...
            conct.name "materialConcentrationType",
            pr.isotropy "materialIsotropy",  -- enum('isotropic','anisotropic')

            et.name "planExperimentType",
            pc.name "planPurificationColumn",
            plan.robotPlateTemperature "planRobotPlateTemperature",
            plan.exposureTemperature "planExposureTemperature",
            plan.transmission "planTransmission",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.visit_number "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN BLSession bs ON c.sessionId = bs.sessionId
            INNER JOIN Proposal p ON p.proposalId = bs.proposalId
            INNER JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            INNER JOIN Session_has_Person shp ON bs2.sessionId = shp.sessionId
            INNER JOIN Person pe ON pe.personId = shp.personId
            LEFT JOIN Crystal cr ON cr.crystalId = bls.crystalId
            LEFT JOIN Protein pr ON pr.proteinId = cr.proteinId
            LEFT JOIN ComponentType compt ON compt.componentTypeId = pr.componentTypeId
            LEFT JOIN ConcentrationType conct ON conct.concentrationTypeId = pr.concentrationTypeId
            LEFT JOIN DiffractionPlan plan ON plan.diffractionPlanId = bls.diffractionPlanId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = plan.experimentTypeId AND et.proposalType = 'scm'
            LEFT JOIN PurificationColumn pc ON pc.purificationColumnId = plan.purificationColumnId
          WHERE pe.login = p_authLogin AND	bls.blSampleId = p_id;

        ELSE

          SELECT DISTINCT bls.blSampleId "sampleId",
            pr.proteinId "materialId",
            bls.containerId "containerId",
            bls.diffractionPlanId "planId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",

            bls.name "sampleName",
            bls.code "sampleCode",
            bls.volume "sampleVolume",
            bls.dimension1 "thickness",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",

            pr.name "materialName",
            pr.acronym "materialAcronym",
            pr.sequence "materialFormula",
            pr.density "materialDensity",
            pr.safetyLevel "materialSafetyLevel", -- enum(GREEN, YELLOW, RED)
            pr.description "materialChemicalDescription",
            pr.molecularMass "materialMolecularMass",
            compt.name "materialType", -- protein, DNA, RNA, small molecule, ...
            conct.name "materialConcentrationType",
            pr.isotropy "materialIsotropy",  -- enum('isotropic','anisotropic')

            et.name "planExperimentType",
            pc.name "planPurificationColumn",
            plan.robotPlateTemperature "planRobotPlateTemperature",
            plan.exposureTemperature "planExposureTemperature",
            plan.transmission "planTransmission",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.visit_number "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN BLSession bs ON c.sessionId = bs.sessionId
            INNER JOIN Proposal p ON p.proposalId = bs.proposalId
            LEFT JOIN Crystal cr ON cr.crystalId = bls.crystalId
            LEFT JOIN Protein pr ON pr.proteinId = cr.proteinId
            LEFT JOIN ComponentType compt ON compt.componentTypeId = pr.componentTypeId
            LEFT JOIN ConcentrationType conct ON conct.concentrationTypeId = pr.concentrationTypeId
            LEFT JOIN DiffractionPlan plan ON plan.diffractionPlanId = bls.diffractionPlanId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = plan.experimentTypeId AND et.proposalType = 'scm'
            LEFT JOIN PurificationColumn pc ON pc.purificationColumnId = plan.purificationColumnId
          WHERE bls.blSampleId = p_id;

        END IF;

      ELSE

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT bls.blSampleId "sampleId",
            pr.proteinId "materialId",
            bls.containerId "containerId",
            bls.diffractionPlanId "planId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",

            bls.name "sampleName",
            bls.code "sampleCode",
            bls.volume "sampleVolume",
            bls.dimension1 "thickness",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",

            pr.name "materialName",
            pr.acronym "materialAcronym",
            pr.sequence "materialFormula",
            pr.density "materialDensity",
            pr.safetyLevel "materialSafetyLevel", -- enum(GREEN, YELLOW, RED)
            pr.description "materialChemicalDescription",
            pr.molecularMass "materialMolecularMass",
            compt.name "materialType", -- protein, DNA, RNA, small molecule, ...
            conct.name "materialConcentrationType",
            pr.isotropy "materialIsotropy",  -- enum('isotropic','anisotropic')

            et.name "planExperimentType",
            pc.name "planPurificationColumn",
            plan.robotPlateTemperature "planRobotPlateTemperature",
            plan.exposureTemperature "planExposureTemperature",
            plan.transmission "planTransmission",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN Dewar d ON d.dewarId = c.dewarId
            INNER JOIN Shipping s ON s.shippingId = d.shippingId
            INNER JOIN Proposal p ON p.proposalId = s.proposalId
            INNER JOIN BLSession bs ON bs.proposalId = p.proposalId
            INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
            INNER JOIN Person pe ON pe.personId = shp.personId
            LEFT JOIN Crystal cr ON cr.crystalId = bls.crystalId
            LEFT JOIN Protein pr ON pr.proteinId = cr.proteinId
            LEFT JOIN ComponentType compt ON compt.componentTypeId = pr.componentTypeId
            LEFT JOIN ConcentrationType conct ON conct.concentrationTypeId = pr.concentrationTypeId
            LEFT JOIN DiffractionPlan plan ON plan.diffractionPlanId = bls.diffractionPlanId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = plan.experimentTypeId AND et.proposalType = 'scm'
            LEFT JOIN PurificationColumn pc ON pc.purificationColumnId = plan.purificationColumnId
          WHERE pe.login = p_authLogin AND bls.blSampleId = p_id;

        ELSE

          SELECT DISTINCT bls.blSampleId "sampleId",
            pr.proteinId "materialId",
            bls.containerId "containerId",
            bls.diffractionPlanId "planId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",

            bls.name "sampleName",
            bls.code "sampleCode",
            bls.volume "sampleVolume",
            bls.dimension1 "thickness",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",

            pr.name "materialName",
            pr.acronym "materialAcronym",
            pr.sequence "materialFormula",
            pr.density "materialDensity",
            pr.safetyLevel "materialSafetyLevel", -- enum(GREEN, YELLOW, RED)
            pr.description "materialChemicalDescription",
            pr.molecularMass "materialMolecularMass",
            compt.name "materialType", -- protein, DNA, RNA, small molecule, ...
            conct.name "materialConcentrationType",
            pr.isotropy "materialIsotropy",  -- enum('isotropic','anisotropic')

            et.name "planExperimentType",
            pc.name "planPurificationColumn",
            plan.robotPlateTemperature "planRobotPlateTemperature",
            plan.exposureTemperature "planExposureTemperature",
            plan.transmission "planTransmission",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN Dewar d ON d.dewarId = c.dewarId
            INNER JOIN Shipping s ON s.shippingId = d.shippingId
            INNER JOIN Proposal p ON p.proposalId = s.proposalId
            LEFT JOIN Crystal cr ON cr.crystalId = bls.crystalId
            LEFT JOIN Protein pr ON pr.proteinId = cr.proteinId
            LEFT JOIN ComponentType compt ON compt.componentTypeId = pr.componentTypeId
            LEFT JOIN ConcentrationType conct ON conct.concentrationTypeId = pr.concentrationTypeId
            LEFT JOIN DiffractionPlan plan ON plan.diffractionPlanId = bls.diffractionPlanId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = plan.experimentTypeId AND et.proposalType = 'scm'
            LEFT JOIN PurificationColumn pc ON pc.purificationColumnId = plan.purificationColumnId
          WHERE bls.blSampleId = p_id;

        END IF;

      END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
  END IF;

END;;

DELIMITER ;