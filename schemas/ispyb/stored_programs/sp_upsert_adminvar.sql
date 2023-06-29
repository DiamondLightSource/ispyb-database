-- Example call:
-- SET @id := NULL;
-- CALL upsert_adminvar(@id, 'appGreetingMessage', 'Hello and welcome to App!');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_adminvar`(
  p_name varchar(32),
  p_value varchar(1024)
)
    MODIFIES SQL DATA
BEGIN
    DECLARE row_varId int(11) DEFAULT NULL;
    DECLARE row_value varchar(1024) DEFAULT NULL;

    START TRANSACTION;
    SELECT varId, `value`
      INTO row_varId, row_value
      FROM AdminVar
      WHERE `name` = p_name;

    IF row_varId IS NULL THEN
      INSERT INTO AdminVar (`name`, `value`)
        VALUES (p_name, p_value);
    ELSE
      UPDATE AdminVar SET `value` = p_value WHERE `name` = p_name;
    END IF;
    COMMIT;
END ;;
DELIMITER ;
