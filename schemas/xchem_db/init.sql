--
-- Remove field review from badatoms
--
ALTER TABLE `bad_atoms` DROP COLUMN `review_id`;
--
-- Add field pl_active to target
--
ALTER TABLE `target` ADD COLUMN `pl_active` bool DEFAULT True NOT NULL;
ALTER TABLE `target` ALTER COLUMN `pl_active` DROP DEFAULT;
--
-- Add field pl_additional_headers to target
--
ALTER TABLE `target` ADD COLUMN `pl_additional_headers` longtext NOT NULL;
--
-- Add field pl_covalent_attachments to target
--
ALTER TABLE `target` ADD COLUMN `pl_covalent_attachments` bool DEFAULT True NOT NULL;
ALTER TABLE `target` ALTER COLUMN `pl_covalent_attachments` DROP DEFAULT;
--
-- Add field pl_monomeric to target
--
ALTER TABLE `target` ADD COLUMN `pl_monomeric` bool DEFAULT False NOT NULL;
ALTER TABLE `target` ALTER COLUMN `pl_monomeric` DROP DEFAULT;
--
-- Add field pl_reduce_reference_frame to target
--
ALTER TABLE `target` ADD COLUMN `pl_reduce_reference_frame` bool DEFAULT True NOT NULL;
ALTER TABLE `target` ALTER COLUMN `pl_reduce_reference_frame` DROP DEFAULT;
--
-- Add field pl_reference to target
--
ALTER TABLE `target` ADD COLUMN `pl_reference` varchar(500) DEFAULT  NOT NULL;
ALTER TABLE `target` ALTER COLUMN `pl_reference` DROP DEFAULT;
--
-- Alter field atomid on badatoms
--
ALTER TABLE `bad_atoms` MODIFY `atomid` longtext NOT NULL;
--
-- Remove field compound from crystal
--
ALTER TABLE `crystal` DROP COLUMN `compound_id`;
--
-- Add field compound to crystal
--
CREATE TABLE `crystal_compound` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `crystal_id` integer NOT NULL, `compounds_id` integer NOT NULL);
--
-- Delete model PipelineParams
--
DROP TABLE `pipeline_params` CASCADE;
ALTER TABLE `crystal_compound` ADD CONSTRAINT `crystal_compound_crystal_id_compounds_id_b63a99a6_uniq` UNIQUE (`crystal_id`, `compounds_id`);
ALTER TABLE `crystal_compound` ADD CONSTRAINT `crystal_compound_crystal_id_8770ed3a_fk_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `crystal_compound` ADD CONSTRAINT `crystal_compound_compounds_id_2bf3601e_fk_compound_id` FOREIGN KEY (`compounds_id`) REFERENCES `compound` (`id`);
--
-- Create model Compounds
--
CREATE TABLE `compound` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `smiles` varchar(255) NULL UNIQUE, `compound_id` varchar(255) NULL UNIQUE);
--
-- Create model Crystal
--
CREATE TABLE `crystal` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `crystal_name` varchar(255) NOT NULL, `status` varchar(2) NOT NULL, `well` varchar(4) NULL, `echo_x` integer NULL, `echo_y` integer NULL, `score` integer NULL, `compound_id` integer NULL);
--
-- Create model DataProcessing
--
CREATE TABLE `data_processing` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `auto_assigned` longtext NULL, `cchalf_high` double precision NULL, `cchalf_low` double precision NULL, `cchalf_overall` double precision NULL, `completeness_high` double precision NULL, `completeness_low` double precision NULL, `completeness_overall` double precision NULL, `dimple_mtz_path` longtext NULL, `dimple_pdb_path` longtext NULL, `dimple_status` longtext NULL, `image_path` longtext NULL, `isig_high` double precision NULL, `isig_low` double precision NULL, `isig_overall` double precision NULL, `lattice` longtext NULL, `log_name` longtext NULL, `logfile_path` longtext NULL, `mtz_name` longtext NULL, `mtz_path` longtext NULL, `multiplicity_high` double precision NULL, `multiplicity_low` double precision NULL, `multiplicity_overall` double precision NULL, `original_directory` longtext NULL, `point_group` longtext NULL, `program` longtext NULL, `r_cryst` double precision NULL, `r_free` double precision NULL, `r_merge_high` double precision NULL, `r_merge_low` double precision NULL, `r_merge_overall` double precision NULL, `res_high` double precision NULL, `res_high_15_sigma` double precision NULL, `res_high_outer_shell` double precision NULL, `res_low` double precision NULL, `res_low_inner_shell` double precision NULL, `res_overall` longtext NULL, `score` double precision NULL, `spacegroup` longtext NULL, `status` longtext NULL, `unique_ref_overall` integer NULL, `unit_cell` longtext NULL, `unit_cell_vol` double precision NULL, `crystal_name_id` integer NOT NULL UNIQUE);
--
-- Create model FragalysisLigand
--
CREATE TABLE `fragalysis_ligand` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `ligand_name` varchar(255) NOT NULL, `crystallographic_bound` varchar(500) NOT NULL, `lig_mol_file` varchar(500) NOT NULL, `apo_pdb` varchar(500) NOT NULL, `bound_pdb` varchar(500) NOT NULL, `smiles_file` varchar(500) NOT NULL, `desolvated_pdb` varchar(500) NOT NULL, `solvated_pdb` varchar(500) NOT NULL, `pandda_event` varchar(500) NOT NULL, `two_fofc` varchar(500) NOT NULL, `fofc` varchar(500) NOT NULL, `modification_date` bigint NOT NULL);
--
-- Create model Ligand
--
CREATE TABLE `ligand` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `compound_id` integer NOT NULL, `crystal_id` integer NOT NULL, `fragalysis_ligand_id` integer NOT NULL);
--
-- Create model MiscFiles
--
CREATE TABLE `misc_files` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `file` varchar(500) NOT NULL, `description` longtext NOT NULL);
--
-- Create model PanddaAnalysis
--
CREATE TABLE `pandda_analysis` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `pandda_dir` varchar(255) NOT NULL UNIQUE);
--
-- Create model PanddaEvent
--
CREATE TABLE `pandda_event` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `event` integer NULL, `event_centroid_x` double precision NULL, `event_centroid_y` double precision NULL, `event_centroid_z` double precision NULL, `event_dist_from_site_centroid` longtext NULL, `lig_centroid_x` double precision NULL, `lig_centroid_y` double precision NULL, `lig_centroid_z` double precision NULL, `lig_dist_event` double precision NULL, `lig_id` longtext NULL, `pandda_event_map_native` longtext NULL, `pandda_event_map_cut` longtext NULL, `pandda_model_pdb` longtext NULL, `pandda_input_mtz` longtext NULL, `pandda_input_pdb` longtext NULL, `ligand_confidence_inspect` longtext NULL, `ligand_confidence` longtext NULL, `comment` longtext NULL, `interesting` bool NOT NULL, `event_status` longtext NULL, `created_date` datetime(6) NULL, `modified_date` datetime(6) NULL, `ligand_confidence_source` varchar(2) NOT NULL, `crystal_id` integer NOT NULL, `data_proc_id` integer NOT NULL);
--
-- Create model PanddaRun
--
CREATE TABLE `pandda_run` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `input_dir` longtext NULL, `pandda_log` varchar(255) NOT NULL UNIQUE, `pandda_version` longtext NULL, `sites_file` longtext NULL, `events_file` longtext NULL, `pandda_analysis_id` integer NOT NULL);
--
-- Create model Proposals
--
CREATE TABLE `proposals` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `proposal` varchar(255) NOT NULL UNIQUE, `title` varchar(10) NULL, `fedids` longtext NULL);
--
-- Create model ProteinSite
--
CREATE TABLE `protein_sites` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `site_name` varchar(50) NOT NULL, `site_chain` varchar(50) NOT NULL, `site_conformation` varchar(50) NOT NULL, `site_crystal_form` varchar(50) NOT NULL, `site_residue_names` longtext NOT NULL, `site_residue_indicies` longtext NOT NULL, `creator` varchar(255) NOT NULL, `fragalysis_ligand_reference_id` integer NOT NULL);
--
-- Create model Reference
--
CREATE TABLE `reference` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `reference_pdb` varchar(255) NULL UNIQUE);
--
-- Create model Target
--
CREATE TABLE `target` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `target_name` varchar(255) NOT NULL UNIQUE, `uniprot_id` varchar(255) NULL, `alias` varchar(255) NULL);
--
-- Create model SoakdbFiles
--
CREATE TABLE `soakdb_files` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `filename` varchar(255) NOT NULL UNIQUE, `modification_date` bigint NOT NULL, `visit` longtext NOT NULL, `status` integer NULL, `proposal_id` integer NOT NULL);
--
-- Create model SiteMapping
--
CREATE TABLE `site_mapping` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `ligand_id` integer NOT NULL, `site_id` integer NOT NULL);
--
-- Create model ReviewResponses
--
CREATE TABLE `review_responses` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `fedid` longtext NOT NULL, `decision_int` integer NOT NULL, `decision_str` longtext NOT NULL, `reason` longtext NOT NULL, `time_submitted` integer NOT NULL, `crystal_id` integer NOT NULL, `ligand_name_id` integer NOT NULL);
--
-- Create model Refinement
--
CREATE TABLE `refinement` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `bound_conf` varchar(255) NULL UNIQUE, `cif` longtext NULL, `cif_prog` longtext NULL, `cif_status` longtext NULL, `lig_bound_conf` longtext NULL, `lig_cc` longtext NULL, `lig_confidence` longtext NULL, `lig_confidence_int` integer NULL, `lig_confidence_string` longtext NULL, `matrix_weight` longtext NULL, `molprobity_score` double precision NULL, `mtz_free` longtext NULL, `mtz_latest` longtext NULL, `outcome` integer NULL, `pdb_latest` longtext NULL, `r_free` double precision NULL, `ramachandran_favoured` longtext NULL, `ramachandran_outliers` longtext NULL, `rcryst` double precision NULL, `refinement_path` longtext NULL, `res` double precision NULL, `rmsd_angles` longtext NULL, `rmsd_bonds` longtext NULL, `spacegroup` longtext NULL, `status` longtext NULL, `crystal_name_id` integer NOT NULL UNIQUE);
--
-- Create model PipelineParams
--
CREATE TABLE `pipeline_params` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `reference` varchar(500) NOT NULL, `monomeric` bool NOT NULL, `reduce_reference_frame` bool NOT NULL, `covalent_attachments` bool NOT NULL, `additional_headers` longtext NOT NULL, `target_id` integer NOT NULL);
--
-- Create model PanddaSite
--
CREATE TABLE `pandda_site` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `site` integer NULL, `site_aligned_centroid_x` double precision NULL, `site_aligned_centroid_y` double precision NULL, `site_aligned_centroid_z` double precision NULL, `site_native_centroid_x` double precision NULL, `site_native_centroid_y` double precision NULL, `site_native_centroid_z` double precision NULL, `pandda_run_id` integer NOT NULL);
--
-- Create model PanddaEventStats
--
CREATE TABLE `pandda_event_stats` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `one_minus_bdc` double precision NULL, `cluster_size` integer NULL, `glob_corr_av_map` double precision NULL, `glob_corr_mean_map` double precision NULL, `loc_corr_av_map` double precision NULL, `loc_corr_mean_map` double precision NULL, `z_mean` double precision NULL, `z_peak` double precision NULL, `b_factor_scaled` double precision NULL, `high_res` double precision NULL, `low_res` double precision NULL, `r_free` double precision NULL, `r_work` double precision NULL, `ref_rmsd` double precision NULL, `wilson_scaled_b` double precision NULL, `wilson_scaled_ln_dev` double precision NULL, `wilson_scaled_ln_dev_z` double precision NULL, `wilson_scaled_ln_rmsd` double precision NULL, `wilson_scaled_ln_rmsd_z` double precision NULL, `wilson_scaled_below_four_rmsd` double precision NULL, `wilson_scaled_below_four_rmsd_z` double precision NULL, `wilson_scaled_above_four_rmsd` double precision NULL, `wilson_scaled_above_four_rmsd_z` double precision NULL, `wilson_scaled_rmsd_all` double precision NULL, `wilson_scaled_rmsd_all_z` double precision NULL, `wilson_unscaled` double precision NULL, `wilson_unscaled_ln_dev` double precision NULL, `wilson_unscaled_ln_dev_z` double precision NULL, `wilson_unscaled_ln_rmsd` double precision NULL, `wilson_unscaled_ln_rmsd_z` double precision NULL, `wilson_unscaled_below_four_rmsd` double precision NULL, `wilson_unscaled_below_four_rmsd_z` double precision NULL, `wilson_unscaled_above_four_rmsd` double precision NULL, `wilson_unscaled_above_four_rmsd_z` double precision NULL, `wilson_unscaled_rmsd_all` double precision NULL, `wilson_unscaled_rmsd_all_z` double precision NULL, `resolution` double precision NULL, `map_uncertainty` double precision NULL, `obs_map_mean` double precision NULL, `obs_map_rms` double precision NULL, `z_map_kurt` double precision NULL, `z_map_mean` double precision NULL, `z_map_skew` double precision NULL, `z_map_std` double precision NULL, `scl_map_mean` double precision NULL, `scl_map_rms` double precision NULL, `event_id` integer NOT NULL);
--
-- Add field pandda_run to panddaevent
--
ALTER TABLE `pandda_event` ADD COLUMN `pandda_run_id` integer NOT NULL , ADD CONSTRAINT `pandda_event_pandda_run_id_4fa1247e_fk_pandda_run_id` FOREIGN KEY (`pandda_run_id`) REFERENCES `pandda_run`(`id`);
--
-- Add field refinement to panddaevent
--
ALTER TABLE `pandda_event` ADD COLUMN `refinement_id` integer NOT NULL , ADD CONSTRAINT `pandda_event_refinement_id_f7d60b87_fk_refinement_id` FOREIGN KEY (`refinement_id`) REFERENCES `refinement`(`id`);
--
-- Add field site to panddaevent
--
ALTER TABLE `pandda_event` ADD COLUMN `site_id` integer NOT NULL , ADD CONSTRAINT `pandda_event_site_id_a50af98f_fk_pandda_site_id` FOREIGN KEY (`site_id`) REFERENCES `pandda_site`(`id`);
--
-- Create model MetaData
--
CREATE TABLE `meta_data` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `site_Label` varchar(255) NOT NULL, `new_smiles` longtext NOT NULL, `alternate_name` varchar(255) NOT NULL, `pdb_id` varchar(255) NOT NULL, `fragalysis_name` varchar(255) NOT NULL UNIQUE, `original_name` varchar(255) NOT NULL, `ligand_name_id` integer NOT NULL);
--
-- Add field target to ligand
--
ALTER TABLE `ligand` ADD COLUMN `target_id` integer NOT NULL , ADD CONSTRAINT `ligand_target_id_7e14f3c9_fk_target_id` FOREIGN KEY (`target_id`) REFERENCES `target`(`id`);
--
-- Create model Lab
--
CREATE TABLE `lab` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `cryo_frac` double precision NULL, `cryo_status` longtext NULL, `cryo_stock_frac` double precision NULL, `cryo_transfer_vol` double precision NULL, `data_collection_visit` longtext NULL, `expr_conc` double precision NULL, `harvest_status` longtext NULL, `library_name` longtext NULL, `library_plate` longtext NULL, `mounting_result` longtext NULL, `mounting_time` longtext NULL, `soak_status` longtext NULL, `soak_time` longtext NULL, `soak_vol` double precision NULL, `solv_frac` double precision NULL, `stock_conc` double precision NULL, `visit` longtext NULL, `puck` varchar(100) NULL, `position` varchar(100) NULL, `pin_barcode` varchar(100) NULL, `arrival_time` datetime(6) NULL, `mounted_timestamp` datetime(6) NULL, `ispyb_status` varchar(100) NULL, `crystal_name_id` integer NOT NULL UNIQUE);
--
-- Create model FragalysisTarget
--
CREATE TABLE `fragalysis_target` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `public` bool NOT NULL, `target` varchar(255) NOT NULL, `metadata_file` varchar(500) NOT NULL, `input_root` longtext NOT NULL, `staging_root` longtext NOT NULL, `reference` varchar(500) NOT NULL, `biomol` varchar(500) NOT NULL);
CREATE TABLE `fragalysis_target_additional_files` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `fragalysistarget_id` integer NOT NULL, `miscfiles_id` integer NOT NULL);
--
-- Add field fragalysis_target to fragalysisligand
--
ALTER TABLE `fragalysis_ligand` ADD COLUMN `fragalysis_target_id` integer NOT NULL , ADD CONSTRAINT `fragalysis_ligand_fragalysis_target_id_6a3fe295_fk_fragalysi` FOREIGN KEY (`fragalysis_target_id`) REFERENCES `fragalysis_target`(`id`);
--
-- Add field target to crystal
--
ALTER TABLE `crystal` ADD COLUMN `target_id` integer NOT NULL , ADD CONSTRAINT `crystal_target_id_36cc8752_fk_target_id` FOREIGN KEY (`target_id`) REFERENCES `target`(`id`);
--
-- Add field visit to crystal
--
ALTER TABLE `crystal` ADD COLUMN `visit_id` integer NOT NULL , ADD CONSTRAINT `crystal_visit_id_94356d5f_fk_soakdb_files_id` FOREIGN KEY (`visit_id`) REFERENCES `soakdb_files`(`id`);
--
-- Create model BadAtoms
--
CREATE TABLE `bad_atoms` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `atomid` integer NOT NULL, `comment` longtext NOT NULL, `atomname` longtext NOT NULL, `ligand_id` integer NOT NULL, `review_id` integer NOT NULL);
--
-- Create model PanddaStatisticalMap
--
CREATE TABLE `pandda_statistical_map` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `resolution_from` double precision NULL, `resolution_to` double precision NULL, `dataset_list` longtext NOT NULL, `pandda_run_id` integer NOT NULL);
--
-- Alter unique_together for panddaevent (1 constraint(s))
--
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_site_id_event_crystal_id_2b9d759c_uniq` UNIQUE (`site_id`, `event`, `crystal_id`, `pandda_run_id`);
--
-- Create model Dimple
--
CREATE TABLE `dimple` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `mtz_path` varchar(255) NULL, `pdb_path` varchar(255) NULL, `r_free` double precision NULL, `res_high` double precision NULL, `status` longtext NULL, `crystal_name_id` integer NOT NULL UNIQUE, `reference_id` integer NULL);
--
-- Alter unique_together for crystal (1 constraint(s))
--
ALTER TABLE `crystal` ADD CONSTRAINT `crystal_crystal_name_visit_id_9764d856_uniq` UNIQUE (`crystal_name`, `visit_id`);
ALTER TABLE `compound` ADD CONSTRAINT `compound_smiles_compound_id_f5f82628_uniq` UNIQUE (`smiles`, `compound_id`);
ALTER TABLE `crystal` ADD CONSTRAINT `crystal_compound_id_b3fc07f7_fk_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `compound` (`id`);
CREATE INDEX `crystal_crystal_name_6111053e` ON `crystal` (`crystal_name`);
ALTER TABLE `data_processing` ADD CONSTRAINT `data_processing_crystal_name_id_fb3aea44_fk_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `ligand` ADD CONSTRAINT `ligand_compound_id_b9bf20e3_fk_compound_id` FOREIGN KEY (`compound_id`) REFERENCES `compound` (`id`);
ALTER TABLE `ligand` ADD CONSTRAINT `ligand_crystal_id_de4f8b7e_fk_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `ligand` ADD CONSTRAINT `ligand_fragalysis_ligand_id_8662068f_fk_fragalysis_ligand_id` FOREIGN KEY (`fragalysis_ligand_id`) REFERENCES `fragalysis_ligand` (`id`);
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_crystal_id_b75ed338_fk_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_data_proc_id_2623d96f_fk_data_processing_id` FOREIGN KEY (`data_proc_id`) REFERENCES `data_processing` (`id`);
CREATE INDEX `pandda_event_event_81acae4d` ON `pandda_event` (`event`);
ALTER TABLE `pandda_run` ADD CONSTRAINT `pandda_run_pandda_analysis_id_21fae35d_fk_pandda_analysis_id` FOREIGN KEY (`pandda_analysis_id`) REFERENCES `pandda_analysis` (`id`);
ALTER TABLE `protein_sites` ADD CONSTRAINT `protein_sites_fragalysis_ligand_re_bd19c3ac_fk_fragalysi` FOREIGN KEY (`fragalysis_ligand_reference_id`) REFERENCES `fragalysis_ligand` (`id`);
ALTER TABLE `soakdb_files` ADD CONSTRAINT `soakdb_files_proposal_id_524d1fc3_fk_proposals_id` FOREIGN KEY (`proposal_id`) REFERENCES `proposals` (`id`);
ALTER TABLE `site_mapping` ADD CONSTRAINT `site_mapping_ligand_id_9615b358_fk_fragalysis_ligand_id` FOREIGN KEY (`ligand_id`) REFERENCES `fragalysis_ligand` (`id`);
ALTER TABLE `site_mapping` ADD CONSTRAINT `site_mapping_site_id_3533ce74_fk_protein_sites_id` FOREIGN KEY (`site_id`) REFERENCES `protein_sites` (`id`);
ALTER TABLE `review_responses` ADD CONSTRAINT `review_responses_crystal_id_bc90b8d9_fk_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `review_responses` ADD CONSTRAINT `review_responses_ligand_name_id_9900afe9_fk_ligand_id` FOREIGN KEY (`ligand_name_id`) REFERENCES `ligand` (`id`);
ALTER TABLE `refinement` ADD CONSTRAINT `refinement_crystal_name_id_38c8a07b_fk_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `pipeline_params` ADD CONSTRAINT `pipeline_params_target_id_f07b5637_fk_target_id` FOREIGN KEY (`target_id`) REFERENCES `target` (`id`);
ALTER TABLE `pandda_site` ADD CONSTRAINT `pandda_site_pandda_run_id_site_48013a5b_uniq` UNIQUE (`pandda_run_id`, `site`);
ALTER TABLE `pandda_site` ADD CONSTRAINT `pandda_site_pandda_run_id_be084b50_fk_pandda_run_id` FOREIGN KEY (`pandda_run_id`) REFERENCES `pandda_run` (`id`);
CREATE INDEX `pandda_site_site_80cc797a` ON `pandda_site` (`site`);
ALTER TABLE `pandda_event_stats` ADD CONSTRAINT `pandda_event_stats_event_id_5f015036_fk_pandda_event_id` FOREIGN KEY (`event_id`) REFERENCES `pandda_event` (`id`);
ALTER TABLE `meta_data` ADD CONSTRAINT `meta_data_ligand_name_id_820bd396_fk_fragalysis_ligand_id` FOREIGN KEY (`ligand_name_id`) REFERENCES `fragalysis_ligand` (`id`);
ALTER TABLE `lab` ADD CONSTRAINT `lab_crystal_name_id_0412c3fb_fk_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `fragalysis_target_additional_files` ADD CONSTRAINT `fragalysis_target_additi_fragalysistarget_id_misc_88fee56b_uniq` UNIQUE (`fragalysistarget_id`, `miscfiles_id`);
ALTER TABLE `fragalysis_target_additional_files` ADD CONSTRAINT `fragalysis_target_ad_fragalysistarget_id_8343cb31_fk_fragalysi` FOREIGN KEY (`fragalysistarget_id`) REFERENCES `fragalysis_target` (`id`);
ALTER TABLE `fragalysis_target_additional_files` ADD CONSTRAINT `fragalysis_target_ad_miscfiles_id_2dc8527c_fk_misc_file` FOREIGN KEY (`miscfiles_id`) REFERENCES `misc_files` (`id`);
ALTER TABLE `bad_atoms` ADD CONSTRAINT `bad_atoms_ligand_id_44742335_fk_ligand_id` FOREIGN KEY (`ligand_id`) REFERENCES `ligand` (`id`);
ALTER TABLE `bad_atoms` ADD CONSTRAINT `bad_atoms_review_id_9324df23_fk_review_responses_id` FOREIGN KEY (`review_id`) REFERENCES `review_responses` (`id`);
ALTER TABLE `pandda_statistical_map` ADD CONSTRAINT `pandda_statistical_map_resolution_from_resoluti_14bb7f7b_uniq` UNIQUE (`resolution_from`, `resolution_to`, `pandda_run_id`);
ALTER TABLE `pandda_statistical_map` ADD CONSTRAINT `pandda_statistical_map_pandda_run_id_eb293e7e_fk_pandda_run_id` FOREIGN KEY (`pandda_run_id`) REFERENCES `pandda_run` (`id`);
ALTER TABLE `dimple` ADD CONSTRAINT `dimple_pdb_path_mtz_path_6c49ab75_uniq` UNIQUE (`pdb_path`, `mtz_path`);
ALTER TABLE `dimple` ADD CONSTRAINT `dimple_crystal_name_id_c29f59d1_fk_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `crystal` (`id`);
ALTER TABLE `dimple` ADD CONSTRAINT `dimple_reference_id_6af81759_fk_reference_id` FOREIGN KEY (`reference_id`) REFERENCES `reference` (`id`);
