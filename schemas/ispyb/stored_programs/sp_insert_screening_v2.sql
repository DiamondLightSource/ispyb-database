-- To test:
-- SET @id = NULL;
-- CALL insert_screening_v2(@id, NULL, 6017416, 'EDNA MXv1', 'EDNAStrategy2', 'Standard Anomalous Dataset Multiplicity=3 I/sig=2 Maxlifespan=4034 s', 56986688);

DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_screening_v2`(
     OUT p_id int(11) unsigned,
     p_dcgId int(11) unsigned,
     p_dcId int(11) unsigned,
     p_programVersion varchar(45),
     p_shortComments varchar(20),
     p_comments varchar(255),
     p_autoProcProgramId int(10) unsigned
)
MODIFIES SQL DATA
COMMENT 'Insert a row with info about a screening. Returns the ID in p_id.'
BEGIN
    IF p_dcgId IS NULL AND p_dcId IS NOT NULL THEN
		    SELECT dataCollectionGroupId INTO p_dcgId FROM DataCollection WHERE dataCollectionId = p_dcId;
    END IF;

    INSERT INTO Screening (dataCollectionGroupId, dataCollectionId, programVersion, shortComments, comments, autoProcProgramId)
        VALUES (p_dcgId, p_dcId, p_programVersion, p_shortComments, p_comments, p_autoProcProgramId);

	  IF LAST_INSERT_ID() <> 0 THEN
		  SET p_id = LAST_INSERT_ID();
      END IF;

END;;
DELIMITER ;
