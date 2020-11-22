DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_motion_correction`(
  INOUT p_motionCorrectionId int(11) unsigned,
  p_movieId int(11) unsigned,
  p_autoProcProgramId int(11) unsigned,
  p_imageNumber smallint unsigned,
  p_firstFrame smallint unsigned,
  p_lastFrame smallint unsigned,
  p_dosePerFrame float,
  p_totalMotion float,
  p_averageMotionPerFrame float,
  p_driftPlotFullPath varchar(255),
  p_micrographFullPath varchar(255),
  p_micrographSnapshotFullPath varchar(255),
  p_fftFullPath varchar(255),
  p_fftCorrectedFullPath varchar(255),
  p_patchesUsedX mediumint unsigned,
  p_patchesUsedY mediumint unsigned,
  p_comments varchar(255)
) 
    MODIFIES SQL DATA
BEGIN
    INSERT INTO MotionCorrection (motionCorrectionId, movieId, autoProcProgramId, imageNumber, firstFrame, lastFrame, dosePerFrame, totalMotion, averageMotionPerFrame, driftPlotFullPath, micrographFullPath, micrographSnapshotFullPath, fftFullPath, fftCorrectedFullPath, patchesUsedX, patchesUsedY, comments) 
      VALUES (p_motionCorrectionId, p_movieId, p_autoProcProgramId, p_imageNumber, p_firstFrame, p_lastFrame, p_dosePerFrame, p_totalMotion, p_averageMotionPerFrame, p_driftPlotFullPath, p_micrographFullPath, p_micrographSnapshotFullPath, p_fftFullPath, p_fftCorrectedFullPath, p_patchesUsedX, p_patchesUsedY, p_comments)
      ON DUPLICATE KEY UPDATE
        motionCorrectionId = IFNULL(p_motionCorrectionId, motionCorrectionId),
	movieId = IFNULL(p_movieId, movieId),
	autoProcProgramId = IFNULL(p_autoProcProgramId, autoProcProgramId), 
	imageNumber = IFNULL(p_imageNumber, imageNumber), 
	firstFrame = IFNULL(p_firstFrame, firstFrame), 
	lastFrame = IFNULL(p_lastFrame, lastFrame), 
	dosePerFrame= IFNULL(p_dosePerFrame, dosePerFrame), 
	totalMotion = IFNULL(p_totalMotion, totalMotion), 
	averageMotionPerFrame = IFNULL(p_averageMotionPerFrame, averageMotionPerFrame), 
	driftPlotFullPath = IFNULL(p_driftPlotFullPath, driftPlotFullPath), 
	micrographFullPath = IFNULL(p_micrographFullPath, micrographFullPath), 
	micrographSnapshotFullPath = IFNULL(p_micrographSnapshotFullPath, micrographSnapshotFullPath), 
	fftFullPath = IFNULL(p_fftFullPath, fftFullPath), 
	fftCorrectedFullPath = IFNULL(p_fftCorrectedFullPath, fftCorrectedFullPath), 
	patchesUsedX = IFNULL(p_patchesUsedX, patchesUsedX), 
    patchesUsedY = IFNULL(p_patchesUsedY, patchesUsedY),    
	comments = IFNULL(p_comments, comments);

	IF p_motionCorrectionId IS NULL THEN
	    SET p_motionCorrectionId = LAST_INSERT_ID();
    	END IF;
     END ;;
DELIMITER ;
