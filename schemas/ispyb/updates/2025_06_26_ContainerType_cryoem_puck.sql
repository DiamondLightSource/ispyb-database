INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_06_26_ContainerType_cryoem_puck.sql', 'ONGOING');

INSERT INTO ContainerType (
  containerTypeId, name, proposalType, active, capacity
) VALUES (
  38, 'Cryo-EM Puck', 'mx', 1, 12    
);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_06_26_ContainerType_cryoem_puck.sql';
