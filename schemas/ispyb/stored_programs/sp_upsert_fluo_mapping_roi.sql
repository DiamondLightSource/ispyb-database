DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_fluo_mapping_roi`(
    INOUT p_id int(11) unsigned,
    p_startEnergy float,
    p_endEnergy float,
    p_element varchar(2),
    p_edge varchar(15),
    p_r tinyint(3) unsigned,
    p_g tinyint(3) unsigned,
    p_b tinyint(3) unsigned,
    p_blSampleId int(10) unsigned,
    p_scalar varchar(50)
)
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates info about a fluorescence spectrum mapping region of interest (p_id).\nMandatory columns:\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
    INSERT INTO XRFFluorescenceMappingROI (startEnergy, endEnergy, element, edge, r, g, b, blSampleId, scalar)
        VALUES (p_startEnergy, p_endEnergy, p_element, p_edge, p_r, p_g, p_b, p_blSampleId, p_scalar)
    
    ON DUPLICATE KEY UPDATE
        startEnergy = IFNULL(p_startEnergy, startEnergy),
        endEnergy = IFNULL(p_endEnergy, endEnergy),
        element = IFNULL(p_element, element),
        edge = IFNULL(p_edge, edge),
        r = IFNULL(p_r, r),
        g = IFNULL(p_g, g),
        b = IFNULL(p_b, b),
        blSampleId = IFNULL(p_blSampleId, blSampleId),
        scalar = IFNULL(p_scalar, scalar);
    
    IF p_id IS NULL THEN
        SET p_id = LAST_INSERT_ID();
    END IF;
END;;
DELIMITER ;
