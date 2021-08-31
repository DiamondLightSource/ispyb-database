-- Test:
/*

SET @id := 582;
SET @json := '{"hdd":1,"tools":0,"tBarMissing":0,"ventDamaged":0,"foamPlugMissing":0,"warm":0}';
CALL update_dewar_comments_json_merge(@id, @json);
SELECT dewarId, comments FROM Dewar WHERE dewarId = @id;

SET @json := '{"check":{"date":"20210803T135321","location":"i03"}}';
CALL update_dewar_comments_json_merge(@id, @json);
SELECT dewarId, comments FROM Dewar WHERE dewarId = @id;

*/ 

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_dewar_comments_json_merge`(
  IN p_id int(10) unsigned,
  p_comments JSON
)
  MODIFIES SQL DATA
  COMMENT 'Merges in additional JSON into the comments column on a dewar/parcel (p_id).\nMandatory columns: p_id \nReturns: Nothing'
BEGIN
  IF p_id IS NOT NULL THEN
    IF JSON_VALID(p_comments) THEN
      UPDATE Dewar
        SET comments = JSON_MERGE_PRESERVE(IFNULL(comments, '{}'), p_comments)
      WHERE dewarId = p_id;
    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_comments is invalid JSON';
    END IF;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id is NULL';
  END IF;
END;;
DELIMITER ;
