-- Create the processing application role.
CREATE ROLE IF NOT EXISTS ispyb_acquisition;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER gda@'%' IDENTIFIED BY 'the_gda_password';
-- GRANT ispyb_acquisition to gda@'%';
-- SET DEFAULT ROLE ispyb_acquisition FOR gda@'%';

-- Grants for ispyb_acquisition
GRANT SELECT ON `AdminVar` TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE retrieve_test TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_ls_position TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_info TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_on_gonio TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE update_container_ls_position TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE update_container_status TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_containers_on_beamline_with_status TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE finish_container TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_ls_queue TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_queue_timestamp TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_queue_most_recent_completed_timestamp TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_container_subsamples TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE insert_container_error TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE clear_container_error TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE retrieve_session_id TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_dc_infos_for_subsample TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_dc_group TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_dc_main TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE update_dc_experiment TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE update_dc_machine TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_sample_image_analysis TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_dcg_grid TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_dc_grid TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE update_dc_position TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE `update_dc_experiment_v2` TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE `upsert_dc_main_v2` TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE `upsert_dc_main_v3` TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE `upsert_dc_group_v2` TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE `retrieve_container_subsamples_v2` TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE upsert_dc_group_v3 TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_dc_group TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_dc_group_v2 TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE retrieve_sleeve TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE retrieve_sleeves TO 'ispyb_acquisition';
GRANT EXECUTE ON PROCEDURE upsert_sleeve TO 'ispyb_acquisition';

GRANT EXECUTE ON PROCEDURE retrieve_sample TO 'ispyb_acquisition';


CREATE ROLE IF NOT EXISTS ispyb_gda_scm;

GRANT EXECUTE ON PROCEDURE retrieve_scm_sample TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_scm_sample_for_container_barcode_and_location TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_scm_samples_for_container_id TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_scm_container TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_scm_container_for_barcode TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_scm_containers_for_session TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_detector TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE upsert_dc_group_v3 TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_dc_group TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE retrieve_dc_group_v2 TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE upsert_dc_main_v3 TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE update_dc_experiment_v2 TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE update_dc_machine TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE upsert_dcg_grid TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE upsert_dc_grid TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE update_dc_position TO ispyb_gda_scm;
GRANT EXECUTE ON PROCEDURE insert_beamline_action TO ispyb_gda_scm;

CREATE ROLE IF NOT EXISTS ispyb_gda_mxcx;

GRANT EXECUTE ON PROCEDURE insert_aperture TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE insert_crystal TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE insert_dc_plan TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE insert_position TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_apertures_using_size TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_container TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_dcs_for_sample TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_quality_indicators TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_robot_actions_for_sample TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_screenings_for_sample TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_xfe_fluo_ids_for_sample TO ispyb_gda_mxcx;
GRANT EXECUTE ON PROCEDURE retrieve_dc TO ispyb_gda_mxcx;

