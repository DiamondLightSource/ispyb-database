DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_output_lattice`(
     OUT p_id int(10) unsigned,
     p_screeningOutputId int(10) unsigned,
     p_spaceGroup	varchar(45),
     p_pointGroup	varchar(45),
     p_bravaisLattice	varchar(45),
     p_rawOrientationMatrix_a_x float,
     p_rawOrientationMatrix_a_y float,
     p_rawOrientationMatrix_a_z float,
     p_rawOrientationMatrix_b_x float,
     p_rawOrientationMatrix_b_y float,
     p_rawOrientationMatrix_b_z float,
     p_rawOrientationMatrix_c_x float,
     p_rawOrientationMatrix_c_y float,
     p_rawOrientationMatrix_c_z float,
     p_unitCell_a	float,
     p_unitCell_b	float,
     p_unitCell_c	float,
     p_unitCell_alpha	float,
     p_unitCell_beta	float,
     p_unitCell_gamma	float,
     p_labelitIndexing boolean
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening output lattice. Returns the ID in p_id.'
BEGIN
      INSERT INTO ScreeningOutputLattice (screeningOutputId, spaceGroup, pointGroup, bravaisLattice, 
        rawOrientationMatrix_a_x, rawOrientationMatrix_a_y, rawOrientationMatrix_a_z,
		rawOrientationMatrix_b_x, rawOrientationMatrix_b_y, rawOrientationMatrix_b_z,
        rawOrientationMatrix_c_x, rawOrientationMatrix_c_y, rawOrientationMatrix_c_z,
        unitCell_a, unitCell_b, unitCell_c, unitCell_alpha, unitCell_beta, unitCell_gamma, labelitIndexing) 
        VALUES (p_screeningOutputId, p_spaceGroup, p_pointGroup, p_bravaisLattice, 
        p_rawOrientationMatrix_a_x, p_rawOrientationMatrix_a_y, p_rawOrientationMatrix_a_z,
		p_rawOrientationMatrix_b_x, p_rawOrientationMatrix_b_y, p_rawOrientationMatrix_b_z,
        p_rawOrientationMatrix_c_x, p_rawOrientationMatrix_c_y, p_rawOrientationMatrix_c_z,
        p_unitCell_a, p_unitCell_b, p_unitCell_c, p_unitCell_alpha, p_unitCell_beta, p_unitCell_gamma, p_labelitIndexing
        );
	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      
END;;

DELIMITER ;
