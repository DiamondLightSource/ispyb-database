DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_strategy_sub_wedge`(
     OUT p_id int(10) unsigned,
     p_screeningStrategyWedgeId int(10) unsigned,
     p_subWedgeNumber int(10) unsigned,
     p_rotationAxis varchar(45),
     p_axisStart float,
     p_axisEnd float,
     p_exposureTime float,
     p_transmission float, 
     p_oscillationRange float,
     p_completeness float,
     p_multiplicity float,
     p_resolution float,
     p_doseTotal float,
     p_numberOfImages	int(10) unsigned,
     p_comments varchar(255)
     )
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening strategy sub-wedge. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningStrategySubWedge (
        screeningStrategyWedgeId, subWedgeNumber, rotationAxis, axisStart, axisEnd, exposureTime, transmission, 
        oscillationRange, completeness, multiplicity, resolution, doseTotal, numberOfImages, comments)
        VALUES (p_screeningStrategyWedgeId, p_subWedgeNumber, p_rotationAxis, p_axisStart, p_axisEnd, p_exposureTime, p_transmission, 
        p_oscillationRange, p_completeness, p_multiplicity, p_resolution, p_doseTotal, p_numberOfImages, p_comments);
        
	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      

END;;

DELIMITER ;
