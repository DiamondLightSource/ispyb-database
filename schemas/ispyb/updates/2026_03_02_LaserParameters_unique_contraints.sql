INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_03_02_LaserParameters_unique_contraints.sql', 'ONGOING');

ALTER TABLE LaserParameters ADD CONSTRAINT LaserParameters_robotActionId_uc1 UNIQUE (robotActionId); 
ALTER TABLE LaserPoint ADD CONSTRAINT LaserPoint_laserParametersId_pointIndex_uc1 UNIQUE (laserParametersId, pointIndex); 

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_03_02_LaserParameters_unique_contraints.sql';
