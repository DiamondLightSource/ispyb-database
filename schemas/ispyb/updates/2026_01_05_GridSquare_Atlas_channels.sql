INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_01_05_GridSquare_Atlas_channels.sql ', 'ONGOING');

ALTER TABLE GridSquare
  ADD hasRed boolean DEFAULT 0
    COMMENT 'Whether region has red channel',
  ADD hasBlue boolean DEFAULT 0
    COMMENT 'Whether region has blue channel',
  ADD hasGreen boolean DEFAULT 0
    COMMENT 'Whether region has green channel',
  ADD hasYellow boolean DEFAULT 0
    COMMENT 'Whether region has yellow channel',
  ADD hasCyan boolean DEFAULT 0
    COMMENT 'Whether region has cyan channel',
  ADD hasMagenta boolean DEFAULT 0
    COMMENT 'Whether region has magenta channel',
  ADD hasGrey boolean DEFAULT 0
    COMMENT 'Whether region has grey channel',
  ADD mode enum('Bright Field and Fluorescent', 'Bright Field', 'Fluorescent', 'Tomography', 'Single Particle')
    COMMENT 'Collection mode',
  ALGORITHM=INSTANT;

ALTER TABLE Atlas
  ADD hasRed boolean DEFAULT 0
    COMMENT 'Whether atlas has red channel',
  ADD hasBlue boolean DEFAULT 0
    COMMENT 'Whether atlas has blue channel',
  ADD hasGreen boolean DEFAULT 0
    COMMENT 'Whether atlas has green channel',
  ADD hasYellow boolean DEFAULT 0
    COMMENT 'Whether atlas has yellow channel',
  ADD hasCyan boolean DEFAULT 0
    COMMENT 'Whether atlas has cyan channel',
  ADD hasMagenta boolean DEFAULT 0
    COMMENT 'Whether atlas has magenta channel',
  ADD hasGrey boolean DEFAULT 0
    COMMENT 'Whether atlas has grey channel',
  ADD mode enum('Bright Field and Fluorescent', 'Bright Field', 'Fluorescent', 'Tomography', 'Single Particle')
    COMMENT 'Collection mode',
  ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_01_05_GridSquare_Atlas_channels.sql';
