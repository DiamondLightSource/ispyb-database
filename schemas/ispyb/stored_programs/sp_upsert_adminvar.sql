-- Example call:
-- SET @id := NULL;
-- CALL upsert_adminvar(@id, 'appGreetingMessage', 'Hello and welcome to App!');

DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_adminvar`(
  INOUT p_id int(11),
  p_name varchar(32),
  p_value varchar(1024)
)
    MODIFIES SQL DATA
BEGIN
    INSERT INTO AdminVar (varId, `name`, `value`)
      VALUES (p_id, p_name, p_value)
      ON DUPLICATE KEY UPDATE
	  `name` = IFNULL(p_name, `name`),
    `value` = IFNULL(p_value, `value`);
  IF LAST_INSERT_ID() <> 0 THEN
	  SET p_id = LAST_INSERT_ID();
    END IF;
END ;;
DELIMITER ;
