INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_06_30_zc_ZocaloBuffer.sql', 'ONGOING');

CREATE TABLE zc_ZocaloBuffer (
  `AutoProcProgramID` int(10) unsigned NOT NULL COMMENT 'Reference to an existing AutoProcProgram',
  `UUID` int(10) unsigned NOT NULL COMMENT 'AutoProcProgram-specific unique identifier',
  `Reference` int(10) unsigned DEFAULT NULL COMMENT 'Context-dependent reference to primary key IDs in other ISPyB tables',
  PRIMARY KEY (`AutoProcProgramID`,`UUID`),
  CONSTRAINT `AutoProcProgram_fk_AutoProcProgramId` FOREIGN KEY (`AutoProcProgramID`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE ON UPDATE CASCADE
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_06_30_zc_ZocaloBuffer.sql';
