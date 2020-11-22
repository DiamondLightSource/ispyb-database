DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_person`(
         INOUT p_id int(10) unsigned,
         p_laboratoryId int(10) unsigned,
         p_familyName varchar(100),
         p_givenName varchar(45),
         p_title varchar(45),
         p_emailAddress varchar(60),
         p_phoneNumber varchar(45),
         p_login varchar(45),
         p_externalPkId int(11) unsigned,
         p_externalPkUUID varchar(32)
 )
         MODIFIES SQL DATA
         COMMENT 'Inserts or updates info about a person (p_id).\nMandatory columns:\nFor insert: login\nFor update: p_id \nReturns: Record ID in p_id.'
BEGIN
        IF p_id is NOT NULL THEN
                UPDATE Person SET
                                        laboratoryId = IFNULL(p_laboratoryId, laboratoryId),
                                        familyName = IFNULL(p_familyName, familyName),
                                        givenName = IFNULL(p_givenName, givenName),
                                        title = IFNULL(p_title, title),
                                        emailAddress = IFNULL(p_emailAddress, emailAddress),
                                        phoneNumber = IFNULL(p_phoneNumber, phoneNumber),
                                        login = IFNULL(p_login, login),
                                        siteId = IFNULL(p_externalPkId, siteId),
                                        externalId = IFNULL(p_externalPkUUID, externalId)
                WHERE personId = p_id;
        ELSEIF p_login IS NOT NULL THEN
        INSERT INTO Person(personId, laboratoryId, familyName, givenName, title, emailAddress, phoneNumber, login, siteId, externalId)
                  VALUES (p_id, p_laboratoryId, p_familyName, p_givenName, p_title, p_emailAddress, p_phoneNumber, p_login, p_externalPkId, p_externalPkUUID);

                SET p_id = LAST_INSERT_ID();
        ELSE
                SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_id OR p_login must be non-NULL.';
        END IF;
END;;
DELIMITER ;

