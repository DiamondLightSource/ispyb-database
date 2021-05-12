-- Example calls:
-- First create a Movie and a MotionCorrection:
--
-- SET @mid := NULL;
-- SET @mcid := NULL;
-- CALL upsert_movie(@mid, 6017405, NULL, NULL, NULL, NULL, NULL, NULL);
-- CALL upsert_motion_correction(@mcid, @mid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--
-- Then call this procedure:
-- SET @ppid := NULL;
-- CALL upsert_particle_picker(@ppid, @mcid, NULL, 'pp template 1', 8.1, 151);
--

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_particle_picker`(
  INOUT p_id int(11) unsigned,
  p_firstMotionCorrectionId int(11) unsigned,
  p_programId int(11) unsigned,
  p_particlePickingTemplate varchar(255),
  p_particleDiameter float,
  p_numberOfParticles int unsigned
 )
  MODIFIES SQL DATA
  COMMENT 'Inserts or updates info about a particle picker (p_id).\nMandatory columns:\nFor insert: p_firstMotionCorrectionId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
  IF p_id IS NOT NULL OR p_firstMotionCorrectionId IS NOT NULL THEN
    INSERT INTO ParticlePicker (particlePickerId, firstMotionCorrectionId, programId, particlePickingTemplate, particleDiameter, numberOfParticles)
      VALUES (p_id, p_firstMotionCorrectionId, p_programId, p_particlePickingTemplate, p_particleDiameter, p_numberOfParticles)
      ON DUPLICATE KEY UPDATE
        firstMotionCorrectionId = IFNULL(p_firstMotionCorrectionId, firstMotionCorrectionId),
        programId = IFNULL(p_programId, programId),
        particlePickingTemplate = IFNULL(p_particlePickingTemplate, particlePickingTemplate),
        particleDiameter = IFNULL(p_particleDiameter, particleDiameter),
        numberOfParticles = IFNULL(p_numberOfParticles, numberOfParticles);

    IF p_id IS NULL THEN
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_firstMotionCorrectionId must be non-NULL.';
  END IF;
END;;
DELIMITER ;
