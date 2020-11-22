DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_components_for_sample_type`(IN p_sampleTypeId int unsigned) 
READS SQL DATA
COMMENT 'Return multi-row result-set with component ID and other info about components associated with sample type p_sampleTypeId'
BEGIN
    IF NOT (p_sampleTypeId IS NULL) THEN
      SELECT
          prot.proteinId "componentId", prot.name "componentName", prot.density "componentDensity", prot.sequence "componentContent", prot.molecularMass "componentMolecularMass", 
          c.abundance "componentAbundance"
      FROM Protein prot  
        INNER JOIN Crystal c on prot.proteinId = c.proteinId
      WHERE c.crystalId = p_sampleTypeId
      UNION ALL
      SELECT
          prot.proteinId "componentId", prot.name "componentName", prot.density "componentDensity", prot.sequence "componentContent", prot.molecularMass "componentMolecularMass", 
          bhc.abundance "componentAbundance"
      FROM BLSampleType_has_Component bhc  
        INNER JOIN Protein prot on prot.proteinId = bhc.componentId
      WHERE bhc.blSampleTypeId = p_sampleTypeId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_sampleTypeId is NULL';
    END IF;
END;;
DELIMITER ;
