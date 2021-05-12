-- Example calls:
--
-- First create a Movie, a MotionCorrection, a ParticlePicker, a ParticleClassificationGroup and a ParticleClassification:
--
-- SET @mid := NULL;
-- SET @mcid := NULL;
-- CALL upsert_movie(@mid, 6017405, NULL, NULL, NULL, NULL, NULL, NULL);
-- CALL upsert_motion_correction(@mcid, @mid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- SET @ppid := NULL;
-- CALL upsert_particle_picker(@ppid, @mcid, NULL, 'pp template 1', 8.1, 151);
-- SET @pcgid := NULL;
-- CALL upsert_particle_classification_group(@pcgid, @ppid, NULL, '2D', 1, 1300, 2, 'P222');
-- SET @pcid := NULL;
-- CALL upsert_particle_classification(@pcid, @pcgid, 1, '/absolute/path/to/image/file', 1200, 2, 3.5, 2.8, 92);
--
-- Then call this procedure:
-- SET @cimid := NULL;
-- CALL insert_cryoem_initial_model(@cimid, @pcid, 2.9, 326);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_cryoem_initial_model`(
  OUT p_id int unsigned,
  p_particleClassificationId int unsigned,
  p_resolution float,
  p_numberOfParticles int unsigned
 )
  MODIFIES SQL DATA
  COMMENT 'Inserts or updates info about a (cryoEM) initial model for a given particle classification (p_particleClassificationId).\nMandatory columns: p_particleClassificationId\nReturns: Record ID in p_id.'
BEGIN
  IF p_particleClassificationId IS NOT NULL THEN
    START TRANSACTION;

    INSERT INTO CryoemInitialModel (resolution, numberOfParticles)
      VALUES (p_resolution, p_numberOfParticles);

    SET p_id = LAST_INSERT_ID();

    INSERT INTO ParticleClassification_has_CryoemInitialModel (
      particleClassificationId, cryoemInitialModelId
    ) 
    VALUES (
      p_particleClassificationId, p_id
    );

    COMMIT;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: particleClassificationId must be non-NULL.';
  END IF;
END;;
DELIMITER ;
