-- Example call:
-- SET @id = NULL;
-- CALL upsert_sample(@id, 'boaty', NULL, 34888, 'KL-sample-04','KL', '4', NULL, NULL, NULL, NULL, 'Karl\'s test', NULL, False);
-- tested OK

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_sample` (
	 INOUT p_id int(10) unsigned,
     p_authLogin varchar(45), 
	   p_crystalId int(10) unsigned,
     p_containerId int(10) unsigned, -- mandatory
     p_name varchar(45),
     p_code varchar(45),
     p_location varchar(45),
     p_holderLength float, 
     p_loopLength float, 
     p_loopType varchar(45), 
     p_wireWidth float, 
     p_comments varchar(1024),
     p_blSampleStatus varchar(20),
     p_isInSampleChanger boolean 
)
MODIFIES SQL DATA
COMMENT 'Inserts or updates info about sample (p_id).'
BEGIN

  DECLARE row_count int unsigned DEFAULT 0;
  DECLARE row_count2 int unsigned DEFAULT 0;

  IF p_authLogin IS NOT NULL AND (p_containerId IS NOT NULL OR p_id IS NOT NULL) THEN

    -- Authorise only if the person (p_authLogin) is a member of a session on the proposal of the shipping that the sample belongs to.
    -- If the sample doesn't have a container, or the container doesn't have a dewar etc. this will fail.

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

  IF p_containerId IS NOT NULL OR p_id IS NOT NULL THEN

    INSERT INTO BLSample (blsampleId, crystalId, containerId, `name`, code, `location`, holderLength, loopLength, loopType, wireWidth, comments, blSampleStatus, isInSampleChanger)
      VALUES (p_id, p_crystalId, p_containerId, p_name, p_code, p_location, p_holderLength, p_loopLength, p_loopType, p_wireWidth, p_comments, p_blSampleStatus, p_isInSampleChanger)
      ON DUPLICATE KEY UPDATE
		    crystalId = IFNULL(p_crystalId, crystalId),
        containerId = IFNULL(p_containerId, containerId), 
        `name` = IFNULL(p_name, `name`), 
        `code` = IFNULL(p_code, `code`), 
        location = IFNULL(p_location, location), 
        holderLength = IFNULL(p_holderLength, holderLength), 
        loopLength = IFNULL(p_loopLength, loopLength), 
        wireWidth = IFNULL(p_wireWidth, wireWidth), 
        comments = IFNULL(p_comments, comments), 
        blSampleStatus = IFNULL(p_blSampleStatus, blSampleStatus), 
        isInSampleChanger = IFNULL(p_isInSampleChanger, isInSampleChanger);

    IF p_id IS NULL THEN 
	    SET p_id = LAST_INSERT_ID();
    END IF;

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_id or p_containerId must be non-NULL.';

  END IF;
END  ;;
DELIMITER ;
