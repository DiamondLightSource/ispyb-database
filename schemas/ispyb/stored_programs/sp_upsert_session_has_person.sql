DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_session_has_person`(
         p_sessionId int(10) unsigned,
         p_personId int(10) unsigned,
         p_role varchar(100),
         p_remote tinyint(1)
 )
         MODIFIES SQL DATA
         COMMENT 'Inserts or updates info about a session - person association (p_sessionId, p_personId).\nMandatory columns:\nFor insert: p_sessionId, p_personId\nFor update: p_sessionId, p_personId\nReturns: Nothing.'
BEGIN
        IF p_sessionId IS NOT NULL AND p_personId IS NOT NULL THEN
                INSERT INTO Session_has_Person(sessionId, personId, `role`, remote)
                        VALUES (p_sessionId, p_personId, p_role, p_remote)
                        ON DUPLICATE KEY UPDATE
                                `role` = IFNULL(p_role, `role`),
                                remote = IFNULL(p_remote, remote);
        ELSE
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_sessionId AND p_personId must be non-NULL.';
        END IF;
END;;
DELIMITER ;

