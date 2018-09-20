DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` FUNCTION `root_replace`(
    p_str varchar(255), 
    p_oldroot varchar(255), 
    p_newroot varchar(255)) 
    RETURNS varchar(255) CHARSET latin1
    CONTAINS SQL
    COMMENT 'Returns a varchar where the old root p_oldroot (the leftmost part) of p_str has been replaced with a new root p_newroot'
BEGIN
 DECLARE path_len smallint unsigned DEFAULT LENGTH(p_oldroot);
 RETURN CASE WHEN LEFT(p_str, path_len) = BINARY p_oldroot THEN CONCAT(p_newroot, SUBSTRING(p_str, path_len + 1)) ELSE p_str END; 
END;;

DELIMITER ;