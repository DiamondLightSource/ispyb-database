DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_proposal_has_person`(
         INOUT p_id int(10) unsigned,
         p_proposalId int(10) unsigned,
         p_personId int(10) unsigned,
         p_role varchar(100)
 )
         MODIFIES SQL DATA
         COMMENT 'Inserts or updates info about a proposal - person association (p_id).\nMandatory columns:\nFor insert: p_proposalId, p_personId\nFor update: p_id\nReturns: Record ID in p_id.'
BEGIN
        IF p_id IS NOT NULL OR (p_proposalId IS NOT NULL AND p_personId IS NOT NULL) THEN
                INSERT INTO ProposalHasPerson(proposalId, personId, `role`)
                        VALUES (p_proposalId, p_personId, p_role)
                        ON DUPLICATE KEY UPDATE
                                `role` = IFNULL(p_role, `role`);

                IF p_id IS NULL THEN
                        SET p_id = LAST_INSERT_ID();
                END IF;

        ELSE
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR (p_proposalId AND p_personId) must be non-NULL.';
        END IF;
END;;
DELIMITER ;

