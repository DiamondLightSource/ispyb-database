DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_fluo_mapping`(
    INOUT p_id int(11) unsigned,
    p_xrfFluorescenceMappingROIId int(11),
    p_gridInfoId int(11) unsigned,
    p_dataFormat varchar(15),
    p_data longblob,
    p_points int(11),
    p_opacity float,
    p_colourMap varchar(20),
    p_min int(3),
    p_max int(3),
    p_autoProcProgramId int(10) unsigned
)
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates info about a fluorescence spectrum mapping (p_id).\nMandatory columns:\nFor insert: \nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
    INSERT INTO XRFFluorescenceMapping (xrfFluorescenceMappingId, xrfFluorescenceMappingROIId, gridInfoId, dataFormat, data, points, opacity, colourMap, min, max, autoProcProgramId)
        VALUES (p_id, p_xrfFluorescenceMappingROIId, p_gridInfoId, p_dataFormat, UNHEX(p_data), p_points, p_opacity, p_colourMap, p_min, p_max, p_autoProcProgramId)
    
    ON DUPLICATE KEY UPDATE
        xrfFluorescenceMappingROIId = IFNULL(p_xrfFluorescenceMappingROIId, xrfFluorescenceMappingROIId),
        gridInfoId = IFNULL(p_gridInfoId, gridInfoId),
        dataFormat = IFNULL(p_dataFormat, dataFormat),
        data = IFNULL(UNHEX(p_data), data),
        points = IFNULL(p_points, points),
        opacity = IFNULL(p_opacity, opacity),
        colourMap = IFNULL(p_colourMap, colourMap),
        min = IFNULL(p_min, min),
        max = IFNULL(p_max, max),
        autoProcProgramId = IFNULL(p_autoProcProgramId, autoProcProgramId);
    
    IF p_id IS NULL THEN
        SET p_id = LAST_INSERT_ID();
    END IF;
END;;
DELIMITER ;
