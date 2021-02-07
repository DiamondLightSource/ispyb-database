/* Test:
call retrieve_samples_assigned_for_proposal('cm', 14451);
*/
DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_samples_assigned_for_proposal`(IN p_proposalCode varchar(3), IN p_proposalNumber int)
    READS SQL DATA
    COMMENT 'Retrieve the user friendly name and ID of all assigned instances'
BEGIN
    IF NOT (p_proposalCode IS NULL) AND NOT (p_proposalNumber IS NULL) THEN
        SELECT bls.blSampleId "sampleId", bls.containerId "containerId", bls.name "sampleName", bls.code "sampleCode", bls.comments "sampleComments", bls.location "sampleLocation",
          bls.packingFraction "samplePackingFraction", bls.dimension1 "dimension1", bls.dimension2 "dimension2", bls.dimension3 "dimension3", 
          bls.shape "shape",
          cr.crystalId "sampleTypeId", cr.name "sampleTypeName", cr.comments "sampleTypeComments", cr.spaceGroup "sampleTypeSpaceGroup",
          dp.diffractionPlanId "dcPlanId", dp.name "dcPlanName"
        FROM BLSample bls
          INNER JOIN BLSample_has_DataCollectionPlan bhd on bls.blSampleId = bhd.blSampleId
          INNER JOIN DiffractionPlan dp on bhd.dataCollectionPlanId = dp.diffractionPlanId
          INNER JOIN Container c on c.containerId = bls.containerId
          INNER JOIN Crystal cr on cr.crystalId = bls.crystalId
          INNER JOIN Protein prot on prot.proteinId = cr.proteinId
          INNER JOIN Proposal p on p.proposalId = prot.proposalId
        WHERE
          p.proposalCode = p_proposalCode AND p_proposalNumber = p.proposalNumber AND c.containerStatus = 'processing'
        ORDER BY
          bls.blSampleId ASC;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='One or more mandatory arguments are NULL: p_proposalCode, p_proposalNumber';
    END IF;
END;;
DELIMITER ;