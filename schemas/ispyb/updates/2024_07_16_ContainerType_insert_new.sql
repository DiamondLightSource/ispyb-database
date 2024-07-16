INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_07_16_ContainerType_insert_new.sql', 'ONGOING');

INSERT INTO ContainerType (containerTypeId, name, proposalType, active, capacity)
    VALUES
      (36, 'VMXm-Cartridge', 'mx', 1, 5),
      (37, 'VMXm-GridBox', 'mx', 1, 4);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_07_16_ContainerType_insert_new.sql';
