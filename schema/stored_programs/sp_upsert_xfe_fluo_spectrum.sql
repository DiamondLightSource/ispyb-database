DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_xfe_fluo_spectrum`(
	 INOUT p_id int(11) unsigned,
	 p_sessionId int(10) unsigned,
	 p_sampleId int(10) unsigned,
	 p_subSampleId int(11) unsigned,
	 p_startTime datetime,
	 p_endTime datetime,
	 p_energy float,
	 p_fileName varchar(255),
	 p_annotatedPymcaSpectrum varchar(255),
	 p_fittedDataFileFullPath varchar(255),
	 p_jpegScanFileFullPath varchar(255),
	 p_scanFileFullPath varchar(255),
	 p_beamSizeHorizontal float,
	 p_beamSizeVertical float,
	 p_exposureTime float,
	 p_transmission float,
	 p_flux double,
	 p_fluxEnd double,
	 p_comments varchar(1024))
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a fluorescence spectrum measurement (p_id).\nMandatory columns:\nFor insert: p_sessionId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
  IF p_id IS NOT NULL OR p_sessionId IS NOT NULL THEN

      INSERT INTO XFEFluorescenceSpectrum (xfeFluorescenceSpectrumId, sessionId, blSampleId, blSubSampleId, startTime, endTime,
				energy, filename, annotatedPymcaXfeSpectrum, fittedDataFileFullPath,
				jpegScanFileFullPath, scanFileFullPath, beamSizeHorizontal, beamSizeVertical,
				exposureTime, beamTransmission, flux, flux_end, comments)
			  VALUES (p_id, p_sessionId, p_sampleId, p_subSampleId, p_startTime, p_endTime,
					p_energy, p_fileName, p_annotatedPymcaSpectrum, p_fittedDataFileFullPath,
					p_jpegScanFileFullPath, p_scanFileFullPath, p_beamSizeHorizontal, p_beamSizeVertical,
					p_exposureTime, p_transmission, p_flux, p_fluxEnd, p_comments)
				ON DUPLICATE KEY UPDATE
			  		sessionId = IFNULL(p_sessionId, sessionId),
	          blSampleId = IFNULL(p_sampleId, blSampleId),
						blSubSampleId = IFNULL(p_subSampleId, blSubSampleId),
	          startTime = IFNULL(p_startTime, startTime),
	          endTime = IFNULL(p_endTime, endTime),
						energy = IFNULL(p_energy, energy),
						filename = IFNULL(p_fileName, filename),
						annotatedPymcaXfeSpectrum = IFNULL(p_annotatedPymcaSpectrum, annotatedPymcaXfeSpectrum),
						fittedDataFileFullPath = IFNULL(p_fittedDataFileFullPath, fittedDataFileFullPath),
						jpegScanFileFullPath = IFNULL(p_jpegScanFileFullPath, jpegScanFileFullPath),
						scanFileFullPath = IFNULL(p_scanFileFullPath, scanFileFullPath),
						beamSizeHorizontal = IFNULL(p_beamSizeHorizontal, beamSizeHorizontal),
						beamSizeVertical = IFNULL(p_beamSizeVertical, beamSizeVertical),
						exposureTime = IFNULL(p_exposureTime, exposureTime),
						beamTransmission = IFNULL(p_transmission, beamTransmission),
						flux = IFNULL(p_flux, flux),
						flux_end = IFNULL(p_fluxEnd, flux_end),
	          comments = IFNULL(p_comments, comments);

			IF p_id IS NULL THEN
				SET p_id = LAST_INSERT_ID();
			END IF;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_sessionId must be non-NULL.';
	END IF;
END;;
DELIMITER ;
