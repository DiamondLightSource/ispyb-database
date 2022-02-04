INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_02_04_Pod.sql', 'ONGOING');

CREATE TABLE `Pod` (
  `podId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned NOT NULL COMMENT 'Pod owner defined by the logged in SynchWeb user who requested the pod start up',
  `filePath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'File or directory path to mount into the Pod if required',
  `app` enum('MAXIV HDF5 Viewer', 'H5Web') COLLATE utf8_unicode_ci NOT NULL,
  `podName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Generic text field intended for storing error messages related to status field',
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `shutdown` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`podId`),
  CONSTRAINT `Pod_fk1` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Status tracker for k8s pods launched from SynchWeb';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_02_04_Pod.sql';
