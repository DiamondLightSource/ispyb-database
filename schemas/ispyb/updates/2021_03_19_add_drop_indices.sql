INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_03_19_add_drop_indices.sql', 'ONGOING');

-- Drop duplicate indexes and add some missing indices

ALTER TABLE `AutoProcScaling_has_Int` DROP INDEX `AutoProcScl_has_IntIdx1`;

ALTER TABLE `BLSample` DROP INDEX `BLSample_FKIndex2`;

ALTER TABLE `BLSession` 
 ADD UNIQUE KEY `proposalId` (`proposalId`,`visit_number`),
 DROP INDEX `Session_FKIndex1`;

ALTER TABLE `ContainerInspection` 
 ADD INDEX `ContainerInspection_idx4` (`containerId`,`scheduleComponentid`,`state`,`manual`),
 DROP INDEX `ContainerInspection_idx1`;

ALTER TABLE `Protein` DROP INDEX `Protein_FKIndex1`;

ALTER TABLE `Session_has_Person` DROP INDEX `Session_has_Person_FKIndex1`;

ALTER TABLE `ShippingHasSession` DROP INDEX `ShippingHasSession_FKIndex1`;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_03_19_add_drop_indices.sql';
