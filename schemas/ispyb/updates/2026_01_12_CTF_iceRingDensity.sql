INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_01_12_CTF_iceRingDensity.sql', 'ONGOING');

ALTER TABLE CTF
  ADD iceRingDensity float
    COMMENT 'Summed intensity of ice ring in fourier space',
  ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_01_12_CTF_iceRingDensity.sql';
