INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_01_12_Container_and_ContainerHistory_update.sql', 'ONGOING');

ALTER TABLE Container
  ADD `currentDewarId` int(10) unsigned COMMENT 'The dewar with which the container is currently associated',
  ADD CONSTRAINT Container_fk_currentDewarId FOREIGN KEY (currentDewarId) REFERENCES Dewar(dewarId);

ALTER TABLE ContainerHistory
  ADD `currentDewarId` int(10) unsigned COMMENT 'The dewar with which the container was associated at the creation of this row',
  ADD CONSTRAINT ContainerHistory_fk_dewarId FOREIGN KEY (currentDewarId) REFERENCES Dewar(dewarId);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_01_12_Container_and_ContainerHistory_update.sql';
