DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_strategy_wedge`(
     OUT p_id int(10) unsigned,
     p_screeningStrategyId int(10) unsigned,
     p_wedgeNumber int(10) unsigned,
     p_resolution	float,
     p_completeness float,
     p_multiplicity float,
     p_doseTotal float,
     p_numberOfImages	int(10) unsigned,
     p_phi float,
     p_kappa float,
     p_chi float,
     p_comments varchar(255),
     p_wavelength	double
     )
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening strategy wedge. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningStrategyWedge (
        screeningStrategyId, wedgeNumber, resolution, completeness, multiplicity, doseTotal, numberOfImages, 
        phi, kappa, chi, comments, wavelength)
        VALUES (p_screeningStrategyId, p_wedgeNumber, p_resolution, p_completeness, p_multiplicity, p_doseTotal, p_numberOfImages, 
        p_phi, p_kappa, p_chi, p_comments, p_wavelength);
        
	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      

END;;

DELIMITER ;
