INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2019_11_27_BLSampleImage_tables.sql', 'ONGOING');

CREATE TABLE BLSampleImage_has_Score (
  blSampleImageId int(11) unsigned,
  blSampleImageScoreId int(11) unsigned,
  PRIMARY KEY (blSampleImageId, blSampleImageScoreId)
);

CREATE TABLE BLSampleImageScoreMethod (
  blSampleImageScoreMethodId int(11) unsigned auto_increment PRIMARY KEY,
  automatic tinyint(1) COMMENT '1: Automatic scoring process. 0: Scored by user.',
  methodName varchar(25) COMMENT 'name of the schema (hampton, marco, something else)',
  enabled tinyint(1) COMMENT 'whether this schema is enabled (this would allow multiple manual scoring schemas to exist simulatanously, again could be selectable in the ui)'
) COMMENT 'Info about the method of scoring';

ALTER TABLE BLSampleImageScore
  ADD blSampleImageScoreMethodId int(11) unsigned,
  ADD CONSTRAINT BLSampleImageScore_fk1 FOREIGN KEY (blSampleImageScoreMethodId) REFERENCES BLSampleImageScoreMethod(blSampleImageScoreMethodId) ON DELETE NO ACTION ON UPDATE CASCADE;

INSERT INTO BLSampleImageScoreMethod (
  blSampleImageScoreMethodId, automatic, methodName, enabled)
VALUES
  (1, 0, 'manual', 1),
  (2, 1, 'MARCO - clear', 1),
  (3, 1, 'MARCO - crystal', 1),
  (4, 1, 'MARCO - precipitant', 1),
  (5, 1, 'MARCO - other', 1);

-- Everything is manually scored at the moment, so:
UPDATE BLSampleImageScore SET blSampleImageScoreMethodId = 1;

-- Copy current scores from BLSampleImage into BLSampleImage_has_Score:
INSERT INTO BLSampleImage_has_Score (blSampleImageId, blSampleImageScoreId)
  SELECT blSampleImageId, blSampleImageScoreId
  FROM BLSampleImage
  WHERE blSampleImageScoreId IS NOT NULL;

-- Then remove the old score column to avoid confusion - this needs to be coordinated with deployment of a new SynchWeb release:
ALTER TABLE BLSampleImage
  DROP CONSTRAINT BLSampleImage_fk3,
  DROP blSampleImageScoreId;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2019_11_27_BLSampleImage_tables.sql';
