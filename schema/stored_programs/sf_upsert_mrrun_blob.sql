
DELIMITER $$
CREATE OR REPLACE FUNCTION `upsert_mrrun_blob` (
     p_Id integer,
     p_parentId integer,
     p_view1 varchar(255), 
     p_view2 varchar(255), 
     p_view3 varchar(255) 
  ) RETURNS integer 
  BEGIN
    INSERT INTO MXMRRunBlob (mxMRRunBlobId, mxMRRunId, view1, view2, view3) 
		VALUES (p_id, p_parentId, p_view1, p_view2, p_view3)
		ON DUPLICATE KEY UPDATE
			mxMRRunId = IFNULL(p_parentId, mxMRRunId),
			view1 = IFNULL(p_view1, view1),
			view2 = IFNULL(p_view2, view2),
			view3 = IFNULL(p_view3, view3);

	IF p_id IS NULL THEN 
		RETURN LAST_INSERT_ID();
    ELSE 
		RETURN p_id;
    END IF;
  END$$
DELIMITER ;

