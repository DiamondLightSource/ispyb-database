DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening`(
     OUT p_id int(11) unsigned,
     p_dcgId int(11) unsigned,
     p_dcId int(11) unsigned,
     p_programVersion varchar(45),
     p_shortComments varchar(20),
     p_comments varchar(255)
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening. Returns the ID in p_id.'
BEGIN
	  IF p_dcgId IS NULL AND p_dcId IS NOT NULL THEN
		SELECT dataCollectionGroupId INTO p_dcgId FROM DataCollection WHERE dataCollectionId = p_dcId;
	  END IF;
      
      INSERT INTO Screening (dataCollectionGroupId, dataCollectionId, programVersion, shortComments, comments) 
        VALUES (IFNULL(p_dcgId, (SELECT dataCollectionGroupId FROM DataCollection WHERE dataCollectionId = p_dcId)), p_dcId, p_programVersion, p_shortComments, p_comments);

	  IF LAST_INSERT_ID() <> 0 THEN 
		  SET p_id = LAST_INSERT_ID();
      END IF;      

END;;
DELIMITER ;
