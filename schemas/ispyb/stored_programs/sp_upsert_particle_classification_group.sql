-- Example calls:
--
-- -- First create a Movie, a MotionCorrection and a ParticlePicker:
--
-- SET @mid := NULL;
-- SET @mcid := NULL;
-- CALL upsert_movie(@mid, 6017405, NULL, NULL, NULL, NULL, NULL, NULL);
-- CALL upsert_motion_correction(@mcid, @mid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- SET @ppid := NULL;
-- CALL upsert_particle_picker(@ppid, @mcid, NULL, 'pp template 1', 8.1, 151);

-- Then call this procedure:
-- SET @pcgid := NULL;
-- CALL upsert_particle_classification_group(@pcgid, @ppid, NULL, '2D', 1, 1300, 2, 'P222');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_particle_classification_group`(
  INOUT p_id int(11) unsigned,
  p_particlePickerId int(11) unsigned,
  p_programId int(11) unsigned,
  p_type varchar(10),
  p_batchNumber int unsigned,
  p_numberOfParticlesPerBatch int unsigned,
  p_numberOfClassesPerBatch int unsigned,
  p_symmetry varchar(20)
 )
  MODIFIES SQL DATA
  COMMENT 'Inserts or updates info about a particle classification group (p_id).\nMandatory columns:\nFor insert: p_particlePickerId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
  IF p_id IS NOT NULL OR p_particlePickerId IS NOT NULL THEN
    INSERT INTO ParticleClassificationGroup (particleClassificationGroupId, particlePickerId, programId, type, batchNumber, numberOfParticlesPerBatch,
      numberOfClassesPerBatch, symmetry)
      VALUES (p_id, p_particlePickerId, p_programId, p_type, p_batchNumber, p_numberOfParticlesPerBatch, p_numberOfClassesPerBatch, p_symmetry)
      ON DUPLICATE KEY UPDATE
        particlePickerId = IFNULL(p_particlePickerId, particlePickerId),
        programId = IFNULL(p_programId, programId),
        type = IFNULL(p_type, type),
        batchNumber = IFNULL(p_batchNumber, batchNumber),
        numberOfParticlesPerBatch = IFNULL(p_numberOfParticlesPerBatch, numberOfParticlesPerBatch),
        numberOfClassesPerBatch = IFNULL(p_numberOfClassesPerBatch, numberOfClassesPerBatch),
        symmetry = IFNULL(p_symmetry, symmetry);

    IF p_id IS NULL THEN
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_particlePickerId must be non-NULL.';
  END IF;
END;;
DELIMITER ;
