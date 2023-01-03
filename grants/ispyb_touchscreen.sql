-- Create the touchscreen application role.
CREATE ROLE IF NOT EXISTS ispyb_touchscreen;

GRANT SELECT ON Proposal TO ispyb_touchscreen;
GRANT SELECT ON BLSession TO ispyb_touchscreen;
GRANT SELECT ON DataCollectionGroup TO ispyb_touchscreen;
GRANT SELECT ON DataCollection TO ispyb_touchscreen;
GRANT SELECT ON Shipping TO ispyb_touchscreen;
GRANT SELECT ON Dewar TO ispyb_touchscreen;
GRANT SELECT ON DewarTransportHistory TO ispyb_touchscreen;
GRANT SELECT ON Container TO ispyb_touchscreen;
GRANT SELECT ON Protein TO ispyb_touchscreen;
GRANT SELECT ON Crystal TO ispyb_touchscreen;
GRANT SELECT ON BLSample TO ispyb_touchscreen;
GRANT SELECT ON RobotAction TO ispyb_touchscreen;
GRANT SELECT ON ContainerQueue TO ispyb_touchscreen;
GRANT SELECT ON DiffractionPlan TO ispyb_touchscreen;
GRANT SELECT ON ContainerRegistry TO ispyb_touchscreen;
GRANT SELECT ON ContainerRegistry_has_Proposal TO ispyb_touchscreen;
GRANT SELECT ON LabContact TO ispyb_touchscreen;
GRANT SELECT ON Person TO ispyb_touchscreen;
GRANT SELECT ON Session_has_Person TO ispyb_touchscreen;
GRANT SELECT ON ImageQualityIndicators TO ispyb_touchscreen;
GRANT SELECT ON Laboratory TO ispyb_touchscreen;
GRANT SELECT ON BLSampleGroup TO ispyb_touchscreen;
GRANT SELECT ON BLSampleGroup_has_BLSample TO ispyb_touchscreen;

GRANT EXECUTE ON PROCEDURE update_container_session_id TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_dc_plans TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_container_assign TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_container_unassign_all_for_beamline TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_container_current_dewar_id TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_container_dispose TO ispyb_touchscreen;
GRANT EXECUTE ON PROCEDURE update_dewar_comments_json_merge TO ispyb_touchscreen;
