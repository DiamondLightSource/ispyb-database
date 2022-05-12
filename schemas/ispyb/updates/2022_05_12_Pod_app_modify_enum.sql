INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_05_12_Pod_app_modify_enum.sql', 'ONGOING');

ALTER TABLE Pod
  MODIFY app enum('MAXIV HDF5 Viewer','H5Web', 'JNB') COLLATE utf8_unicode_ci NOT NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_05_12_Pod_app_modify_enum.sql';
