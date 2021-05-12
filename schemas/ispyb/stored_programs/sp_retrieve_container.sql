DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_container`(p_containerId int unsigned, p_useContainerSession boolean, p_authLogin varchar(45))
READS SQL DATA
COMMENT 'Returns a single-row result-set with the container for the given Id'
BEGIN

    IF p_containerId IS NOT NULL THEN

	IF p_useContainerSession = True THEN

	    IF p_authLogin IS NOT NULL THEN

		SELECT DISTINCT c.containerId "containerId",
		    c.dewarId "dewarId",
		    c.code "code",
		    IFNULL(ct.name, c.containerType) "containerType",
		    c.capacity "capacity",
		    c.sampleChangerLocation "sampleChangerLocation",
		    c.containerStatus "containerStatus",
		    c.blTimeStamp "blTimeStamp",
		    c.beamlineLocation "beamlineLocation",
		    c.screenId "screenId",
		    c.scheduleId "scheduleId",
		    c.barcode "barcode",
		    c.imagerId "imagerId",
		    c.sessionId "sessionId",
		    c.ownerId "ownerId",
		    c.requestedImagerId "requestedImagerId",
		    c.requestedReturn "requestedReturn",
		    c.comments "comments",
		    IFNULL(et.name, c.experimentType) "experimentType",
		    c.storageTemperature "storageTemperature",
		    c.containerRegistryId "containerRegistryId",
		    c.scLocationUpdated "scLocationUpdated",
		    c.priorityPipelineId "priorityPipelineId",
		    c.experimentTypeId "experimentTypeId",
		    c.containerTypeId "containerTypeId",
			p.proposalCode "proposalCode",
			p.proposalNumber "proposalNumber",
			bs.visitNumber "visitNumber"
		FROM Container c
		    INNER JOIN BLSession bs ON bs.sessionId = c.sessionId
		    INNER JOIN Proposal p ON p.proposalId = bs.proposalId
		    INNER JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
		    INNER JOIN Session_has_Person shp ON shp.sessionId = shp.bs2.sessionId
		    INNER JOIN Person per on per.personId = shp.personId
		    LEFT OUTER JOIN ContainerType ct ON ct.containerTypeId = c.containerTypeId
		    LEFT OUTER JOIN Person per2 ON per2.personId = c.ownerId
		    LEFT OUTER JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
		WHERE c.containerId = p_containerId AND per.login = p_authLogin;

	    ELSE

	        SELECT DISTINCT c.containerId "containerId",
		    c.dewarId "dewarId",
		    c.code "code",
		    IFNULL(ct.name, c.containerType) "containerType",
		    c.capacity "capacity",
		    c.sampleChangerLocation "sampleChangerLocation",
		    c.containerStatus "containerStatus",
		    c.blTimeStamp "blTimeStamp",
		    c.beamlineLocation "beamlineLocation",
		    c.screenId "screenId",
		    c.scheduleId "scheduleId",
		    c.barcode "barcode",
		    c.imagerId "imagerId",
		    c.sessionId "sessionId",
		    c.ownerId "ownerId",
		    c.requestedImagerId "requestedImagerId",
		    c.requestedReturn "requestedReturn",
		    c.comments "comments",
		    IFNULL(et.name, c.experimentType) "experimentType",
		    c.storageTemperature "storageTemperature",
		    c.containerRegistryId "containerRegistryId",
		    c.scLocationUpdated "scLocationUpdated",
		    c.priorityPipelineId "priorityPipelineId",
		    c.experimentTypeId "experimentTypeId",
		    c.containerTypeId "containerTypeId",
			p.proposalCode "proposalCode",
			p.proposalNumber "proposalNumber",
			bs.visitNumber "visitNumber"
		FROM Container c
		    INNER JOIN BLSession bs ON bs.sessionId = c.sessionId
		    INNER JOIN Proposal p ON p.proposalId = bs.proposalId
		    LEFT OUTER JOIN ContainerType ct ON ct.containerTypeId = c.containerTypeId
		    LEFT OUTER JOIN Person per2 ON per2.personId = c.ownerId
		    LEFT OUTER JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
		WHERE c.containerId = p_containerId AND per.login = p_authLogin;

	END IF;
    
    ELSE

	IF p_authLogin IS NOT NULL THEN

	    SELECT DISTINCT c.containerId "containerId",
		    c.dewarId "dewarId",
		    c.code "code",
		    IFNULL(ct.name, c.containerType) "containerType",
		    c.capacity "capacity",
		    c.sampleChangerLocation "sampleChangerLocation",
		    c.containerStatus "containerStatus",
		    c.blTimeStamp "blTimeStamp",
		    c.beamlineLocation "beamlineLocation",
		    c.screenId "screenId",
		    c.scheduleId "scheduleId",
		    c.barcode "barcode",
		    c.imagerId "imagerId",
		    NULL "sessionId",
		    c.ownerId "ownerId",
		    c.requestedImagerId "requestedImagerId",
		    c.requestedReturn "requestedReturn",
		    c.comments "comments",
		    IFNULL(et.name, c.experimentType) "experimentType",
		    c.storageTemperature "storageTemperature",
		    c.containerRegistryId "containerRegistryId",
		    c.scLocationUpdated "scLocationUpdated",
		    c.priorityPipelineId "priorityPipelineId",
		    c.experimentTypeId "experimentTypeId",
		    c.containerTypeId "containerTypeId",
			p.proposalCode "proposalCode",
			p.proposalNumber "proposalNumber",
			bs.visitNumber "visitNumber"
		FROM Container c
		    INNER JOIN Dewar d on d.dewarId = c.dewarId
		    INNER JOIN Shipping s ON s.shippingId = d.shippingId
		    INNER JOIN Proposal p ON p.proposalId = s.proposalId
		    INNER JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
		    INNER JOIN Session_has_Person shp ON shp.sessionId = shp.bs2.sessionId
		    INNER JOIN Person per on per.personId = shp.personId
		    LEFT OUTER JOIN ContainerType ct ON ct.containerTypeId = c.containerTypeId
		    LEFT OUTER JOIN Person per2 ON per2.personId = c.ownerId
		    LEFT OUTER JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
		WHERE c.containerId = p_containerId AND per.login = p_authLogin;
	
	ELSE

		SELECT DISTINCT c.containerId "containerId",
		    d.dewarId "dewarId",
		    c.code "code",
		    IFNULL(ct.name, c.containerType) "containerType",
		    c.capacity "capacity",
		    c.sampleChangerLocation "sampleChangerLocation",
		    c.containerStatus "containerStatus",
		    c.blTimeStamp "blTimeStamp",
		    c.beamlineLocation "beamlineLocation",
		    c.screenId "screenId",
		    c.scheduleId "scheduleId",
		    c.barcode "barcode",
		    c.imagerId "imagerId",
		    NULL "sessionId",
		    c.ownerId "ownerId",
		    c.requestedImagerId "requestedImagerId",
		    c.requestedReturn "requestedReturn",
		    c.comments "comments",
		    IFNULL(et.name, c.experimentType) "experimentType",
		    c.storageTemperature "storageTemperature",
		    c.containerRegistryId "containerRegistryId",
		    c.scLocationUpdated "scLocationUpdated",
		    c.priorityPipelineId "priorityPipelineId",
		    c.experimentTypeId "experimentTypeId",
		    c.containerTypeId "containerTypeId",
			p.proposalCode "proposalCode",
			p.proposalNumber "proposalNumber",
			bs.visitNumber "visitNumber"
		FROM Container c
		    INNER JOIN Dewar d on d.dewarId = c.dewarId
		    INNER JOIN Shipping s ON s.shippingId = d.shippingId
		    INNER JOIN Proposal p ON p.proposalId = s.proposalId
		    LEFT OUTER JOIN ContainerType ct ON ct.containerTypeId = c.containerTypeId
		    LEFT OUTER JOIN Person per2 ON per2.personId = c.ownerId
		    LEFT OUTER JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
		WHERE c.containerId = p_containerId;
	END IF;

    END IF;

    ELSE
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	    MESSAGE_TEXT='Mandatory argument p_containerId can not be NULL';
    END IF;

END;;
DELIMITER ;
