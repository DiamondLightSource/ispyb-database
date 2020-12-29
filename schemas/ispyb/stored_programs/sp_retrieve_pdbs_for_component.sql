/* Test call:
CALL retrieve_pdb_for_component(4357);
*/

DROP PROCEDURE IF EXISTS retrieve_pdb_for_component;

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_pdbs_for_component`(IN p_componentId int unsigned) 
READS SQL DATA
COMMENT 'Return multi-row result set with PDB columns for component p_componentId'
BEGIN
    IF NOT (p_componentId IS NULL) THEN
		SELECT pdb.pdbId "pdbId", pdb.name "name", pdb.contents "contents", pdb.code "code"
        FROM PDB pdb
          INNER JOIN Protein_has_PDB php ON pdb.pdbId = php.pdbId
        WHERE php.proteinId = p_componentId
        ORDER BY pdb.pdbId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_componentId';
    END IF;
END ;;
DELIMITER ;
 
 