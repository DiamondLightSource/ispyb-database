DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_samples_for_sample_group`(IN p_sampleGroupId int unsigned) 
READS SQL DATA
COMMENT 'Return multi-row result set with sample IDs, order in the group and type for sample group p_sampleGroupId'
BEGIN
    IF NOT (p_sampleGroupId IS NULL) THEN
		SELECT bls.blSampleId "sampleId", bls.containerId "containerId", bls.crystalId "sampleTypeId", bls.name "sampleName",
		  bls.code "sampleCode", bls.comments "sampleComments", bls.location "sampleLocation", 
          bls.packingFraction "samplePackingFraction", 
          bls.dimension1 "dimension1", bls.dimension2 "dimension2", bls.dimension3 "dimension3", 
          bls.shape "shape",
          c.name "sampleTypeName", c.comments "sampleTypeComments", c.spaceGroup "sampleTypeSpaceGroup", c.proteinId "componentId",
          bhb.type "typeInGroup", bhb.groupOrder "orderInGroup"
        FROM BLSampleGroup_has_BLSample bhb 
          INNER JOIN BLSample bls ON bls.blSampleId = bhb.blSampleId 
          INNER JOIN Crystal c ON c.crystalId = bls.crystalId
        WHERE bhb.blSampleGroupId = p_sampleGroupId
        ORDER BY bhb.blSampleId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_sampleGroupId';
    END IF;
END ;;
DELIMITER ;