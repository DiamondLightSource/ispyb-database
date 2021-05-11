-- Example calls:
--
-- First create a Movie, a MotionCorrection, a ParticlePicker and a ParticleClassificationGroup:
--
-- SET @mid := NULL;
-- SET @mcid := NULL;
-- CALL upsert_movie(@mid, 6017405, NULL, NULL, NULL, NULL, NULL, NULL);
-- CALL upsert_motion_correction(@mcid, @mid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- SET @ppid := NULL;
-- CALL upsert_particle_picker(@ppid, @mcid, NULL, 'pp template 1', 8.1, 151);
-- SET @pcgid := NULL;
-- CALL upsert_particle_classification_group(@pcgid, @ppid, NULL, '2D', 1, 1300, 2, 'P222');

-- Then call this procedure:
-- SET @pcid := NULL;
-- CALL upsert_particle_classification(@pcid, @pcgid, 1, '/absolute/path/to/image/file', 1200, 2, 3.5, 2.8, 92);

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_particle_classification`(
  INOUT p_id int unsigned,
  p_particleClassificationGroupId int unsigned,
  p_classNumber int unsigned,
  p_classImageFullPath varchar(255),
  p_particlesPerClass int unsigned,
  p_rotationAccuracy int unsigned,
  p_translationAccuracy float,
  p_estimatedResolution float,
  p_overallFourierCompleteness float
 )
  MODIFIES SQL DATA
  COMMENT 'Inserts or updates info about a particle classification (p_id).\nMandatory columns:\nFor insert: p_particleClassificationGroupId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
  IF p_id IS NOT NULL OR p_particleClassificationGroupId IS NOT NULL THEN
    INSERT INTO ParticleClassification (particleClassificationId, 
      particleClassificationGroupId, classNumber, classImageFullPath, 
      particlesPerClass, rotationAccuracy, translationAccuracy, 
      estimatedResolution, overallFourierCompleteness)
      VALUES (p_id, p_particleClassificationGroupId, p_classNumber, 
        p_classImageFullPath, 
        p_particlesPerClass, p_rotationAccuracy, p_translationAccuracy, 
        p_estimatedResolution, p_overallFourierCompleteness)
      ON DUPLICATE KEY UPDATE
        particleClassificationGroupId = IFNULL(p_particleClassificationGroupId, particleClassificationGroupId),
        classNumber = IFNULL(p_classNumber, classNumber),
        classImageFullPath = IFNULL(p_classImageFullPath, classImageFullPath),
        particlesPerClass = IFNULL(p_particlesPerClass, particlesPerClass),
        rotationAccuracy = IFNULL(p_rotationAccuracy, rotationAccuracy),
        translationAccuracy = IFNULL(p_translationAccuracy, translationAccuracy),
        estimatedResolution = IFNULL(p_estimatedResolution, estimatedResolution),
        overallFourierCompleteness = IFNULL(p_overallFourierCompleteness, overallFourierCompleteness);

    IF p_id IS NULL THEN
      SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_particleClassificationGroupId must be non-NULL.';
  END IF;
END;;
DELIMITER ;
