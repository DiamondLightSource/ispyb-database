INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_12_13_cryoEM_tracking.sql', 'ONGOING');

CREATE TABLE Atlas (
  atlasId int(11) unsigned auto_increment PRIMARY KEY,
  dataCollectionGroupId int(11) NOT NULL, -- foreign key
  atlasImage varchar(255) NOT NULL COMMENT 'path to atlas image',
  pixelSize float NOT NULL COMMENT 'pixel size of atlas image',
  CONSTRAINT Atlas_fk_dataCollectionGroupId
    FOREIGN KEY (dataCollectionGroupId)
      REFERENCES DataCollectionGroup (dataCollectionGroupId)
) COMMENT '';

CREATE TABLE GridSquare (
  gridSquareId int(11) unsigned auto_increment PRIMARY KEY,
  atlasId int(11) unsigned,
  gridSquareLabel int COMMENT 'grid square reference from acquisition software',
  gridSquareImage varchar(255) COMMENT 'path to grid square image',
  pixelLocationX int COMMENT 'pixel location of grid square centre on atlas image (x)',
  pixelLocationY int COMMENT 'pixel location of grid square centre on atlas image (y)',
  height int COMMENT 'grid square height on atlas image in pixels',
  width int COMMENT 'grid square width on atlas image in pixels',
  angle float COMMENT 'angle of grid square relative to atlas image',
  stageLocationX float COMMENT 'x stage position (microns)',
  stageLocationY float COMMENT 'y stage position (microns)',
  qualityIndicator float COMMENT 'metric for determining quality of grid square',
  pixelSize float COMMENT 'pixel size of grid square image',
  CONSTRAINT GridSquare_fk_atlasId
    FOREIGN KEY (atlasId)
      REFERENCES Atlas (atlasId)
) COMMENT '';

CREATE TABLE FoilHole (
  foilHoleId int(11) unsigned auto_increment PRIMARY KEY,
  gridSquareId int(11) unsigned,
  foilHoleLabel varchar(30) NOT NULL COMMENT 'foil hole reference name from acquisition software',
  foilHoleImage varchar(255) COMMENT 'path to foil hole image, nullable as there is not always a foil hole image',
  pixelLocationX int COMMENT 'pixel location of foil hole centre on grid square image (x)',
  pixelLocationY int COMMENT 'pixel location of foil hole centre on grid square image (y)',
  diameter int COMMENT 'foil hole diameter on grid square image in pixels',
  stageLocationX float COMMENT 'x stage position (microns)',
  stageLocationY float COMMENT 'y stage position (microns)',
  qualityIndicator float COMMENT 'metric for determining quality of foil hole',
  pixelSize float COMMENT 'pixel size of foil hole image',
  CONSTRAINT FoilHole_fk_gridSquareId
    FOREIGN KEY (gridSquareId)
      REFERENCES GridSquare (gridSquareId)
) COMMENT '';

ALTER TABLE Movie
  ADD foilHoleId int unsigned,
  ADD CONSTRAINT Movie_fk_foilHoleId
    FOREIGN KEY (foilHoleId)
      REFERENCES FoilHole (foilHoleId);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_12_13_cryoEM_tracking.sql';
