DELIMITER ;;

CREATE OR REPLACE PROCEDURE upsert_sleeve(INOUT p_id tinyint unsigned, p_location tinyint unsigned, p_lastMovedToFreezer datetime, p_lastMovedFromFreezer datetime)
BEGIN
  IF NOT (p_id IS NULL) THEN
    INSERT INTO Sleeve (sleeveId, location, lastMovedToFreezer, lastMovedFromFreezer) VALUES (p_id, p_location, p_lastMovedToFreezer, p_lastMovedFromFreezer)
    ON DUPLICATE KEY UPDATE
		  location = IFNULL(p_location, location),
      lastMovedToFreezer = IFNULL(p_lastMovedToFreezer, lastMovedToFreezer),
      lastMovedFromFreezer = IFNULL(p_lastMovedFromFreezer, lastMovedFromFreezer);

  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_id must be non-NULL.';

  END IF;
END;;

DELIMITER ;
