/* Tests:
CALL retrieve_scm_containers_for_session('cm', '14451', NULL, 'in_storage', NULL)\G
CALL retrieve_scm_containers_for_session('cm', '14451', NULL, 'in_storage', 'boaty')\G
CALL retrieve_scm_containers_for_session('cm', '14451', 99, 'in_storage', NULL)\G
CALL retrieve_scm_containers_for_session('cm', '14451', 99, 'in_storage', 'boaty')\G
*/

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_scm_containers_for_session`(
  p_proposalCode varchar(45),
  p_proposalNumber varchar(45),
  p_sessionNumber int unsigned,
  p_status varchar(45),
  p_authLogin varchar(45)
) 
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the containers for the given session defined by proposal code, proposal number and session number'
BEGIN

    IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL THEN

      IF p_sessionNumber IS NOT NULL THEN

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT c.containerId "containerId",
            c.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            per2.login "ownerUsername",
            c.code "name",
            c.containerType "type",
            c.barcode "barcode",
            c.beamlineLocation "beamline",
            c.sampleChangerLocation "location",
            c.containerStatus "status",
            c.capacity "capacity",
            c.storageTemperature "storageTemperature",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.visit_number "sessionNumber",
            
            c.comments "comments",
            et.name "experimentType"
          FROM Container c
            JOIN BLSession bs ON bs.sessionId = c.sessionId
            JOIN Proposal p ON p.proposalId = bs.proposalId
            JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            JOIN Session_has_Person shp ON shp.sessionId = bs2.sessionId
            JOIN Person per on per.personId = shp.personId
            LEFT JOIN Person per2 ON per2.personId = c.ownerId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
          WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber AND c.containerStatus = p_status AND per.login = p_authLogin;

        ELSE

          SELECT c.containerId "containerId",
            c.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            per2.login "ownerUsername",
            c.code "name",
            c.containerType "type",
            c.barcode "barcode",
            c.beamlineLocation "beamline",
            c.sampleChangerLocation "location",
            c.containerStatus "status",
            c.capacity "capacity",
            c.storageTemperature "storageTemperature",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            bs.visit_number "sessionNumber",
            
            c.comments "comments",
            et.name "experimentType"
          FROM Container c
            JOIN BLSession bs ON bs.sessionId = c.sessionId
            JOIN Proposal p ON p.proposalId = bs.proposalId
            LEFT JOIN Person per2 ON per2.personId = c.ownerId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
          WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber AND c.containerStatus = p_status;


        END IF;

      ELSE

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT c.containerId "containerId",
            d.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            per2.login "ownerUsername",
            c.code "name",
            c.containerType "type",
            c.barcode "barcode",
            c.beamlineLocation "beamline",
            c.sampleChangerLocation "location",
            c.containerStatus "status",
            c.capacity "capacity",
            c.storageTemperature "storageTemperature",
            
            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionNumber",
            
            c.comments "comments",
            et.name "experimentType"
          FROM Container c
            JOIN Dewar d ON c.dewarId = d.dewarId
            JOIN Shipping s ON s.shippingId = d.shippingId
            JOIN Proposal p ON p.proposalId = s.proposalId
            JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            JOIN Session_has_Person shp ON shp.sessionId = bs2.sessionId
            JOIN Person per on per.personId = shp.personId
            LEFT JOIN Person per2 ON per2.personId = c.ownerId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
          WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND c.containerStatus = p_status AND per.login = p_authLogin;

        ELSE

          SELECT c.containerId "containerId",
            d.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            per2.login "ownerUsername",
            c.code "name",
            c.containerType "type",
            c.barcode "barcode",
            c.beamlineLocation "beamline",
            c.sampleChangerLocation "location",
            c.containerStatus "status",
            c.capacity "capacity",
            c.storageTemperature "storageTemperature",

            p.proposalCode "proposalCode",
            p.proposalNumber "proposalNumber",
            NULL "sessionNumber",

            c.comments "comments",
            et.name "experimentType"
          FROM Container c
            JOIN Dewar d ON c.dewarId = d.dewarId
            JOIN Shipping s ON s.shippingId = d.shippingId
            JOIN Proposal p ON p.proposalId = s.proposalId
            LEFT JOIN Person per2 ON per2.personId = c.ownerId
            LEFT JOIN ExperimentType et ON et.experimentTypeId = c.experimentTypeId
          WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND c.containerStatus = p_status;

        END IF;

      END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_proposalCode and p_proposalNumber can not be NULL';
  END IF;

END;;

DELIMITER ;