DELIMITER ;;

CREATE OR REPLACE PROCEDURE retrieve_sleeve(p_id tinyint unsigned)
BEGIN
  IF NOT (p_id IS NULL) THEN
    SELECT sleeveId "id", location "location", lastMovedToFreezer "lastMovedToFreezer", lastMovedFromFreezer "lastMovedFromFreezer"
    FROM Sleeve
    WHERE sleeveId = p_id;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_id must be non-NULL.';

  END IF;
END;;

DELIMITER ;
