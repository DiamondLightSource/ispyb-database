--
-- Add field active to sourcewell
--
ALTER TABLE `xchem_db_sourcewell` ADD COLUMN `active` bool DEFAULT True NOT NULL;
ALTER TABLE `xchem_db_sourcewell` ALTER COLUMN `active` DROP DEFAULT;
--
-- Add field deactivation_date to sourcewell
--
ALTER TABLE `xchem_db_sourcewell` ADD COLUMN `deactivation_date` date NULL;
