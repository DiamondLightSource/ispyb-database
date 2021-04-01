--
-- Create model Compounds
--
CREATE TABLE `xchem_db_compounds` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `smiles` varchar(255) NULL, `code` varchar(32) NULL, `log_p` double precision NULL, `mol_wt` double precision NULL, `heavy_atom_count` integer NULL, `heavy_atom_mol_wt` double precision NULL, `nhoh_count` integer NULL, `no_count` integer NULL, `num_h_acceptors` integer NULL, `num_h_donors` integer NULL, `num_het_atoms` integer NULL, `num_rot_bonds` integer NULL, `num_val_electrons` integer NULL, `ring_count` integer NULL, `tpsa` double precision NULL);
--
-- Create model Crystal
--
CREATE TABLE `xchem_db_crystal` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `crystal_name` varchar(255) NULL, `product` varchar(255) NULL, `status` varchar(2) NOT NULL, `well` varchar(4) NULL, `echo_x` integer NULL, `echo_y` integer NULL, `score` integer NULL);
--
-- Create model CrystalPlate
--
CREATE TABLE `xchem_db_crystalplate` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NOT NULL, `drop_volume` double precision NULL, `plate_type` varchar(50) NULL);
--
-- Create model DataProcessing
--
CREATE TABLE `data_processing` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `auto_assigned` longtext NULL, `cchalf_high` double precision NULL, `cchalf_low` double precision NULL, `cchalf_overall` double precision NULL, `completeness_high` double precision NULL, `completeness_low` double precision NULL, `completeness_overall` double precision NULL, `dimple_mtz_path` longtext NULL, `dimple_pdb_path` longtext NULL, `dimple_status` longtext NULL, `image_path` longtext NULL, `isig_high` double precision NULL, `isig_low` double precision NULL, `isig_overall` double precision NULL, `lattice` longtext NULL, `log_name` longtext NULL, `logfile_path` longtext NULL, `mtz_name` longtext NULL, `mtz_path` longtext NULL, `multiplicity_high` double precision NULL, `multiplicity_low` double precision NULL, `multiplicity_overall` double precision NULL, `original_directory` longtext NULL, `point_group` longtext NULL, `program` longtext NULL, `r_cryst` double precision NULL, `r_free` double precision NULL, `r_merge_high` double precision NULL, `r_merge_low` double precision NULL, `r_merge_overall` double precision NULL, `res_high` double precision NULL, `res_high_15_sigma` double precision NULL, `res_high_outer_shell` double precision NULL, `res_low` double precision NULL, `res_low_inner_shell` double precision NULL, `res_overall` longtext NULL, `score` double precision NULL, `spacegroup` longtext NULL, `status` longtext NULL, `unique_ref_overall` integer NULL, `unit_cell` longtext NULL, `unit_cell_vol` double precision NULL, `crystal_name_id` integer NOT NULL UNIQUE);
--
-- Create model FragalysisLigand
--
CREATE TABLE `FragalysisLigand` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `ligand_name` varchar(255) NOT NULL, `crystallographic_bound` varchar(500) NOT NULL, `lig_mol_file` varchar(500) NOT NULL, `apo_pdb` varchar(500) NOT NULL, `bound_pdb` varchar(500) NOT NULL, `smiles_file` varchar(500) NOT NULL, `desolvated_pdb` varchar(500) NOT NULL, `solvated_pdb` varchar(500) NOT NULL, `pandda_event` varchar(500) NOT NULL, `two_fofc` varchar(500) NOT NULL, `fofc` varchar(500) NOT NULL, `modification_date` bigint NOT NULL);
--
-- Create model Library
--
CREATE TABLE `xchem_db_library` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NULL, `for_industry` bool NOT NULL, `public` bool NOT NULL);
--
-- Create model LibraryPlate
--
CREATE TABLE `xchem_db_libraryplate` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `barcode` varchar(100) NULL, `current` bool NOT NULL, `last_tested` date NOT NULL, `library_id` integer NOT NULL);
--
-- Create model LibrarySubset
--
CREATE TABLE `xchem_db_librarysubset` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NULL, `origin` varchar(64) NULL, `library_id` integer NULL);
CREATE TABLE `xchem_db_librarysubset_compounds` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `librarysubset_id` integer NOT NULL, `compounds_id` integer NOT NULL);
--
-- Create model Ligand
--
CREATE TABLE `xchem_db_ligand` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `compound_id` integer NOT NULL, `crystal_id` integer NOT NULL, `fragalysis_ligand_id` integer NOT NULL);
--
-- Create model MiscFiles
--
CREATE TABLE `MiscFiles` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `file` varchar(500) NOT NULL, `description` longtext NOT NULL);
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
CREATE TABLE `xchem_db_proposals` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `proposal` varchar(255) NOT NULL UNIQUE, `title` varchar(10) NULL, `fedids` longtext NULL, `industry_user` bool NOT NULL);
CREATE TABLE `xchem_db_proposals_libraries` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `proposals_id` integer NOT NULL, `library_id` integer NOT NULL);
--
-- Create model Protein
--
CREATE TABLE `xchem_db_protein` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NULL, `space_group` varchar(100) NULL, `a` numeric(10, 2) NULL, `b` numeric(10, 2) NULL, `c` numeric(10, 2) NULL, `alpha` numeric(10, 2) NULL, `beta` numeric(10, 2) NULL, `gamma` numeric(10, 2) NULL);
--
-- Create model Reference
--
CREATE TABLE `xchem_db_reference` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `reference_pdb` varchar(255) NULL UNIQUE);
--
-- Create model SolventBatch
--
CREATE TABLE `xchem_db_solventbatch` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `number` integer NOT NULL, `soak_status` varchar(64) NULL, `soak_time` integer NULL, `cryo_status` varchar(64) NULL);
--
-- Create model Target
--
CREATE TABLE `target` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `target_name` varchar(255) NOT NULL UNIQUE);
--
-- Create model Batch
--
CREATE TABLE `xchem_db_batch` (`solventbatch_ptr_id` integer NOT NULL PRIMARY KEY, `solv_frac` double precision NULL, `stock_conc` double precision NULL, `cryo_frac` double precision NULL, `cryo_stock_frac` double precision NULL, `cryo_location` varchar(4) NULL, `soak_vol` double precision NULL, `expr_conc` double precision NULL, `cryo_transfer_vol` double precision NULL, `crystal_plate_id` integer NULL);
--
-- Create model Visit
--
CREATE TABLE `xchem_db_visit` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `visit_name` varchar(32) NULL, `proposal_id` integer NOT NULL);
--
-- Create model Tasks
--
CREATE TABLE `xchem_db_tasks` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `task_name` varchar(255) NOT NULL, `uuid` varchar(37) NOT NULL UNIQUE);
--
-- Create model SpaCompound
--
CREATE TABLE `xchem_db_spacompound` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `library_name` varchar(100) NOT NULL, `library_plate` varchar(100) NOT NULL, `well` varchar(4) NOT NULL, `code` varchar(100) NOT NULL, `smiles` varchar(256) NOT NULL, `visit_id` integer NULL);
--
-- Create model SourceWell
--
CREATE TABLE `xchem_db_sourcewell` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `well` varchar(4) NULL, `concentration` integer NULL, `compound_id` integer NULL, `library_plate_id` integer NULL);
--
-- Create model SolventTestingData
--
CREATE TABLE `xchem_db_solventtestingdata` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `solv_frac` double precision NULL, `stock_conc` double precision NULL, `cryo_frac` double precision NULL, `cryo_stock_frac` double precision NULL, `cryo_location` varchar(4) NULL, `soak_vol` double precision NULL, `expr_conc` double precision NULL, `cryo_transfer_vol` double precision NULL, `solvent_name` varchar(64) NULL, `batch_id` integer NULL, `crystal_plate_id` integer NULL);
--
-- Create model SolventNotes
--
CREATE TABLE `xchem_db_solventnotes` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `solvent` varchar(32) NULL, `solvent_concentration` double precision NULL, `soak_time` bigint NULL, `cryo` varchar(32) NULL, `cryo_concentration` double precision NULL, `comments` longtext NULL, `proposal_id` integer NOT NULL);
--
-- Create model SoakdbFiles
--
CREATE TABLE `soakdb_files` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `filename` varchar(255) NOT NULL UNIQUE, `modification_date` bigint NOT NULL, `visit` longtext NOT NULL, `status` integer NULL, `proposal_id` integer NOT NULL);
--
-- Create model ReviewResponses2
--
CREATE TABLE `review_responses_new` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `fedid` longtext NOT NULL, `decision_int` integer NOT NULL, `decision_str` longtext NOT NULL, `reason` longtext NOT NULL, `time_submitted` integer NOT NULL, `Ligand_name_id` integer NOT NULL, `crystal_id` integer NOT NULL);
--
-- Create model ReviewResponses
--
CREATE TABLE `review_responses` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `fedid` longtext NOT NULL, `decision_int` integer NOT NULL, `decision_str` longtext NOT NULL, `reason` longtext NOT NULL, `time_submitted` integer NOT NULL, `crystal_id` integer NOT NULL);
--
-- Create model Refinement
--
CREATE TABLE `xchem_db_refinement` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `bound_conf` varchar(255) NULL UNIQUE, `cif` longtext NULL, `cif_prog` longtext NULL, `cif_status` longtext NULL, `lig_bound_conf` longtext NULL, `lig_cc` longtext NULL, `lig_confidence` longtext NULL, `lig_confidence_int` integer NULL, `lig_confidence_string` longtext NULL, `matrix_weight` longtext NULL, `molprobity_score` double precision NULL, `mtz_free` longtext NULL, `mtz_latest` longtext NULL, `outcome` integer NULL, `pdb_latest` longtext NULL, `r_free` double precision NULL, `ramachandran_favoured` longtext NULL, `ramachandran_outliers` longtext NULL, `rcryst` double precision NULL, `refinement_path` longtext NULL, `res` double precision NULL, `rmsd_angles` longtext NULL, `rmsd_bonds` longtext NULL, `spacegroup` longtext NULL, `status` longtext NULL, `crystal_name_id` integer NOT NULL UNIQUE);
--
-- Add field protein to proposals
--
ALTER TABLE `xchem_db_proposals` ADD COLUMN `protein_id` integer NULL UNIQUE , ADD CONSTRAINT `xchem_db_proposals_protein_id_69500dc5_fk_xchem_db_protein_id` FOREIGN KEY (`protein_id`) REFERENCES `xchem_db_protein`(`id`);
--
-- Add field subsets to proposals
--
CREATE TABLE `xchem_db_proposals_subsets` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `proposals_id` integer NOT NULL, `librarysubset_id` integer NOT NULL);
--
-- Create model Preset
--
CREATE TABLE `xchem_db_preset` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(64) NULL, `description` longtext NULL);
CREATE TABLE `xchem_db_preset_subsets` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `preset_id` integer NOT NULL, `librarysubset_id` integer NOT NULL);
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
ALTER TABLE `pandda_event` ADD COLUMN `refinement_id` integer NOT NULL , ADD CONSTRAINT `pandda_event_refinement_id_f7d60b87_fk_xchem_db_refinement_id` FOREIGN KEY (`refinement_id`) REFERENCES `xchem_db_refinement`(`id`);
--
-- Add field site to panddaevent
--
ALTER TABLE `pandda_event` ADD COLUMN `site_id` integer NOT NULL , ADD CONSTRAINT `pandda_event_site_id_a50af98f_fk_pandda_site_id` FOREIGN KEY (`site_id`) REFERENCES `pandda_site`(`id`);
--
-- Create model MetaData
--
CREATE TABLE `xchem_db_metadata` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `Site_Label` varchar(255) NOT NULL, `new_smiles` longtext NOT NULL, `alternate_name` varchar(255) NOT NULL, `pdb_id` varchar(255) NOT NULL, `fragalysis_name` varchar(255) NOT NULL UNIQUE, `original_name` varchar(255) NOT NULL, `Ligand_name_id` integer NOT NULL);
--
-- Add field target to ligand
--
ALTER TABLE `xchem_db_ligand` ADD COLUMN `target_id` integer NOT NULL , ADD CONSTRAINT `xchem_db_ligand_target_id_ecdc3fbd_fk_target_id` FOREIGN KEY (`target_id`) REFERENCES `target`(`id`);
--
-- Create model FragalysisTarget
--
CREATE TABLE `FragalysisTarget` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `open` bool NOT NULL, `target` varchar(255) NOT NULL, `metadata_file` varchar(500) NOT NULL, `input_root` longtext NOT NULL, `staging_root` longtext NOT NULL, `biomol` varchar(500) NOT NULL);
CREATE TABLE `FragalysisTarget_additional_files` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `fragalysistarget_id` integer NOT NULL, `miscfiles_id` integer NOT NULL);
--
-- Add field fragalysis_target to fragalysisligand
--
ALTER TABLE `FragalysisLigand` ADD COLUMN `fragalysis_target_id` integer NOT NULL , ADD CONSTRAINT `FragalysisLigand_fragalysis_target_id_0f897219_fk_Fragalysi` FOREIGN KEY (`fragalysis_target_id`) REFERENCES `FragalysisTarget`(`id`);
--
-- Add field crystal_plate to crystal
--
ALTER TABLE `xchem_db_crystal` ADD COLUMN `crystal_plate_id` integer NULL , ADD CONSTRAINT `xchem_db_crystal_crystal_plate_id_a813143f_fk_xchem_db_` FOREIGN KEY (`crystal_plate_id`) REFERENCES `xchem_db_crystalplate`(`id`);
--
-- Add field soakdb_file to crystal
--
ALTER TABLE `xchem_db_crystal` ADD COLUMN `soakdb_file_id` integer NULL , ADD CONSTRAINT `xchem_db_crystal_soakdb_file_id_5d0bff64_fk_soakdb_files_id` FOREIGN KEY (`soakdb_file_id`) REFERENCES `soakdb_files`(`id`);
--
-- Add field target to crystal
--
ALTER TABLE `xchem_db_crystal` ADD COLUMN `target_id` integer NULL , ADD CONSTRAINT `xchem_db_crystal_target_id_3a8a2ced_fk_target_id` FOREIGN KEY (`target_id`) REFERENCES `target`(`id`);
--
-- Add field visit to crystal
--
ALTER TABLE `xchem_db_crystal` ADD COLUMN `visit_id` integer NULL , ADD CONSTRAINT `xchem_db_crystal_visit_id_1c2f1c0f_fk_xchem_db_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `xchem_db_visit`(`id`);
--
-- Create model CompoundCombination
--
CREATE TABLE `xchem_db_compoundcombination` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `number` integer NULL, `related_crystals` varchar(64) NULL, `visit_id` integer NULL);
CREATE TABLE `xchem_db_compoundcombination_compounds` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `compoundcombination_id` integer NOT NULL, `spacompound_id` integer NOT NULL);
--
-- Create model BadAtoms
--
CREATE TABLE `bad_atoms` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `atomid` integer NOT NULL, `comment` longtext NOT NULL, `Ligand_id` integer NOT NULL, `Review_id` integer NOT NULL);
--
-- Create model PanddaStatisticalMap
--
CREATE TABLE `pandda_statistical_map` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `resolution_from` double precision NULL, `resolution_to` double precision NULL, `dataset_list` longtext NOT NULL, `pandda_run_id` integer NOT NULL);
--
-- Alter unique_together for panddaevent (1 constraint(s))
--
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_site_id_event_crystal_id_2b9d759c_uniq` UNIQUE (`site_id`, `event`, `crystal_id`, `pandda_run_id`);
--
-- Create model Lab
--
CREATE TABLE `xchem_db_lab` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `data_collection_visit` varchar(64) NULL, `harvest_status` varchar(64) NULL, `mounting_result` varchar(64) NULL, `mounting_time` varchar(64) NULL, `visit` varchar(64) NULL, `puck` varchar(100) NULL, `position` varchar(100) NULL, `pin_barcode` varchar(100) NULL, `arrival_time` datetime(6) NULL, `mounted_timestamp` datetime(6) NULL, `ispyb_status` varchar(100) NULL, `compound_combination_id` integer NULL, `crystal_name_id` integer NULL UNIQUE, `single_compound_id` integer NULL, `solvent_data_id` integer NULL, `batch_id` integer NULL);
--
-- Create model Dimple
--
CREATE TABLE `xchem_db_dimple` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `mtz_path` varchar(255) NULL, `pdb_path` varchar(255) NULL, `r_free` double precision NULL, `res_high` double precision NULL, `status` longtext NULL, `crystal_name_id` integer NOT NULL UNIQUE, `reference_id` integer NULL);
--
-- Alter unique_together for crystal (1 constraint(s))
--
ALTER TABLE `xchem_db_crystal` ADD CONSTRAINT `xchem_db_crystal_crystal_name_visit_id_product_2206861d_uniq` UNIQUE (`crystal_name`, `visit_id`, `product`);
CREATE INDEX `xchem_db_crystal_crystal_name_710c2c0d` ON `xchem_db_crystal` (`crystal_name`);
ALTER TABLE `data_processing` ADD CONSTRAINT `data_processing_crystal_name_id_fb3aea44_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_libraryplate` ADD CONSTRAINT `xchem_db_libraryplate_library_id_6076e679_fk_xchem_db_library_id` FOREIGN KEY (`library_id`) REFERENCES `xchem_db_library` (`id`);
ALTER TABLE `xchem_db_librarysubset` ADD CONSTRAINT `xchem_db_librarysubs_library_id_dee18627_fk_xchem_db_` FOREIGN KEY (`library_id`) REFERENCES `xchem_db_library` (`id`);
ALTER TABLE `xchem_db_librarysubset_compounds` ADD CONSTRAINT `xchem_db_librarysubset_c_librarysubset_id_compoun_5a3783f1_uniq` UNIQUE (`librarysubset_id`, `compounds_id`);
ALTER TABLE `xchem_db_librarysubset_compounds` ADD CONSTRAINT `xchem_db_librarysubs_librarysubset_id_5199cbe9_fk_xchem_db_` FOREIGN KEY (`librarysubset_id`) REFERENCES `xchem_db_librarysubset` (`id`);
ALTER TABLE `xchem_db_librarysubset_compounds` ADD CONSTRAINT `xchem_db_librarysubs_compounds_id_24a46aa0_fk_xchem_db_` FOREIGN KEY (`compounds_id`) REFERENCES `xchem_db_compounds` (`id`);
ALTER TABLE `xchem_db_ligand` ADD CONSTRAINT `xchem_db_ligand_compound_id_f01bf333_fk_xchem_db_compounds_id` FOREIGN KEY (`compound_id`) REFERENCES `xchem_db_compounds` (`id`);
ALTER TABLE `xchem_db_ligand` ADD CONSTRAINT `xchem_db_ligand_crystal_id_f7316340_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_ligand` ADD CONSTRAINT `xchem_db_ligand_fragalysis_ligand_id_d84ef7dd_fk_Fragalysi` FOREIGN KEY (`fragalysis_ligand_id`) REFERENCES `FragalysisLigand` (`id`);
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_crystal_id_b75ed338_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `pandda_event` ADD CONSTRAINT `pandda_event_data_proc_id_2623d96f_fk_data_processing_id` FOREIGN KEY (`data_proc_id`) REFERENCES `data_processing` (`id`);
CREATE INDEX `pandda_event_event_81acae4d` ON `pandda_event` (`event`);
ALTER TABLE `pandda_run` ADD CONSTRAINT `pandda_run_pandda_analysis_id_21fae35d_fk_pandda_analysis_id` FOREIGN KEY (`pandda_analysis_id`) REFERENCES `pandda_analysis` (`id`);
ALTER TABLE `xchem_db_proposals_libraries` ADD CONSTRAINT `xchem_db_proposals_libra_proposals_id_library_id_957f6308_uniq` UNIQUE (`proposals_id`, `library_id`);
ALTER TABLE `xchem_db_proposals_libraries` ADD CONSTRAINT `xchem_db_proposals_l_proposals_id_8541c0ae_fk_xchem_db_` FOREIGN KEY (`proposals_id`) REFERENCES `xchem_db_proposals` (`id`);
ALTER TABLE `xchem_db_proposals_libraries` ADD CONSTRAINT `xchem_db_proposals_l_library_id_9a846d2c_fk_xchem_db_` FOREIGN KEY (`library_id`) REFERENCES `xchem_db_library` (`id`);
ALTER TABLE `xchem_db_batch` ADD CONSTRAINT `xchem_db_batch_solventbatch_ptr_id_f50a35f4_fk_xchem_db_` FOREIGN KEY (`solventbatch_ptr_id`) REFERENCES `xchem_db_solventbatch` (`id`);
ALTER TABLE `xchem_db_batch` ADD CONSTRAINT `xchem_db_batch_crystal_plate_id_6e8a64af_fk_xchem_db_` FOREIGN KEY (`crystal_plate_id`) REFERENCES `xchem_db_crystalplate` (`id`);
ALTER TABLE `xchem_db_visit` ADD CONSTRAINT `xchem_db_visit_proposal_id_8a4c936c_fk_xchem_db_proposals_id` FOREIGN KEY (`proposal_id`) REFERENCES `xchem_db_proposals` (`id`);
ALTER TABLE `xchem_db_tasks` ADD CONSTRAINT `xchem_db_tasks_task_name_uuid_54b6c90e_uniq` UNIQUE (`task_name`, `uuid`);
CREATE INDEX `xchem_db_tasks_task_name_90978634` ON `xchem_db_tasks` (`task_name`);
ALTER TABLE `xchem_db_spacompound` ADD CONSTRAINT `xchem_db_spacompound_visit_id_f7ce6925_fk_xchem_db_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `xchem_db_visit` (`id`);
ALTER TABLE `xchem_db_sourcewell` ADD CONSTRAINT `xchem_db_sourcewell_compound_id_24558d8e_fk_xchem_db_` FOREIGN KEY (`compound_id`) REFERENCES `xchem_db_compounds` (`id`);
ALTER TABLE `xchem_db_sourcewell` ADD CONSTRAINT `xchem_db_sourcewell_library_plate_id_828e9373_fk_xchem_db_` FOREIGN KEY (`library_plate_id`) REFERENCES `xchem_db_libraryplate` (`id`);
ALTER TABLE `xchem_db_solventtestingdata` ADD CONSTRAINT `xchem_db_solventtest_batch_id_23d42228_fk_xchem_db_` FOREIGN KEY (`batch_id`) REFERENCES `xchem_db_solventbatch` (`id`);
ALTER TABLE `xchem_db_solventtestingdata` ADD CONSTRAINT `xchem_db_solventtest_crystal_plate_id_d0017ecd_fk_xchem_db_` FOREIGN KEY (`crystal_plate_id`) REFERENCES `xchem_db_crystalplate` (`id`);
ALTER TABLE `xchem_db_solventnotes` ADD CONSTRAINT `xchem_db_solventnote_proposal_id_62b78425_fk_xchem_db_` FOREIGN KEY (`proposal_id`) REFERENCES `xchem_db_proposals` (`id`);
ALTER TABLE `soakdb_files` ADD CONSTRAINT `soakdb_files_proposal_id_524d1fc3_fk_xchem_db_proposals_id` FOREIGN KEY (`proposal_id`) REFERENCES `xchem_db_proposals` (`id`);
ALTER TABLE `review_responses_new` ADD CONSTRAINT `review_responses_new_Ligand_name_id_ca5732d8_fk_xchem_db_` FOREIGN KEY (`Ligand_name_id`) REFERENCES `xchem_db_ligand` (`id`);
ALTER TABLE `review_responses_new` ADD CONSTRAINT `review_responses_new_crystal_id_7ef1d2cf_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `review_responses` ADD CONSTRAINT `review_responses_crystal_id_bc90b8d9_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_refinement` ADD CONSTRAINT `xchem_db_refinement_crystal_name_id_e8dda7e8_fk_xchem_db_` FOREIGN KEY (`crystal_name_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_proposals_subsets` ADD CONSTRAINT `xchem_db_proposals_subse_proposals_id_librarysubs_b841f064_uniq` UNIQUE (`proposals_id`, `librarysubset_id`);
ALTER TABLE `xchem_db_proposals_subsets` ADD CONSTRAINT `xchem_db_proposals_s_proposals_id_d90145a9_fk_xchem_db_` FOREIGN KEY (`proposals_id`) REFERENCES `xchem_db_proposals` (`id`);
ALTER TABLE `xchem_db_proposals_subsets` ADD CONSTRAINT `xchem_db_proposals_s_librarysubset_id_88190ccc_fk_xchem_db_` FOREIGN KEY (`librarysubset_id`) REFERENCES `xchem_db_librarysubset` (`id`);
ALTER TABLE `xchem_db_preset_subsets` ADD CONSTRAINT `xchem_db_preset_subsets_preset_id_librarysubset_id_d06ce2be_uniq` UNIQUE (`preset_id`, `librarysubset_id`);
ALTER TABLE `xchem_db_preset_subsets` ADD CONSTRAINT `xchem_db_preset_subsets_preset_id_8db2cb91_fk_xchem_db_preset_id` FOREIGN KEY (`preset_id`) REFERENCES `xchem_db_preset` (`id`);
ALTER TABLE `xchem_db_preset_subsets` ADD CONSTRAINT `xchem_db_preset_subs_librarysubset_id_f1d6ea4d_fk_xchem_db_` FOREIGN KEY (`librarysubset_id`) REFERENCES `xchem_db_librarysubset` (`id`);
ALTER TABLE `pandda_site` ADD CONSTRAINT `pandda_site_pandda_run_id_site_48013a5b_uniq` UNIQUE (`pandda_run_id`, `site`);
ALTER TABLE `pandda_site` ADD CONSTRAINT `pandda_site_pandda_run_id_be084b50_fk_pandda_run_id` FOREIGN KEY (`pandda_run_id`) REFERENCES `pandda_run` (`id`);
CREATE INDEX `pandda_site_site_80cc797a` ON `pandda_site` (`site`);
ALTER TABLE `pandda_event_stats` ADD CONSTRAINT `pandda_event_stats_event_id_5f015036_fk_pandda_event_id` FOREIGN KEY (`event_id`) REFERENCES `pandda_event` (`id`);
ALTER TABLE `xchem_db_metadata` ADD CONSTRAINT `xchem_db_metadata_Ligand_name_id_61f9a5fc_fk_FragalysisLigand_id` FOREIGN KEY (`Ligand_name_id`) REFERENCES `FragalysisLigand` (`id`);
ALTER TABLE `FragalysisTarget_additional_files` ADD CONSTRAINT `FragalysisTarget_additio_fragalysistarget_id_misc_3376b569_uniq` UNIQUE (`fragalysistarget_id`, `miscfiles_id`);
ALTER TABLE `FragalysisTarget_additional_files` ADD CONSTRAINT `FragalysisTarget_add_fragalysistarget_id_f958e71a_fk_Fragalysi` FOREIGN KEY (`fragalysistarget_id`) REFERENCES `FragalysisTarget` (`id`);
ALTER TABLE `FragalysisTarget_additional_files` ADD CONSTRAINT `FragalysisTarget_add_miscfiles_id_d580332d_fk_MiscFiles` FOREIGN KEY (`miscfiles_id`) REFERENCES `MiscFiles` (`id`);
ALTER TABLE `xchem_db_compoundcombination` ADD CONSTRAINT `xchem_db_compoundcom_visit_id_41cd7aba_fk_xchem_db_` FOREIGN KEY (`visit_id`) REFERENCES `xchem_db_visit` (`id`);
ALTER TABLE `xchem_db_compoundcombination_compounds` ADD CONSTRAINT `xchem_db_compoundcombina_compoundcombination_id_s_6782ece0_uniq` UNIQUE (`compoundcombination_id`, `spacompound_id`);
ALTER TABLE `xchem_db_compoundcombination_compounds` ADD CONSTRAINT `xchem_db_compoundcom_compoundcombination__0733ef1e_fk_xchem_db_` FOREIGN KEY (`compoundcombination_id`) REFERENCES `xchem_db_compoundcombination` (`id`);
ALTER TABLE `xchem_db_compoundcombination_compounds` ADD CONSTRAINT `xchem_db_compoundcom_spacompound_id_aee4ca4d_fk_xchem_db_` FOREIGN KEY (`spacompound_id`) REFERENCES `xchem_db_spacompound` (`id`);
ALTER TABLE `bad_atoms` ADD CONSTRAINT `bad_atoms_Ligand_id_02ffdb51_fk_xchem_db_ligand_id` FOREIGN KEY (`Ligand_id`) REFERENCES `xchem_db_ligand` (`id`);
ALTER TABLE `bad_atoms` ADD CONSTRAINT `bad_atoms_Review_id_6cdfaf32_fk_review_responses_new_id` FOREIGN KEY (`Review_id`) REFERENCES `review_responses_new` (`id`);
ALTER TABLE `pandda_statistical_map` ADD CONSTRAINT `pandda_statistical_map_resolution_from_resoluti_14bb7f7b_uniq` UNIQUE (`resolution_from`, `resolution_to`, `pandda_run_id`);
ALTER TABLE `pandda_statistical_map` ADD CONSTRAINT `pandda_statistical_map_pandda_run_id_eb293e7e_fk_pandda_run_id` FOREIGN KEY (`pandda_run_id`) REFERENCES `pandda_run` (`id`);
ALTER TABLE `xchem_db_lab` ADD CONSTRAINT `xchem_db_lab_compound_combination_7a8a2531_fk_xchem_db_` FOREIGN KEY (`compound_combination_id`) REFERENCES `xchem_db_compoundcombination` (`id`);
ALTER TABLE `xchem_db_lab` ADD CONSTRAINT `xchem_db_lab_crystal_name_id_4d5f9937_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_lab` ADD CONSTRAINT `xchem_db_lab_single_compound_id_e463c92f_fk_xchem_db_` FOREIGN KEY (`single_compound_id`) REFERENCES `xchem_db_spacompound` (`id`);
ALTER TABLE `xchem_db_lab` ADD CONSTRAINT `xchem_db_lab_solvent_data_id_03cb0a21_fk_xchem_db_` FOREIGN KEY (`solvent_data_id`) REFERENCES `xchem_db_solventtestingdata` (`id`);
ALTER TABLE `xchem_db_lab` ADD CONSTRAINT `xchem_db_lab_batch_id_6f16e012_fk_xchem_db_` FOREIGN KEY (`batch_id`) REFERENCES `xchem_db_batch` (`solventbatch_ptr_id`);
ALTER TABLE `xchem_db_dimple` ADD CONSTRAINT `xchem_db_dimple_pdb_path_mtz_path_639bfee5_uniq` UNIQUE (`pdb_path`, `mtz_path`);
ALTER TABLE `xchem_db_dimple` ADD CONSTRAINT `xchem_db_dimple_crystal_name_id_834a3404_fk_xchem_db_crystal_id` FOREIGN KEY (`crystal_name_id`) REFERENCES `xchem_db_crystal` (`id`);
ALTER TABLE `xchem_db_dimple` ADD CONSTRAINT `xchem_db_dimple_reference_id_d39e71b9_fk_xchem_db_reference_id` FOREIGN KEY (`reference_id`) REFERENCES `xchem_db_reference` (`id`);
--
-- Add field active to sourcewell
--
ALTER TABLE `xchem_db_sourcewell` ADD COLUMN `active` bool DEFAULT True NOT NULL;
ALTER TABLE `xchem_db_sourcewell` ALTER COLUMN `active` DROP DEFAULT;
--
-- Add field deactivation_date to sourcewell
--
ALTER TABLE `xchem_db_sourcewell` ADD COLUMN `deactivation_date` date NULL;
