INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_03_20_ParticleClassification_angularEfficiency_suggestedTilt.sql', 'ONGOING');

ALTER TABLE ParticleClassification ADD angularEfficiency double COMMENT 'Variation in resolution across different angles, 1-2sig/mean', ALGORITHM=INSTANT;
ALTER TABLE ParticleClassification ADD suggestedTilt double COMMENT 'Suggested stage tilt angle to improve angular efficiency. Unit: degrees', ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_03_20_ParticleClassification_angularEfficiency_suggestedTilt.sql';
