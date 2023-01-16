DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_dc_append_comments`(
  p_id int(11) unsigned,
  p_comments varchar(1024),
  p_separator varchar(5)
)
MODIFIES SQL DATA
COMMENT 'Appends text to DataCollection.comments for dataCollectionId=p_id. '
BEGIN
  IF NOT (p_id IS NULL) AND NOT (p_comments IS NULL) THEN

    UPDATE DataCollection 
    SET comments = concat_ws(p_separator, comments, p_comments) 
    WHERE dataCollectionId = p_id; 

  ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id and/or p_comments are NULL';
  END IF;
END;;
DELIMITER ;
