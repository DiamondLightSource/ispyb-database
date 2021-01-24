DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_input`(
     OUT p_id int(11) unsigned,
     p_screeningId int(10) unsigned,
     p_beamX float,
     p_beamY float,
     p_rmsErrorLimits float,
     p_minFractionIndexed float,
     p_maxFractionRejected float,
     p_minSignalToNoise float
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening input. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningInput (screeningId, beamX, beamY, rmsErrorLimits, minimumFractionIndexed, maximumFractionRejected, minimumSignalToNoise) 
        VALUES (p_screeningId, p_beamX, p_beamY, p_rmsErrorLimits, p_minFractionIndexed, p_maxFractionRejected, p_minSignalToNoise);

	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      
END;;
DELIMITER ;
