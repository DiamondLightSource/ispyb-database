DELIMITER ;;

CREATE OR REPLACE PROCEDURE retrieve_sleeves()
BEGIN
    SELECT sleeveId "id", location "location", lastMovedToFreezer "lastMovedToFreezer", lastMovedFromFreezer "lastMovedFromFreezer"
    FROM Sleeve;
END;;

DELIMITER ;
