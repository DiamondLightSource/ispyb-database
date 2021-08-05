INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_08_05_MXMRRunBlob_update.sql', 'ONGOING');

ALTER TABLE MXMRRunBlob
  ADD `x` float DEFAULT NULL COMMENT 'Fractional x coordinate of blob in range [-1, 1]',
  ADD `y` float DEFAULT NULL COMMENT 'Fractional y coordinate of blob in range [-1, 1]',
  ADD `z` float DEFAULT NULL COMMENT 'Fractional z coordinate of blob in range [-1, 1]',
  ADD `height` float DEFAULT NULL COMMENT 'Blob height (sigmas)',
  ADD `occupancy` float DEFAULT NULL COMMENT 'Site occupancy factor in range [0, 1]',
  ADD `nearestAtomName` varchar(4) DEFAULT NULL COMMENT 'Name of nearest atom',
  ADD `nearestAtomChainId` varchar(2) DEFAULT NULL COMMENT 'Chain identifier of nearest atom',
  ADD `nearestAtomResName` varchar(4) DEFAULT NULL COMMENT 'Residue name of nearest atom',
  ADD `nearestAtomResSeq` mediumint unsigned DEFAULT NULL COMMENT 'Residue sequence number of nearest atom',
  ADD `nearestAtomDistance` float DEFAULT NULL COMMENT 'Distance in Angstrom to nearest atom'
;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_08_05_MXMRRunBlob_update.sql';
