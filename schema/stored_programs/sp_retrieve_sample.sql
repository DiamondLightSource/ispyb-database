DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_sample`(p_id int unsigned, p_useContainerSession boolean, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the sample for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN

      IF p_useContainerSession = True THEN

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT bls.blSampleId "sampleId",
            bls.containerId "containerId",
            bls.diffractionPlanId "dataCollectionPlanId",
            bls.name "sampleName",
            bls.code "sampleCode",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",
            p.proposalId "proposalId",
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.sessionId "sessionId",
            bs.visit_number "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN BLSession bs ON c.sessionId = bs.sessionId
            INNER JOIN Proposal p ON p.proposalId = bs.proposalId
            INNER JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            INNER JOIN Session_has_Person shp ON bs2.sessionId = shp.sessionId
            INNER JOIN Person pe ON pe.personId = shp.personId
          WHERE pe.login = p_authLogin AND	bls.blSampleId = p_id;

        ELSE

          SELECT bls.blSampleId "sampleId",
            bls.containerId "containerId",
            bls.diffractionPlanId "dataCollectionPlanId",
            bls.name "sampleName",
            bls.code "sampleCode",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",
            p.proposalId "proposalId",
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.sessionId "sessionId",
            bs.visit_number "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN BLSession bs ON c.sessionId = bs.sessionId
            INNER JOIN Proposal p ON p.proposalId = bs.proposalId
          WHERE bls.blSampleId = p_id;

        END IF;

      ELSE

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT bls.blSampleId "sampleId",
            bls.containerId "containerId",
            bls.diffractionPlanId "dataCollectionPlanId",
            bls.name "sampleName",
            bls.code "sampleCode",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",
            p.proposalId "proposalId",
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionId",
            NULL "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN Dewar d ON d.dewarId = c.dewarId
            INNER JOIN Shipping s ON s.shippingId = d.shippingId
            INNER JOIN Proposal p ON p.proposalId = s.proposalId
            INNER JOIN BLSession bs ON bs.proposalId = p.proposalId
            INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
            INNER JOIN Person pe ON pe.personId = shp.personId
          WHERE pe.login = p_authLogin AND	bls.blSampleId = p_id;

        ELSE

          SELECT bls.blSampleId "sampleId",
            bls.containerId "containerId",
            bls.diffractionPlanId "dataCollectionPlanId",
            bls.name "sampleName",
            bls.code "sampleCode",
            bls.comments "sampleComments",
            bls.location "sampleLocation",
            bls.subLocation "sampleSubLocation",
            bls.blSampleStatus "sampleStatus",
            p.proposalId "proposalId",
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionId",
            NULL "sessionNumber"
          FROM BLSample bls
            INNER JOIN Container c ON c.containerId = bls.containerId
            INNER JOIN Dewar d ON d.dewarId = c.dewarId
            INNER JOIN Shipping s ON s.shippingId = d.shippingId
            INNER JOIN Proposal p ON p.proposalId = s.proposalId
          WHERE bls.blSampleId = p_id;

        END IF;

      END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
  END IF;
END;;
DELIMITER ;

