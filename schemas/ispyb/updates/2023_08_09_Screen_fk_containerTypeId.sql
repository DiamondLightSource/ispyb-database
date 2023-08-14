INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_08_09_Screen_fk_containerTypeId.sql', 'ONGOING');

ALTER TABLE Screen
  ADD containerTypeId int(10) unsigned,
  ADD CONSTRAINT Screen_fk_containerTypeId FOREIGN KEY (containerTypeId) REFERENCES ContainerType(containerTypeId) ON UPDATE CASCADE ON DELETE RESTRICT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_08_09_Screen_fk_containerTypeId.sql';
