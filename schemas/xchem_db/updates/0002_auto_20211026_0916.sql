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
