DELIMITER ;;
CREATE TRIGGER Container_sc_loc_update BEFORE UPDATE ON Container
FOR EACH ROW
BEGIN
    IF IFNULL(NEW.sampleChangerLocation, -999) <> IFNULL(OLD.sampleChangerLocation, -999) THEN
        SET NEW.scLocationUpdated = now();
    END IF;
END;;
DELIMITER ;
