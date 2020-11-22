INSERT INTO SchemaStatus (scriptName, schemaStatus) VALUES ('20200731_autoprocprogram_nullable_iqi.sql', 'ONGOING');

ALTER TABLE `ImageQualityIndicators`
	CHANGE `autoProcProgramId` `autoProcProgramId` INT(10) UNSIGNED NULL COMMENT 'Foreign key to the AutoProcProgram table';

UPDATE SchemaStatus SET schemaStatus = 'DONE' where scriptName = '20200731_autoprocprogram_nullable_iqi.sql';
