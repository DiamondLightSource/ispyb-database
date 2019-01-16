DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container_subsamples_v2`(IN p_barcode varchar(45))
    READS SQL DATA
    COMMENT 'Returns a mutli-row result-set with general info about submitted subsamples on submitted container p_barcode'
BEGIN
  IF NOT (p_barcode IS NULL) THEN
    SELECT blss.blSubSampleId "id", bls.location "sampleLocation", pos1.posX "ROIPos1x", pos1.posY "ROIPos1y", pos1.posZ "ROIPos1z", pos2.posX "ROIPos2x", pos2.posY "ROIPos2y", pos2.posZ "ROIPos2z",
	  blsi.imageFullPath "lastVisibleImgFullPath", blss.imgFilePath "uploadedImgFilePath", blss.imgFileName "uploadedImgFileName",
      dp.experimentKind "experimentKind", dp.exposureTime "exposureTime",
      dp.preferredBeamSizeX "preferredBeamSizeX", dp.preferredBeamSizeY "preferredBeamSizeY", dp.requiredResolution "requiredResolution",
      dp.monochromator "monochromator", 12398.42 / dp.energy "wavelength", dp.transmission "transmission",
      dp.boxSizeX "boxSizeX", dp.boxSizeY "boxSizeY",
      dp.kappaStart "kappaStart", dp.axisStart "axisStart", dp.axisRange "axisRange", dp.numberOfImages "numberOfImages",
      count(dc.dataCollectionId) "numDCs"
    FROM Container c
	    INNER JOIN ContainerQueue cq ON c.containerId = cq.containerId
      INNER JOIN ContainerQueueSample cqs ON cq.containerQueueId = cqs.containerQueueId
      INNER JOIN BLSubSample blss ON blss.blSubSampleId = cqs.blSubSampleId
      INNER JOIN BLSample bls ON blss.blSampleId = bls.blSampleId
      INNER JOIN Position pos1 ON pos1.positionId = blss.positionId
      LEFT OUTER JOIN Position pos2 ON pos2.positionId = blss.position2Id
      INNER JOIN DiffractionPlan dp ON dp.diffractionPlanId = blss.diffractionPlanId
      LEFT OUTER JOIN BLSampleImage blsi ON blsi.blSampleId = bls.blSampleId AND blsi.blSampleImageId = (
        SELECT max(blsi2.blSampleImageId)
        FROM BLSampleImage blsi2
          INNER JOIN ContainerInspection ci ON blsi2.containerInspectionId = ci.containerInspectionId
          INNER JOIN InspectionType it ON ci.inspectionTypeId = it.inspectionTypeId
        WHERE blsi2.blSampleId = bls.blSampleId AND it.name = 'Visible'
      )
      LEFT OUTER JOIN DataCollection dc on dc.blSubSampleId = blss.blSubSampleId
	WHERE c.barcode = p_barcode
    GROUP BY blss.blSubSampleId, location, pos1.posX, pos1.posY, pos1.posZ, pos2.posX, pos2.posY, pos2.posZ,
	  blsi.imageFullPath, blss.imgFilePath, blss.imgFileName,
      dp.experimentKind, dp.exposureTime,
      dp.preferredBeamSizeX, dp.preferredBeamSizeY, dp.requiredResolution,
      dp.monochromator, 12398.42 / dp.energy, dp.transmission,
      dp.boxSizeX, dp.boxSizeY,
      dp.kappaStart, dp.axisStart, dp.axisRange, dp.numberOfImages;
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_barcode is NULL';
  END IF;
END ;;

DELIMITER ;

