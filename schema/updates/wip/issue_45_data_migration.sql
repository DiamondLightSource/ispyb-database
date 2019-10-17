--
-- See issue description at:
-- https://github.com/ispyb/ispyb-database-modeling/issues/45

-- TODO:
-- * Finish up INSERT INTO DataCollection ... for EnergyScans
-- * Rename wavelength to startEnergy, convert values
--

-- Copy snapshots to DCFA table.
-- Snapshot 1 will have fileOrder 1, snapshot 2 will have fileOrder 2 and so on.

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileOrder, fileFullPath)
    SELECT dataCollectionId, 'snapshot', 1, xtalSnapshotFullPath1
    FROM DataCollection
    WHERE xtalSnapshotFullPath1 IS NOT NULL;

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileOrder, fileFullPath)
    SELECT dataCollectionId, 'snapshot', 2, xtalSnapshotFullPath2
    FROM DataCollection
    WHERE xtalSnapshotFullPath2 IS NOT NULL;

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileOrder, fileFullPath)
    SELECT dataCollectionId, 'snapshot', 3, xtalSnapshotFullPath3
    FROM DataCollection
    WHERE xtalSnapshotFullPath3 IS NOT NULL;

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileOrder, fileFullPath)
    SELECT dataCollectionId, 'snapshot', 4, xtalSnapshotFullPath4
    FROM DataCollection
    WHERE xtalSnapshotFullPath4 IS NOT NULL;

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileFullPath)
    SELECT dataCollectionId, 'xy', datFullPath
    FROM DataCollection
    WHERE datFullPath IS NOT NULL;

INSERT INTO DataCollectionFileAttachment (dataCollectionId, fileType, fileFullPath)
    SELECT dataCollectionId, 'bestWilsonPlot', bestWilsonPlotPath
    FROM DataCollection
    WHERE bestWilsonPlotPath IS NOT NULL;

-- Skipping datFullPath and processedDataFile as they're not used


-- Modify DC table: add, remove, rename columns as discussed.
-- Since the table changes are likely to trigger a table rebuild which will lock the table and can take a long time if there's a lot of data in the table, let's put as much as possible into a single ALTER TABLE statement so we only trigger one table rebuild:

ALTER TABLE DataCollection
  ADD element float COMMENT 'EnergyScan',
  ADD edgeEnergy float COMMENT 'EnergyScan',
  CHANGE wavelength startEnergy float,
--  ADD startEnergy float COMMENT 'EnergyScan',
  ADD endEnergy float COMMENT 'EnergyScan',
--  ADD peakEnergy float COMMENT 'EnergyScan',
--  ADD inflectionEnergy float COMMENT 'EnergyScan',
--  ADD energy float COMMENT 'XFEFluorescenceSpectrum',
  ADD synchrotronCurrent float COMMENT 'EnergyScan',
--  ADD inflectionFDoublePrime float COMMENT 'EnergyScan',
--  ADD inflectionFPrime float COMMENT 'EnergyScan',
--  ADD peakFDoublePrime float COMMENT 'EnergyScan',
--  ADD peakFPrime float COMMENT 'EnergyScan',
  DROP xtalSnapshotFullPath1,
  DROP xtalSnapshotFullPath2,
  DROP xtalSnapshotFullPath3,
  DROP xtalSnapshotFullPath4,
  DROP processedDataFile,
  DROP datFullPath,
  DROP bestWilsonPlotPath,
  CHANGE numberOfImages numberOfDataPoints int(10) unsigned DEFAULT NULL,
  CHANGE startImageNumber startDataPointNumber int(10) unsigned DEFAULT NULL,
  CHANGE imageDirectory dataDirectory varchar(255) DEFAULT NULL COMMENT 'The directory where data files reside - should end with a slash',
  CHANGE imagePrefix filePrefix varchar(45) DEFAULT NULL,
  CHANGE imageSuffix fileSuffix varchar(45) DEFAULT NULL,
  CHANGE IF EXISTS imageContainerSubPath dataContainerSubPath varchar(255) DEFAULT NULL COMMENT 'Internal path of a HDF5 file pointing to the data for this data collection';

-- Convert from wavelength to energy:
-- UPDATE DataCollection SET startEnergy = ....;

-- Copy the ES rows into DC and DCGroup + move column values into DCFA
-- What should be the DCG.experimentType value for this?

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

DELIMITER ;;
BEGIN NOT ATOMIC
  DECLARE done INT DEFAULT FALSE;
  DECLARE proc_status INT DEFAULT 0;
  DECLARE dcg_id, dc_id, app_id int unsigned;
  DECLARE c_energyScanId, c_sessionId, c_blSampleId, c_blSubSampleId int unsigned;
  DECLARE c_startTime, c_endTime datetime;
  DECLARE c_beamSizeHorizontal, c_beamSizeVertical, c_transmissionFactor, c_exposureTime, c_temperature, c_xrayDose, c_peakEnergy, c_inflectionEnergy, c_inflectionFDoublePrime, c_inflectionFPrime, c_peakFDoublePrime, c_peakFPrime float;
  DECLARE c_flux, c_flux_end double;
  DECLARE c_edgeEnergy, c_scanFileFullPath, c_filename, c_choochFileFullPath, c_jpegChoochFileFullPath, c_workingDirectory varchar(255);
  DECLARE c_comments varchar(1024);
  DECLARE c_crystalClass varchar(20);
  DECLARE c_element varchar(45);

  DECLARE cur1 CURSOR FOR
    SELECT energyScanId, sessionId, blSampleId, blSubSampleId, startTime, endTime, beamSizeHorizontal, beamSizeVertical, transmissionFactor, comments, crystalClass, element, exposureTime, filename, temperature, xrayDose, flux, flux_end, edgeEnergy, peakEnergy, inflectionEnergy, inflectionFDoublePrime, inflectionFPrime, peakFDoublePrime, peakFPrime, scanFileFullPath, choochFileFullPath, jpegChoochFileFullPath, workingDirectory
    FROM EnergyScan;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;
  read_loop: LOOP
    FETCH cur1 INTO c_energyScanId, c_sessionId, c_blSampleId, c_blSubSampleId, c_startTime, c_endTime, c_beamSizeHorizontal, c_beamSizeVertical, c_transmissionFactor, c_comments, c_crystalClass, c_element, c_exposureTime, c_filename, c_temperature, c_xrayDose, c_flux, c_flux_end, c_edgeEnergy, c_peakEnergy, c_inflectionEnergy, c_inflectionFDoublePrime, c_inflectionFPrime, c_peakFDoublePrime, c_peakFPrime, c_scanFileFullPath, c_choochFileFullPath, c_jpegChoochFileFullPath, c_workingDirectory;
    IF done THEN
      LEAVE read_loop;
    END IF;

    IF c_blSampleId IS NULL THEN
      SELECT max(blSampleId) INTO c_blSampleId FROM BLSample_has_EnergyScan WHERE energyScanId = c_energyScanId;
    END IF;

    INSERT INTO DataCollectionGroup (
      sessionId, blSampleId, experimentType, startTime, endTime)
      VALUES (
        c_sessionId, c_blSampleId, 'Energy scan', c_startTime, c_endTime);

    SET dcg_id := LAST_INSERT_ID();

    INSERT INTO DataCollection (
      dataCollectionGroupId, blSubSampleId, startTime, endTime, experimentType, dataDirectory)
      VALUES (
        dcg_id, c_blSubSampleId, c_startTime, c_endTime, 'Energy scan', c_workingDirectory);

    SET dc_id := LAST_INSERT_ID();

    IF c_scanFileFullPath IS NOT NULL THEN
      INSERT INTO DataCollectionFileAttachment (
        dataCollectionId, fileType, fileFullPath)
        VALUES (dc_id, 'scanFile', c_scanFileFullPath);
    END IF;

    IF c_choochFileFullPath IS NOT NULL OR c_jpegChoochFileFullPath IS NOT NULL THEN
      SET proc_status := 1;
    ELSE
      SET proc_status := 0;
    END IF;

    INSERT INTO AutoProcProgram (dataCollectionId, processingPrograms, processingStatus) VALUES (dc_id, 'chooch', proc_status);

    SET app_id := LAST_INSERT_ID();

    INSERT INTO KramersKronig (
      autoProcProgramId, edgeEnergy, peakEnergy, inflectionEnergy, inflectionFDoublePrime, inflectionFPrime, peakFDoublePrime, peakFPrime, fitFileFullPath, jpegFitFileFullPath)
        VALUES (app_id, c_edgeEnergy, c_peakEnergy, c_inflectionEnergy, c_inflectionFDoublePrime, c_inflectionFPrime, c_peakFDoublePrime, c_peakFPrime, c_choochFileFullPath, c_jpegChoochFileFullPath);

    INSERT INTO Project_has_DCGroup (projectId, dataCollectionGroupId)
      SELECT projectId, dcg_id FROM Project_has_EnergyScan WHERE energyScanId = c_energyScanId;

  END LOOP;
  CLOSE cur1;
END;;
DELIMITER ;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;


-- Copy the XFE FS rows into DC and DCGroup + move column values into DCFA
-- What should be the DCG.experimentType value for this?

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

DELIMITER ;;
BEGIN NOT ATOMIC
  DECLARE done INT DEFAULT FALSE;
  DECLARE proc_status INT DEFAULT 0;
  DECLARE dcg_id, dc_id, app_id int unsigned;
  DECLARE c_xfeFluorescenceSpectrumId, c_sessionId, c_blSampleId, c_blSubSampleId int unsigned;
  DECLARE c_startTime, c_endTime datetime;
  DECLARE c_beamSizeHorizontal, c_beamSizeVertical, c_beamTransmission, c_exposureTime, c_energy, c_axisPosition float;
  DECLARE c_flux, c_flux_end double;
  DECLARE c_scanFileFullPath, c_jpegScanFileFullPath, c_filename, c_annotatedPymcaXfeSpectrum, c_fittedDataFileFullPath, c_workingDirectory varchar(255);
  DECLARE c_comments varchar(1024);
  DECLARE c_crystalClass varchar(20);
  DECLARE c_element varchar(45);

  DECLARE cur2 CURSOR FOR
    SELECT xfeFluorescenceSpectrumId, sessionId, blSampleId, blSubSampleId, startTime, endTime, beamSizeHorizontal, beamSizeVertical, beamTransmission, comments, crystalClass, exposureTime, filename, flux, flux_end, scanFileFullPath, jpegScanFileFullPath, annotatedPymcaXfeSpectrum, fittedDataFileFullPath, energy, workingDirectory, axisPosition
    FROM XFEFluorescenceSpectrum;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur2;
    read_loop2: LOOP

    FETCH cur2 INTO c_xfeFluorescenceSpectrumId, c_sessionId, c_blSampleId, c_blSubSampleId, c_startTime, c_endTime, c_beamSizeHorizontal, c_beamSizeVertical, c_beamTransmission, c_comments, c_crystalClass, c_exposureTime, c_filename, c_flux, c_flux_end, c_scanFileFullPath, c_jpegScanFileFullPath, c_annotatedPymcaXfeSpectrum, c_fittedDataFileFullPath, c_energy, c_workingDirectory, c_axisPosition;
    IF done THEN
      LEAVE read_loop2;
    END IF;

    INSERT INTO DataCollectionGroup (
      sessionId, blSampleId, experimentType, startTime, endTime)
      VALUES (
        c_sessionId, c_blSampleId, 'XRF spectrum', c_startTime, c_endTime);

    SET dcg_id := LAST_INSERT_ID();

    INSERT INTO DataCollection (
      dataCollectionGroupId, blSubSampleId, startTime, endTime, experimentType, element, beamSizeAtSampleX, beamSizeAtSampleY, transmission, comments, crystalClass, exposureTime, flux, flux_end, startEnergy, endEnergy, dataDirectory, axisStart, axisEnd, axisRange, rotationAxis)
      VALUES (
        dcg_id, c_blSubSampleId, c_startTime, c_endTime, 'XRF spectrum', c_element, c_beamSizeHorizontal, c_beamSizeVertical, c_beamTransmission, c_comments, c_crystalClass, c_exposureTime, c_flux, c_flux_end, c_energy, c_energy, c_workingDirectory, c_axisPosition, c_axisPosition, 0, 'Omega');

    SET dc_id := LAST_INSERT_ID();

    IF c_fittedDataFileFullPath IS NOT NULL OR c_annotatedPymcaXfeSpectrum IS NOT NULL THEN
      SET proc_status := 1;
    ELSE
      SET proc_status := 0;
    END IF;

    INSERT INTO AutoProcProgram (
      dataCollectionId, processingPrograms, processingStatus)
      VALUES (
        dc_id, 'pymca', proc_status
      );

    SET app_id := LAST_INSERT_ID();

    INSERT INTO MCAProcessing (autoProcProgramId, annotatedSpectrum, fittedDataFileFullPath) -- no peakListFullPath?
      VALUES (app_id, c_annotatedPymcaXfeSpectrum, c_fittedDataFileFullPath);

    IF c_filename IS NOT NULL THEN
      INSERT INTO DataCollectionFileAttachment (
        dataCollectionId, fileType, fileFullPath)
        VALUES (dc_id, 'mcaFile', c_filename);
    END IF;

    IF c_scanFileFullPath IS NOT NULL THEN
      INSERT INTO DataCollectionFileAttachment (
        dataCollectionId, fileType, fileFullPath)
        VALUES (dc_id, 'scanFile', c_scanFileFullPath);
    END IF;

    IF c_jpegScanFileFullPath IS NOT NULL THEN
      INSERT INTO DataCollectionFileAttachment (
        dataCollectionId, fileType, fileFullPath)
        VALUES (dc_id, 'jpegScanFile', c_jpegScanFileFullPath);
    END IF;

  END LOOP;
  CLOSE cur2;

END;;
DELIMITER ;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
