DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_strategy`(
     OUT p_id int(10) unsigned,
     p_screeningOutputId int(10) unsigned,
     p_phiStart float,
     p_phiEnd float,
     p_rotation float,
     p_exposureTime float,
     p_resolution float,
     p_completeness float,
     p_multiplicity float,
     p_anomalous float,
     p_program varchar(45),
     p_rankingResolution float,
     p_transmission float
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening strategy. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningStrategy (
        screeningOutputId, phiStart, phiEnd, rotation, exposureTime, 
        resolution, completeness, multiplicity, anomalous, program, rankingResolution, transmission)
        VALUES (p_screeningOutputId, p_phiStart, p_phiEnd, p_rotation, p_exposureTime, 
        p_resolution, p_completeness, p_multiplicity, p_anomalous, p_program, p_rankingResolution, p_transmission);

	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      

END;;

DELIMITER ;
