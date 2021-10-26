DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_mx_sample`(
	INOUT p_sampleId int(10) unsigned,
	p_authLogin varchar(45),
	p_containerId int(10) unsigned,
	p_dataCollectionPlanId int(10) unsigned,
	p_crystalId int(10) unsigned,
	p_positionId int(10) unsigned,
	p_sampleName varchar(45),
	p_sampleCode varchar(45),
	p_sampleComments varchar(1024),
	p_publicationComments varchar(255),
	p_sampleLocation varchar(45),
	p_sampleSubLocation smallint(5) unsigned,
	p_isInSampleChanger tinyint(1),
	p_lastKnownCenteringPosition varchar(255),
	p_holderLength double,
	p_loopLength double,
	p_loopType varchar(45),
	p_wireWidth double,
	p_sampleStatus varchar(20),
	p_completionStage varchar(45),
	p_structureStage varchar(45),
	p_publicationStage varchar(45)
)
MODIFIES SQL DATA
COMMENT 'Inserts or updates info about a sample.'
BEGIN

	DECLARE row_count int unsigned DEFAULT 0;
	DECLARE row_count2 int unsigned DEFAULT 0;

	IF p_authLogin IS NOT NULL AND (p_containerId IS NOT NULL OR p_sampleId IS NOT NULL) THEN
	-- Authorise only if the person (p_authLogin) is a member of a session on the proposal of the shipping that the sample belings to.
	-- If the sample doesn't have a container, ot the container doesn't have a dewar then this will fail.

	SELECT count(*) INTO row_count
	FROM Container c
	  INNER JOIN Dewar d ON d.dewarId = c.dewarId
	  INNER JOIN Shipping s ON s.shippingId = d.shippingId
	  INNER JOIN BLSession bs ON bs.proposalId = s.proposalId
	  INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
	  INNER JOIN Person p ON p.personId = shp.personId
	WHERE p.login = p_authLogin AND c.containerId = p_containerId;
	
	IF row_count = 0 THEN
	
	SELECT count(*) INTO row_count2
	FROM Container c
	  INNER JOIN BLSession bs ON bs.sessionId = c.sessionId
	  INNER JOIN BLSession bs2 ON bs.proposalId = bs2.proposalId
	  INNER JOIN Session_has_Person shp ON bs2.sessionId = shp.sessionId
	  INNER JOIN Person p ON p.personId = shp.personId
	WHERE p.login = p_authLogin AND c.containerId = p_containerId;

	IF row_count2 = 0 THEN
		SIGNAL SQLSTATE '02000'
		  SET MYSQL_ERRNO=1643, MESSAGE_TEXT = 'Sample not in a container belonging to one of the p_authLogin Person sessions';
	END IF;
	END IF;
	END IF;

IF p_containerId IS NOT NULL OR p_sampleId IS NOT NULL THEN

	INSERT INTO BLSample (blSampleId, containerId, diffractionPlanId, crystalId,
		POSITIONID, name, code, comments, publicationComments, location,
		subLocation, isInSampleChanger, lastKnownCenteringPosition,
		holderLength, loopLength, loopType, wireWidth, blSampleStatus,
		completionStage, structureStage, publicationStage)
	VALUES (p_sampleId, p_containerId, p_dataCollectionPlanId, p_crystalId,
		p_positionId, p_sampleName, p_sampleCode, p_sampleComments, p_publicationComments,
		p_sampleLocation, p_sampleSubLocation, p_isInSampleChanger,
		p_lastKnownCenteringPosition, p_holderLength, p_loopLength,
		p_loopType, p_wireWidth, p_sampleStatus, p_completionStage,
		p_structureStage, p_publicationStage)
	ON DUPLICATE KEY UPDATE
		containerId = IFNULL(p_containerId, containerId),
		diffractionPlanId = IFNULL(p_dataCollectionPlanId, diffractionPlanId),
		crystalId = IFNULL(p_crystalId, crystalId),
		POSITIONID = IFNULL(p_positionId, POSITIONID),
		`name` = IFNULL(p_sampleName, `name`),
		`code` = IFNULL(p_sampleCode, `code`),
		comments = IFNULL(p_sampleComments, comments),
		publicationComments = IFNULL(p_publicationComments, publicationComments),
		location = IFNULL(p_sampleLocation, location),
		subLocation = IFNULL(p_sampleSubLocation, subLocation),
		isInSampleChanger = IFNULL(p_isInSampleChanger, isInSampleChanger),
		lastKnownCenteringPosition = IFNULL(p_lastKnownCenteringPosition, lastKnownCenteringPosition),
		holderLength = IFNULL(p_holderLength, holderLength),
		loopLength = IFNULL(p_loopLength, loopLength),
		loopType = IFNULL(p_loopType, loopType),
		wireWidth = IFNULL(p_wireWidth, wireWidth),
		blSampleStatus = IFNULL(p_sampleStatus, blSampleStatus),
		completionStage = IFNULL(p_completionStage, completionStage),
		structureStage = IFNULL(p_structureStage, structureStage),
		publicationStage = IFNULL(p_publicationStage, publicationStage);

	IF p_sampleId IS NULL THEN
		SET p_sampleId = LAST_INSERT_ID();
	END IF;

ELSE
	SIGNAL SQLSTATE '45000'
		SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_sampleId or p_containerId must be non-NULL.';

  END IF;
END ;;
DELIMITER ;
