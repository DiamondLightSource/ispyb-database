/* Tests:
CALL retrieve_scm_container(34888, False, NULL)\G
CALL retrieve_scm_container(34888, False, 'boaty')\G
CALL retrieve_scm_container(34888, True, NULL)\G
CALL retrieve_scm_container(34888, True, 'boaty')\G
*/

DELIMITER ;;

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_scm_container`(p_id int unsigned, p_useContainerSession boolean, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the container for the given ID'
BEGIN

    IF p_id IS NOT NULL THEN

      IF p_useContainerSession = True THEN

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT c.containerId "containerId",
            c.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            -- what about owner login, givenName, familyName ????
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
            c.experimentType "experimentType"
          FROM Container c
            JOIN BLSession bs ON bs.sessionId = c.sessionId
            JOIN Proposal p ON p.proposalId = bs.proposalId
            JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            JOIN Session_has_Person shp ON shp.sessionId = bs2.sessionId
            JOIN Person per on per.personId = shp.personId
          WHERE c.containerId = p_id AND per.login = p_authLogin;

        ELSE

          SELECT c.containerId "containerId",
            c.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            -- what about owner login, givenName, familyName ????
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
            c.experimentType "experimentType"
          FROM Container c
            JOIN BLSession bs ON bs.sessionId = c.sessionId
            JOIN Proposal p ON p.proposalId = bs.proposalId
          WHERE c.containerId = p_id;
          


        END IF;

      ELSE

        IF p_authLogin IS NOT NULL THEN
        -- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

          SELECT DISTINCT c.containerId "containerId",
            d.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            -- what about owner login, givenName, familyName ????
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
            c.experimentType "experimentType"
          FROM Container c
            JOIN Dewar d ON c.dewarId = d.dewarId
            JOIN Shipping s ON s.shippingId = d.shippingId
            JOIN Proposal p ON p.proposalId = s.proposalId
            JOIN BLSession bs2 ON bs2.proposalId = p.proposalId
            JOIN Session_has_Person shp ON shp.sessionId = bs2.sessionId
            JOIN Person per on per.personId = shp.personId
          WHERE c.containerId = p_id AND per.login = p_authLogin;

        ELSE

          SELECT c.containerId "containerId",
            d.dewarId "dewarId",
            c.sessionId "sessionId",
            p.proposalId "proposalId",
            c.ownerId "ownerId",
            -- what about owner login, givenName, familyName ????
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
            c.experimentType "experimentType"
          FROM Container c
            JOIN Dewar d ON c.dewarId = d.dewarId
            JOIN Shipping s ON s.shippingId = d.shippingId
            JOIN Proposal p ON p.proposalId = s.proposalId
          WHERE c.containerId = p_id;

        END IF;

      END IF;

    ELSE
      SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
  END IF;

END;;

DELIMITER ;