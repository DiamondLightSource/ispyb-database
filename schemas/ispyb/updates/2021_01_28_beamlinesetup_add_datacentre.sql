INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_01_28_beamlinesetup_add_datacentre.sql', 'ONGOING');

ALTER TABLE `BeamLineSetup`
    ADD `preferredDataCentre` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Relevant datacentre to use to process data from this beamline';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '2021_01_28_beamlinesetup_add_datacentre.sql';
