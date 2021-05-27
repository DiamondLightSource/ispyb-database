DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_containers_submitted_non_ls`(IN p_beamline varchar(15))
    READS SQL DATA
    COMMENT 'Returns multi-row result-set with info about submitted, not comp'
BEGIN
SELECT
  c.barcode "containerBarcode",
  c.code "containerName",
  concat(p.proposalcode, p.proposalnumber) "proposal",
  s.shippingName "shipmentName",
  c.capacity "containerCapacity",
  c.containerType "containerType",
  ci.state "inspectionStateLatest",
  i.name "imagerName",
  i.serial "imagerSerialNumber",
  i.temperature "imagerTemperature",
  cq.createdTimeStamp "containerQueueTS",
  blsi.imageFullPath "lastImgFullPath",
  blss.imgFilePath "uploadedImgFilePath", blss.imgFileName "uploadedImgFileName",
  bls.location "sampleLocation",
  dp.experimentKind "experimentKind", dp.exposureTime "exposureTime",
  dp.preferredBeamSizeX "preferredBeamSizeX", dp.preferredBeamSizeY "preferredBeamSizeY", dp.requiredResolution "requiredResolution",
  dp.monochromator "monochromator", 12398.42 / dp.energy "wavelength", dp.transmission "transmission",
  dp.boxSizeX "boxSizeX", dp.boxSizeY "boxSizeY",
  dp.kappaStart "kappaStart", dp.axisStart "axisStart", dp.axisRange "axisRange", dp.numberOfImages "numberOfImages"
FROM Proposal p
  INNER JOIN Shipping s ON s.proposalId = p.proposalId
  INNER JOIN Dewar d ON d.shippingId = s.shippingId
  INNER JOIN Container c ON c.dewarId = d.dewarId
  INNER JOIN BLSession bs ON c.sessionId = bs.sessionId
  INNER JOIN ContainerQueue cq ON c.containerId = cq.containerId
  INNER JOIN ContainerQueueSample cqs on cq.containerQueueId = cqs.containerQueueId
  INNER JOIN BLSubSample blss ON blss.blSubSampleId = cqs.blSubSampleId
  INNER JOIN BLSample bls ON blss.blSampleId = bls.blSampleId
  INNER JOIN DiffractionPlan dp ON dp.diffractionPlanId = blss.diffractionPlanId
  INNER JOIN Imager i ON i.imagerId = c.imagerId
  LEFT OUTER JOIN BLSampleImage blsi ON blsi.blSampleId = blss.blSampleId
  LEFT OUTER JOIN ContainerInspection ci ON ci.containerInspectionId = (
      SELECT max(containerInspectionId) FROM ContainerInspection WHERE containerId = c.containerId
    )
WHERE cq.completedTimeStamp IS NULL AND c.containerStatus = 'in_storage' AND bs.beamlineName = p_beamline
ORDER BY cq.createdTimeStamp ASC;
END ;;
DELIMITER ;