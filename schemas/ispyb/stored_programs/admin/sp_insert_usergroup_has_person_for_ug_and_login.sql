DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE insert_usergroup_has_person_for_ug_and_login(p_ug_name varchar(31), p_login varchar(45))
  MODIFIES SQL DATA
  COMMENT 'Inserts a row in UserGroup_has_Person corresponding to the Person login and the UserGroup name provided.
Mandatory columns: p_usergroup, p_login
Returns: Nothing.'
BEGIN
  IF p_ug_name IS NOT NULL AND p_login IS NOT NULL THEN
    INSERT INTO UserGroup_has_Person (userGroupId, personId)
      SELECT u.userGroupId, p.personId
      FROM UserGroup u, Person p
      WHERE u.name = p_ug_name AND p.login = p_login;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) is/are NULL: p_ug_name and p_login must be non-NULL.';
  END IF;
END;;
DELIMITER ;
