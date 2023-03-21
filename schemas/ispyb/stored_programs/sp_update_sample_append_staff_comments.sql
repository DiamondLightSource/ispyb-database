DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_sample_append_staff_comments`(
  p_id int(11) unsigned,
  p_staffComments varchar(1024),
  p_separator varchar(5)
)
MODIFIES SQL DATA
COMMENT 'Appends text to BLSample.staffComments for blSampleId=p_id. '
BEGIN
  IF NOT (p_id IS NULL) AND NOT (p_staffComments IS NULL) THEN

    UPDATE BLSample
    SET staffComments = concat_ws(p_separator, staffComments, p_staffComments)
    WHERE blSampleId = p_id;

  ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id and/or p_staffComments are NULL';
  END IF;
END;;
DELIMITER ;
