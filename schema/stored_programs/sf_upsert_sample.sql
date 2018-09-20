-- Example call:
-- select upsert_sample(NULL, 39, NULL, 'KL-sample-03','KL', '3', NULL, NULL, NULL, NULL, 'Karl\'s test', NULL, False);
-- tested OK

DELIMITER $$
CREATE OR REPLACE FUNCTION `upsert_sample` (
	 p_id int(10) unsigned,
	 p_crystalId int(10) unsigned,
     p_containerId int(10) unsigned, 
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
RETURNS INT
MODIFIES SQL DATA
BEGIN
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
		RETURN LAST_INSERT_ID();
    ELSE 
		RETURN p_id;
    END IF;
END$$
DELIMITER ;
