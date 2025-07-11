-- Create the processing application role.
CREATE ROLE IF NOT EXISTS ispyb_processing;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER zocalo@'%' IDENTIFIED BY 'the_zocalo_password';
-- GRANT ispyb_processing to zocalo@'%';
-- SET DEFAULT ROLE ispyb_processing FOR zocalo@'%';

-- Grants for ispyb_processing
GRANT SELECT ON AdminVar TO 'ispyb_processing'; -- Hack TO allow ispyb_processing to connect through MaxScale
GRANT SELECT,INSERT ON ImageQualityIndicators TO 'ispyb_processing'; -- Needed for bulk insertion of aggregated IQIs
GRANT SELECT,INSERT,UPDATE ON BLSamplePosition TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON BLSampleImage TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON BLSampleImageAnalysis TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON BLSampleImage_has_AutoScoreClass TO 'ispyb_processing';
GRANT SELECT,INSERT ON PDB TO 'ispyb_processing';
GRANT SELECT,INSERT ON Protein_has_PDB TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON Container TO 'ispyb_processing';

GRANT SELECT,INSERT,UPDATE ON AutoProcProgram TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON AutoProcProgramAttachment TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON MXMRRun TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON MXMRRunBlob TO 'ispyb_processing';

GRANT SELECT,INSERT,UPDATE ON CryoemInitialModel TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON ParticleClassification TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON ParticleClassificationGroup TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON ParticlePicker TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON ParticleClassification_has_CryoemInitialModel TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON MotionCorrection TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON RelativeIceThickness TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON CTF TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON Movie TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON BFactorFit TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON DataCollectionFileAttachment TO 'ispyb_processing';

GRANT SELECT,INSERT,UPDATE ON Tomogram TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON ProcessedTomogram TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON TiltImageAlignment TO 'ispyb_processing';

GRANT SELECT,INSERT,UPDATE ON Atlas TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON GridSquare TO 'ispyb_processing';
GRANT SELECT,INSERT,UPDATE ON FoilHole TO 'ispyb_processing';

GRANT SELECT, INSERT, UPDATE ON ProcessingJob TO 'ispyb_processing';
GRANT SELECT, INSERT, UPDATE ON ProcessingJobParameter TO 'ispyb_processing';

GRANT SELECT, INSERT, UPDATE ON XrayCentring TO 'ispyb_processing';
GRANT SELECT, INSERT, UPDATE ON XrayCentringResult TO 'ispyb_processing';

GRANT EXECUTE ON FUNCTION retrieve_visit_id TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `retrieve_dc_main` TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_sample TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_dcgroup TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_dc TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_image TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_program_run TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_processing TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_integration TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION insert_scaling TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_mrrun TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION upsert_mrrun_blob TO 'ispyb_processing';
GRANT EXECUTE ON FUNCTION retrieve_proposal_title TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_dc_group_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_dc_group_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_dc_group_v3 TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE retrieve_current_sessions TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_current_cm_sessions TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_current_sessions_for_person TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_sessions_for_beamline_and_run TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_expired_sessions_for_instrument_and_period TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `retrieve_sessions_for_person_login` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `retrieve_persons_for_proposal` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_most_recent_session TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_containers_submitted_non_ls TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE `insert_screening` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE insert_screening_input TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_output` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_output_v2` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_output_lattice` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_strategy` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_strategy_wedge` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_screening_strategy_sub_wedge` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `update_container_assign` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE finish_container_for_id TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE `retrieve_reprocessing_by_dc` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `update_reprocessing_status` TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE `upsert_processing_program` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing_program_v2` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing_program_attachment` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_processing_program_attachment_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_processing_program_message TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_processing_scaling` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `insert_processing_scaling_v2` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing_integration` TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE `insert_quality_indicators` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_mrrun TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_mrrun_blob TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_quality_indicators TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_programs_for_job_id TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_program_attachments_for_dc_group_and_program TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_program_attachments_for_program_id TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE `upsert_processing_job` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing_job_parameter` TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE `upsert_processing_job_image_sweep` TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_movie TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_dewar TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_session_for_proposal_code_number TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_robot_action TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_fluo_mapping TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_fluo_mapping_roi TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_xfe_fluo_spectrum TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_energy_scan TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_dc_file_attachment TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_dewars_for_proposal_code_number TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_person TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_proposal_has_person TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_session_has_person TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_dc TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_grid_info_for_dcg TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE update_container_unassign_all_for_beamline TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_sample TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_dewar_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_session_id_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_proposal_title TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_programs_for_job_id_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_program_attachments_for_program_id_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_program_attachments_for_dc_group_program_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_job_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_job_parameters_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_job_image_sweeps_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_processing_job_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_grid_info_for_dcg_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_grid_info_for_dc TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_grid_info_for_dc_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_dewars_for_proposal_code_number_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_dc_main_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_dc TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_samples_not_loaded_for_container_reg_barcode TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_dcg_grid TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_dc_grid TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_motion_correction TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE retrieve_persons_for_session TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_proposal TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE update_dc_append_comments TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE update_dc_position TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_ctf TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE upsert_sample_image_auto_score TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE retrieve_container_for_sample_id TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE insert_phasing_analysis_results TO 'ispyb_processing';

GRANT EXECUTE ON PROCEDURE insert_cryoem_initial_model TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_particle_classification TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_particle_classification_v2 TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_particle_classification_group TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_particle_picker TO 'ispyb_processing';
GRANT EXECUTE ON PROCEDURE upsert_particle_picker_v2 TO 'ispyb_processing';
