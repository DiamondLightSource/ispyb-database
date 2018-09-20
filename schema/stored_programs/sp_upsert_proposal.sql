DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_proposal`(
	 INOUT p_id int(11) unsigned,
	 p_personId int(11) unsigned,
	 p_title varchar(200),
	 p_proposalCode varchar(45),
	 p_proposalNumber int(11) unsigned,
	 p_proposalType varchar(2),
   p_externalPkUUID varchar(32)
 )
	 MODIFIES SQL DATA
	 COMMENT 'Inserts or updates info about a proposal (p_id).\nMandatory columns:\nFor insert: p_personId AND p_proposalCode AND p_proposalNumber\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN

IF p_id IS NOT NULL OR (p_personId IS NOT NULL AND p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL)  THEN

  INSERT INTO Proposal (proposalId, personId, title, proposalCode, proposalNumber, proposalType, externalId)
    VALUES (p_id, p_personId, p_title, p_proposalCode, p_proposalNumber, p_proposalType, unhex(p_externalPkUUID))
    ON DUPLICATE KEY UPDATE
      personId = IFNULL(p_personId, personId),
      title = IFNULL(p_title, title),
      proposalCode = IFNULL(p_proposalCode, proposalCode),
      proposalNumber = IFNULL(p_proposalNumber, proposalNumber),
      proposalType = IFNULL(p_proposalType, proposalType),
      externalId = IFNULL(unhex(p_externalPkUUID), externalId);

  IF p_id IS NULL THEN
    SET p_id = LAST_INSERT_ID();
  END IF;
ELSE
  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument(s) are NULL: p_id OR (p_personId AND p_proposalCode AND p_proposalNumber) must be non-NULL.';
END IF;

END;;
DELIMITER ;
