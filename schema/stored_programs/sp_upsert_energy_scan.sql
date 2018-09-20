DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_energy_scan`(
	 INOUT p_id int(11) unsigned,
	 p_sessionId int(10) unsigned,
	 p_sampleId int(10) unsigned,
	 p_subSampleId int(11) unsigned,
	 p_startTime datetime,
	 p_endTime datetime,
	 p_startEnergy float,
	 p_endEnergy float,
	 p_detector varchar(40),
	 p_element varchar(10),
	 p_edgeEnergy varchar(10),
	 p_synchrotronCurrent float,
	 p_temperature float,
	 p_peakEnergy float,
	 p_peakFPrime float,
	 p_peakFDoublePrime float,
	 p_inflectionEnergy float,
	 p_inflectionFPrime float,
	 p_inflectionFDoublePrime float,
	 p_choochFileFullPath varchar(255),
	 p_jpegChoochFileFullPath varchar(255),
	 p_scanFileFullPath varchar(255),
	 p_beamSizeHorizontal float,
	 p_beamSizeVertical float,
	 p_exposureTime float,
	 p_transmission float,
	 p_flux double,
	 p_fluxEnd double,
	 p_comments varchar(1024))
    MODIFIES SQL DATA
    COMMENT 'Inserts or updates info about an energy scan (p_id).\nMandatory columns:\nFor insert: p_sessionId\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
	IF p_id IS NOT NULL OR p_sessionId IS NOT NULL THEN

      INSERT INTO EnergyScan (energyScanId, sessionId, blSampleId, blSubSampleId, startTime, endTime,
				startEnergy, endEnergy, fluorescenceDetector, element, edgeEnergy, synchrotronCurrent, temperature,
				peakEnergy, peakFPrime, peakFDoublePrime, inflectionEnergy, inflectionFPrime, inflectionFDoublePrime,
		 	 	choochFileFullPath, jpegChoochFileFullPath, scanFileFullPath, beamSizeHorizontal, beamSizeVertical,
		 	 	exposureTime, transmissionFactor, flux, flux_end, comments)
        VALUES (p_id, p_sessionId, p_sampleId, p_subSampleId, p_startTime, p_endTime,
					p_startEnergy, p_endEnergy, p_detector, p_element, p_edgeEnergy, p_synchrotronCurrent, p_temperature,
					p_peakEnergy, p_peakFPrime, p_peakFDoublePrime, p_inflectionEnergy, p_inflectionFPrime, p_inflectionFDoublePrime,
			 	 	p_choochFileFullPath, p_jpegChoochFileFullPath, p_scanFileFullPath, p_beamSizeHorizontal, p_beamSizeVertical,
			 	 	p_exposureTime, p_transmission, p_flux, p_fluxEnd, p_comments)
	    ON DUPLICATE KEY UPDATE
		  		sessionId = IFNULL(p_sessionId, sessionId),
          blSampleId = IFNULL(p_sampleId, blSampleId),
					blSubSampleId = IFNULL(p_subSampleId, blSubSampleId),
          startTime = IFNULL(p_startTime, startTime),
          endTime = IFNULL(p_endTime, endTime),
					startEnergy = IFNULL(p_startEnergy, startEnergy),
					endEnergy = IFNULL(p_endEnergy, endEnergy),
					fluorescenceDetector = IFNULL(p_detector, fluorescenceDetector),
					element = IFNULL(p_element, element),
					edgeEnergy = IFNULL(p_edgeEnergy, edgeEnergy),
					synchrotronCurrent = IFNULL(p_synchrotronCurrent, synchrotronCurrent),
					temperature = IFNULL(p_temperature, temperature),
					peakEnergy = IFNULL(p_peakEnergy, peakEnergy),
					peakFPrime = IFNULL(p_peakFPrime, peakFPrime),
					peakFDoublePrime = IFNULL(p_peakFDoublePrime, peakFDoublePrime),
					inflectionEnergy = IFNULL(p_inflectionEnergy, inflectionEnergy),
					inflectionFPrime = IFNULL(p_inflectionFPrime, inflectionFPrime),
					inflectionFDoublePrime = IFNULL(p_inflectionFDoublePrime, inflectionFDoublePrime),
					choochFileFullPath = IFNULL(p_choochFileFullPath, choochFileFullPath),
					jpegChoochFileFullPath = IFNULL(p_jpegChoochFileFullPath, jpegChoochFileFullPath),
					scanFileFullPath = IFNULL(p_scanFileFullPath, scanFileFullPath),
					beamSizeHorizontal = IFNULL(p_beamSizeHorizontal, beamSizeHorizontal),
					beamSizeVertical = IFNULL(p_beamSizeVertical, beamSizeVertical),
					exposureTime = IFNULL(p_exposureTime, exposureTime),
					transmissionFactor = IFNULL(p_transmission, transmissionFactor),
					flux = IFNULL(p_flux, flux),
					flux_end = IFNULL(p_fluxEnd, flux_end),
          comments = IFNULL(p_comments, comments);

	  IF p_id IS NULL THEN
		  SET p_id = LAST_INSERT_ID();
    END IF;
  ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR p_sessionId must be non-NULL.';
  END IF;
END ;;
DELIMITER ;
