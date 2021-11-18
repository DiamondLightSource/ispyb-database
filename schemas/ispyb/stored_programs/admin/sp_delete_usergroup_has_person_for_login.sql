DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE delete_usergroup_has_person_for_login(p_login varchar(45))
  MODIFIES SQL DATA
  COMMENT 'Deletes all rows from UserGroup_has_Person for personId corresponding to the Person login provided.
Mandatory columns: p_login
Returns: Nothing.'
BEGIN
  IF p_login IS NOT NULL THEN
    DELETE uhp
    FROM UserGroup_has_Person uhp
      INNER JOIN Person p ON uhp.personId = p.personId
    WHERE p.login = p_login;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_login must be non-NULL.';
  END IF;
END;;
DELIMITER ;
