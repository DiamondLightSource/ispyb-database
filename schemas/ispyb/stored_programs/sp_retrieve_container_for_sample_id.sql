DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container_for_sample_id`(p_id int unsigned, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns a single-row result-set with the container and its processing pipeline info for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN

      IF p_authLogin IS NOT NULL THEN
      -- Authorise only if the person (p_authLogin) is a member of a session on
      -- the proposal that the sample belongs to.

        SELECT DISTINCT
          c.containerId, c.dewarId, c.code, c.containerType, c.capacity,
          c.sampleChangerLocation, c.containerStatus, c.bltimeStamp
          "blTimeStamp", c.beamlineLocation, c.screenId, c.scheduleId,
          c.barcode, c.imagerId, c.sessionId, c.ownerId, c.requestedImagerId,
          c.requestedReturn, c.comments, c.experimentType,
          c.storageTemperature, c.containerRegistryId,
          cr.barcode "containerRegistryBarcode", cr.comments
          "containerRegistryComments", cr.recordTimestamp
          "containerRegistryRecordTimestamp",
          o.familyName "ownerFamilyName", o.givenName "ownerGivenName",
          o.emailAddress "ownerEmailAddress",
          pp.name "processingPipelineName", pp.discipline
          "processingPipelineDiscipline", pp.pipelineStatus
          "processingPipelinePipelineStatus", pp.reprocessing
          "processingPipelineReprocessing",
          ppc.name "processingPipelineCategoryName"
        FROM BLSample bls
          INNER JOIN Container c USING (containerId)
          INNER JOIN Dewar USING(dewarId)
          INNER JOIN Shipping s USING(shippingId)
          INNER JOIN BLSession bs ON bs.proposalId = s.proposalId
          INNER JOIN Session_has_Person shp ON shp.sessionId = bs.sessionId
          INNER JOIN Person p ON p.personId = shp.personId
          LEFT OUTER JOIN Person o ON o.personId = c.ownerId
          LEFT OUTER JOIN ContainerRegistry cr USING(containerRegistryId)
          LEFT OUTER JOIN ProcessingPipeline pp
            ON pp.processingPipelineId = c.priorityPipelineId
          LEFT OUTER JOIN ProcessingPipelineCategory ppc
            USING(processingPipelineCategoryId)
        WHERE bls.blSampleId = p_id
          AND p.login = p_authLogin;

      ELSE

        SELECT
          c.containerId, c.dewarId, c.code, c.containerType, c.capacity,
          c.sampleChangerLocation, c.containerStatus, c.bltimeStamp
          "blTimeStamp", c.beamlineLocation, c.screenId, c.scheduleId,
          c.barcode, c.imagerId, c.sessionId, c.ownerId, c.requestedImagerId,
          c.requestedReturn, c.comments, c.experimentType,
          c.storageTemperature, c.containerRegistryId,
          cr.barcode "containerRegistryBarcode", cr.comments
          "containerRegistryComments", cr.recordTimestamp
          "containerRegistryRecordTimestamp",
          o.familyName "ownerFamilyName", o.givenName "ownerGivenName",
          o.emailAddress "ownerEmailAddress",
          pp.name "processingPipelineName", pp.discipline
          "processingPipelineDiscipline", pp.pipelineStatus
          "processingPipelinePipelineStatus", pp.reprocessing
          "processingPipelineReprocessing",
          ppc.name "processingPipelineCategoryName"
        FROM BLSample bls
          INNER JOIN Container c USING (containerId)
          LEFT OUTER JOIN Person o ON o.personId = c.ownerId
          LEFT OUTER JOIN ContainerRegistry cr USING(containerRegistryId)
          LEFT OUTER JOIN ProcessingPipeline pp
            ON pp.processingPipelineId = c.priorityPipelineId
          LEFT OUTER JOIN ProcessingPipelineCategory ppc
            USING(processingPipelineCategoryId)
        WHERE bls.blSampleId = p_id;

    	END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
        MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
  END IF;
END;;
DELIMITER ;
